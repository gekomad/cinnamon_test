#!/bin/bash
#
(
  flock -n -x 200 || exit 1

  function git_pull() {
    echo "START git_pull SCRIPT $clone_dir $repo"

    cd $test_dir
    for d in */; do
      touch $d/terminated
    done

    if [ ! -d $clone_dir ]; then
      cd /home/geko/cinnamon_test
      git clone $repo
    else
      cd $clone_dir
      git pull --prune
    fi

    cd $clone_dir
    for br in $(git branch --all | grep "_test_"); do
      branch_name=$(echo $br | cut -f4 -d"/")
      clone_branch $branch_name
    done
    echo "END git_pull SCRIPT"
  }

  function clone_branch() {
    branch_name=$1
    printf "branch: $branch_name"
    if [ -d "$test_dir/$branch_name" ]; then
      printf " exists!\n"
      rm $test_dir/$branch_name/terminated 2>/dev/null
      return 0
    fi

    mkdir -p "$test_dir/$branch_name" && cd "$test_dir/$branch_name"

    cp -r $clone_dir .
    cd $project_name
    git checkout "_test_/$branch_name"
    cd src
    if [ $ARCH == "armv7l" ]; then
      make cinnamon32-ARM
    else
      make cinnamon64-ARM
    fi

  }

  function match() {
    dir=$(echo $1 | sed 's/[/]//g')
    echo "START MATCH SCRIPT on $dir"
    pgn_file=$dir-$id.pgn

    cd "$test_dir/$dir/$project_name"

    if [ -f $test_dir/$dir/terminated ]; then
      echo "terminated exists. Exit from MATCH script"
      return 0
    fi

    if [ -f $test_dir/$dir/suspend ]; then
      echo "suspend exists. Exit from MATCH script"
      return 0
    fi

    # load main cute_main_param
    . ~/cute_main_param
    # override main cute_main_param
    . cute_main_param
    
    current_games=$(grep Result $pgn_file | grep -v -c "*")
    if [ $current_games -ge $(($TOT_MATCH / $n_server)) ]; then
      echo "Played $current_games matches (>= $TOT_MATCH/$n_server). Exit from MATCH script"
      return
    fi
    missing_games=50 #$((($TOT_MATCH/$n_server-$current_games)/2))

    if [ $missing_games -ne 0 ]; then
      second=/home/geko/cinnamon_test/test/$dir/$project_name/src/cinnamon
      killall -s9 cutechess-cli 2>/dev/null

      parameters="-openings file=$opening_epd format=epd -engine cmd=$first $first_param -engine cmd=$second $second_param -each proto=uci tc=$tc -repeat -tournament gauntlet -pgnout $pgn_file -concurrency $concurrency -recover -rounds 2 
-games $missing_games -draw movenumber=100 movecount=60 score=0 $resign"

      echo "cutechess-cli $parameters"
      if [ $write_log -eq 1 ]; then
        cutechess-cli $parameters -debug $variant >/tmp/cute_$id.log 2>/tmp/cute_$id.err
      else
        cutechess-cli $parameters $variant >/dev/null 2>/dev/null
      fi
    fi

    echo "END MATCH SCRIPT"
  }

########### main ###############
  . ~/.bashrc
  . ~/cute_main_param
  if [ -f ~/STOP_CUTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ]; then
    echo "stop_cute exists. Exit!"
    exit 0
  fi
  export test_dir="/home/geko/cinnamon_test/test"  
  clone_dir="/home/geko/cinnamon_test/$project_name"

  array=($IPS)
  n_server="${#array[@]}"
  killall -s 9 cutechess-cli cc1plus cinnamon cinnamon20 2>/dev/null
  mkdir -p $test_dir 2>/dev/null
  git_pull
  cd $test_dir
  for d in */; do
    match $d
  done
) 200>/tmp/.cutelock



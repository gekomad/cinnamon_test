bash.sh "cd ~;git stash;rm -fr ~/.git;mv ~/.bashrc ~/.bashrc_old;rm -fr /tmp/cinnamon_test;cd /tmp;git clone https://github.com/gekomad/cinnamon_test.git ;mv /tmp/cinnamon_test/.git ~;cd ~; git checkout .; git pull --prune"



. ~/cute_main_param
find $home -name "*.pgn"  -exec echo {} \; -exec grep -c Result {} \; 2>/dev/null


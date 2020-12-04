free=$(vm_stat | tr -d '[ .]' | grep 'Pagesfree' | awk -F ':' '{print $2}')
used=$(vm_stat | tr -d '[ .]' | grep -E 'Pages(active|inactive|speculative|wireddown)' | awk -F ':' '{memory += $2} END {print memory}')
total=$((${free} + ${used}))
percent=$(echo "scale=3; ${used} / ${total} * 100" | bc)

echo ${percent}

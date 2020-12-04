#!/bin/bash
battery=$(pmset -g batt | tail -n 1 | awk '{print $3}' | sed -e 's/%;//')
is_charging=$(pmset -g batt | grep AC)

powers=(▉ ▊ ▋  ▍ ▎ ▏)

if [[ battery -le 100 && battery -gt 85 ]]; then
	power=${powers[0]}
elif [[ battery -gt 70 ]]; then
	power=${powers[1]}
elif [[ battery -gt 55 ]]; then
	power=${powers[2]}
elif [[ battery -ge 40 ]]; then
	power=${powers[3]}
elif [[ battery -gt 25 ]]; then
	power=${powers[4]}
elif [[ battery -gt 10 ]]; then
	power=${powers[5]}
else
	power=${powers[6]}
fi

if [[ battery -le 100 && battery -gt 60 ]]; then
	color="#[fg=green]"
elif [[ battery -gt 20 ]]; then
	color="#[fg=colour227]"
else
	color="#[fg=red]"
fi

if [[ -n ${is_charging} ]]; then
  charge="🔌 "
else
  charge=""
fi

result="${color}${battery}%#[default]${charge}|${power}|"

echo "${result}"

# vim:ft=zsh ts=2 sw=2 sts=2

if [ -z ${ZSH_THEME_ANDRES_LINK+x} ];then
	echo "Please set your LAN device is ZSH_THEME_ANDRES_LINK env var!. Default to enp0s7"
	ZSH_THEME_ANDRES_LINK="enp0s7"
fi

function get_ip(){
	echo $(ip addr show ${ZSH_THEME_ANDRES_LINK} | grep 'inet ' | awk -F'[ /]' '{print $6}')
}

function bat_status(){
	bat_name=$(upower -e | grep bat | head -n 1)
	is_battery=$(echo $bat_name | grep battery | wc -l)

	if [ $is_battery -eq 0 ];then
		echo "--%%"
		return
	fi

	bat_rate=$(upower -i $bat_name | grep percentage | awk '{print $2}')
	echo "$bat_rate%"
}


ZSH_THEME_GIT_PROMPT_PREFIX=" $FG[208]$FX[bold]"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[255]$FX[bold]%} #"

PROMPT='$FG[072]$FX[bold]($(hostname)):$(basename $PWD)%{$reset_color%}$(git_prompt_info) : '
RPROMPT='%{$fg_bold[white]%}$(get_ip) | $(bat_status)%{$reset_color%}'


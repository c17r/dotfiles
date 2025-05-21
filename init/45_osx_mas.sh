is_osx || return 1

[[ ! "$(type -P /usr/local/bin/mas)" ]] && e_error "Mac App Store applications need MAS to install" && return 1

mas_common=(
	866773894  # Quiver
	1262957439 # Textual
	1286743037 # Fenêtre
	413857545  # Divvy
	847496013  # Deckset
)

mas_play=(
	905384638  # filebot
	414957465  # Twitterrific
	467354146  # Subtitles theEditor
)

mas=(
	${mas_common[@]}
)

read -p "Include play? " Include_play
case $Include_play in
	y*|Y*)
		mas=(
			${mas[@]}
			${mas_play[@]}
		)
	;;
esac

mas=($(setdiff "${mas[*]}" "$(mas list 2>/dev/null)"))
if (( ${#mas[@]} > 0 )); then
	e_header "Installing mas applications: ${mas[*]}"
	for item in "${mas[@]}"; do
		mas install $item
	done
fi

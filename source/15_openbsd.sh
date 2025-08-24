
function openbsd-ssh-update() {
	ssh $1 'doas bash -c "syspatch && pkg_add -Uu"'
}
os_detection() {
	case $(uname -s | tr '[:upper:]' '[:lower:]') in
		*microsoft*)								C_OS='WSL';; # Must be first since WSL will have Linux in the name too
		*linux*)									C_OS='Linux';;
		*bsd* | *dragonfly*)						C_OS='BSD';;
		*sunos*)									C_OS='Solaris';;
		*darwin*)									C_OS='macOS';;
		*cygwin* | *mingw* | *msys* | *windows*)	C_OS='Windows';;
		*)											C_OS='Unknown'
	esac

	if [ $C_OS = 'Unknown' ]; then
		warn 'OS detection failed. Skipping.'
	else
		info "Detected OS: $C_OS."
		if [ $C_OS != 'Linux' ]; then
			warn 'Wayvifan is untested on your operating system.'
			debug 'Skipping distribution detection.'
		else
			C_DISTRO=$(cat /etc/*-release | grep -w PRETTY_NAME | cut -d= -f2 | tr -d '"')
			info "Detected distribution: $C_DISTRO."
		fi
	fi

	readonly C_OS C_DISTRO
}

gpu_detection() {
	if command -v lspci >/dev/null 2>&1; then
		_gpu=$(lspci | grep 'NVIDIA Corporation')
		if [ -n "$_gpu" ]; then
			info 'NVIDIA GPU detection succeeded.'
			_model=$(echo $_gpu | grep '\[' | cut -d '[' -f 2 | cut -d ']' -f 1)
			if [ -n "$_model" ]; then
				info "Detected GPU model: $_model."
			else
				warn 'GPU model detection failed.'
			fi
		else
			warn 'NVIDIA GPU detection failed.'
		fi
	else
		warn 'lspci detection failed. Skipping GPU detection.'
	fi
}

command_detection() {
	if command -v nvidia-settings >/dev/null 2>&1; then
		info 'nvidia-settings detection succeeded.'
	else
		fatal 'nvidia-settings detection failed. Wayvifan cannot work without it. Aborting.'
		return 1
	fi
}

detections() {
	info 'Starting detections.'

	os_detection
	gpu_detection
	command_detection || return

	info 'Detections done.'

	return 0
}

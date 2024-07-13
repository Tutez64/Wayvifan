#!/usr/bin/env sh

:> Wayvifan.sh

{
	printf '#!/usr/bin/env sh\n\n'
	cat src/conf.sh
	printf "\n\n"
	cat src/logs.sh
	< src/main.sh tail -n+3
} >> Wayvifan.sh

printf 'Build finished'

chmod +x Wayvifan.sh

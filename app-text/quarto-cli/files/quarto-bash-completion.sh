_quarto_basic_options(){
	case $prev in
		-o | --output)
			_filedir -d;;
		--log)
			_filedir;;
		--log-level)
			COMPREPLY=( $(compgen -W "${log_levels}" -- $cur) );;
		--log-format)
			COMPREPLY=( $(compgen -W "${log_formats}" -- $cur) );;
		*)
			;;
	esac
}
_quarto_render(){
	case $prev in
		render)
			_filedir "?(ipny|qmd)";;
		-o | --output |	--log | --log-level | --log-format)
			_quarto_basic_options;;
		-t | --to)
			COMPREPLY=( $(compgen -W "${render_formats}" -- $cur) );;
		-o | --output)
			_filedir;;
		--output-dir | --execute-dir)
			_filedir -d;;
		*)
			COMPREPLY=( $(compgen -W "${cmd_render}" -- $cur) );;
	esac
}
_quarto_preview(){
	case $prev in
		preview)
			_filedir "qmd";;
		-o | --output |	--log |	--log-level | --log-format)
			_quarto_basic_options;;
		--host)
			__known_hosts_real;;
		--port | --timeout)
			;;
		--render)
			COMPREPLY=( $(compgen -W "none ${render_formats}" -- $cur) );;
		*)
			COMPREPLY=( $(compgen -W "${cmd_preview}" -- $cur) );;
	esac
}
_quarto_serve(){
	case $prev in
		serve)
			_filedir "Rmd";;
		-o | --output |	--log |	--log-level | --log-format)
			_quarto_basic_options;;
		--host)
			__known_hosts_real;;
		--port)
			;;
		*)
			COMPREPLY=( $(compgen -W "${cmd_serve}" -- $cur) );;
	esac
}
_quarto_create_project(){
	case $prev in
		create-project)
			_filedir -d;;
		-o | --output |	--log |	--log-level | --log-format)
			_quarto_basic_options;;
		--title | --template | --no-scaffold)
			;;
		--type)
			COMPREPLY=( $(compgen -W "${proj_types}" -- $cur) );;
		--engine)
			COMPREPLY=( $(compgen -W "${engines}" -- $cur) );;
		--editor)
			COMPREPLY=( $(compgen -W "${editors}" -- $cur) );;
		*)
			COMPREPLY=( $(compgen -W "${cmd_create_project}" -- $cur) );;
	esac
}
_quarto_convert(){
	case $prev in
		convert)
			_filedir "?(ipny|qmd)";;
		-o | --output |	--log |	--log-level | --log-format)
			_quarto_basic_options;;
		*)
			COMPREPLY=( $(compgen -W "${cmd_convert}" -- $cur) );;
	esac
}
_quarto_inspect(){
	case $prev in
		inspect)
			_filedir;;
		-o | --output |	--log |	--log-level | --log-format)
			_quarto_basic_options;;
		*)
			__filedir
			;;
	esac
}
_quarto_install(){
	case $prev in
		install)
			_filedir;;
		-o | --output |	--log |	--log-level | --log-format)
			_quarto_basic_options;;
		*)
			__filedir;;
	esac
}
_quarto_publish(){
	case $prev in
		publish)
			_filedir;;
		-o | --output |	--log |	--log-level | --log-format)
			_quarto_basic_options;;
		*)
			COMPREPLY=( $(compgen -W "-h --help ${cmd_publish}" -- $cur) );;
	esac
}
_quarto_check(){
	if (( ${#COMP_WORDS[*]} == 3));then
		COMPREPLY=( $(compgen -W "-h --help ${cmd_check}" -- $cur) )
	fi
	}
_quarto_tools(){
	if (( ${#COMP_WORDS[*]} == 3));then
		COMPREPLY=( $(compgen -W "${cmd_tools} list" -- $cur) )
	elif(( ${#COMP_WORDS[*]} == 4));then
		if [[ $prev != "list" ]];then
			COMPREPLY=( $(compgen -W "${tools}" -- $cur) )
		fi
	fi
	}
_quarto()
{
	
	local cur prev words cword
	_init_completion

	local first=${COMP_WORDS[0]}
	local command=${COMP_WORDS[1]}

	infocommands="-h -V --help --version"
	subcommands="render preview serve create-project convert check tools \
	help run pandoc "
	subcommands_hidden="capabilities inspect install publish"
	basic_options="-h --help --log --log-level --log-format --quiet"
	log_levels="info warning error critical"
	log_formats="plain json-stream"
	engines="markdown jupyter knitr"
	editors="source visual"
	proj_types="book default website"
	#quarto capabilities
	render_formats="html pdf docx odt pptx beamer revealjs gfm hugo epub asciidoc \
	asciidoctor commonmark commonmark_x context docbook docbook4 docbook5 dokuwiki \
	dzslides epub2 epub3 fb2 haddock html4 html5 icml ipynb jats jats_archiving \
	jats_articleauthoring jats_publishing jira json latex man markdown \
	markdown_github markdown_mmd markdown_phpextra markdown_strict markua mediawiki \
	ms muse native opendocument opml org plain rst rtf s5 slideous slidy tei \
	texinfo textile xwiki zimwiki"
	themes="default cerulean cosmo cyborg darkly flatly journal litera lumen lux \
	materia minty morph pulse quartz sandstone simplex sketchy slate solar spacelab \
	superhero united vapor yeti zephyr"

	cmd_render="${basic_options} -t --to -o --output --output-dir -M --metadata \
	--site-url --execute -p --execute-param --execute-dir --execute-dir --execute-daemon \
	--execute-daemon-restart --execute-debug --use-freezer --cache --cache-refresh \
	--no-clean --debug"
	cmd_preview="${basic_options} --port --host --render --no-navigate --no-browser \
		--no-watch-inputs --timeout"
	cmd_serve="${basic_options} --no-render -p --port --host"
	cmd_create_proj="${basic_options} --title --type --template --engine --editor \
	--with-venv --with-condenv --no-scaffold"
	cmd_convert="${basic_options} -o -d --output --with-ids"
	cmd_check="install jupyter knitr all"
	cmd_tools="install uninstall update"
	cmd_publish="--token --server --id --no-render --no-prompt --no-browser"
	tools="tinytex chromium"

	if (( ${#COMP_WORDS[*]} == 2  )); then
		COMPREPLY=( $(compgen -W "${infocommands} ${subcommands} ${subcommands_hidden}" -- $cur) )
		return
	else
		if (( ${#COMP_WORDS[*]} == 3 )) &&  [[ $command != "run" ]];then
			case $cur in
				-*)
					COMPREPLY=( $(compgen -W "-h --help" -- $cur) )
					return;;
				*)
					;;
			esac
		fi
		case $command in 
			help)
				COMPREPLY=( $(compgen -W "${subcommands} " -- $cur) )
				return;;
			render)
				_quarto_render
				return;;
			preview)
				_quarto_preview
				return;;
			serve)
				_quarto_serve
				return;;
			create-project)
				_quarto_create_project
				return;;
			convert)
				_quarto_convert
				return;;
			check)
				_quarto_check
				return;;
			tools)
				_quarto_tools
				return;;
			inspect)
				_quarto_inspect
				return;;
			install)
				_quarto_install
				return;;
			publish)
				_quarto_publish
				return;;
			run)
				_filedir ?(ts|py|R|lua)
				return;;
			pandoc)
				#This just runs pandoc
				#should just run pandoc completion
				return;;
		esac
	fi

} &&	complete -F _quarto quarto

#!/bin/bash

# Default settings
REPO=${REPO:-yikun/gitment}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-gh-pages}

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

info() {
	echo ${BLUE}"$@"${RESET} >&2
}

success() {
	echo ${GREEN}"$@"${RESET} >&2
}

error() {
	echo ${RED}"Error: $@"${RESET} >&2
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

main() {

    setup_color

    command_exists npm || {
		error "node is not installed"
		exit 1
	}
    
    if ! npm list --depth=0 | grep hexo >/dev/null 2>&1 || [ ! -d './node_modules/gitment' ]; then
        error "hexo is not installed under current floder"
        exit 1
    fi

    command_exists git || {
		error "Git is not installed"
		exit 1
	}

    if [ "$OSTYPE" = cygwin ] && git --version | grep -q msysgit; then
		error "Windows/MSYS Git is not supported on Cygwin"
		error "make sure the Cygwin git package is installed and is first on the \$PATH"
		exit 1
	fi

    git clone -c core.eol=lf -c core.autocrlf=false \
		-c fsck.zeroPaddedFilemode=ignore \
		-c fetch.fsck.zeroPaddedFilemode=ignore \
		-c receive.fsck.zeroPaddedFilemode=ignore \
		--branch "$BRANCH" "$REMOTE" || {
		error "git clone of $REPO repo failed"
		exit 1
	}

    cd gitment

    info "Install dependency..."

    npm install

    info "Build gitment..."

    npm run build

    info "Overwrite gitment..."

    cp -R dist  ../node_modules/gitment/

    info "Clean package..."

    cd .. && rm -rf gitment

    success "Done"

}

main
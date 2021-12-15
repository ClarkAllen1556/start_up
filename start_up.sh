#!/bin/sh

# Comment out uneeded software packages.
# If wish to add package, add to end off softare array and add install script to case block
# INSTALLATION IS ORDER DEPENDENT. For most programs, homebrew is needed for installation.
software=(
    homebrew
    asdf
    hyper
    elixir
    git
    nvm
    pgadmin4
    dash
    neovim
    sublime-text
)

gitUsername="ClarkAllen1556"
gitEmail="allenclark@u.boisestate.edu"

echo ">> Setting following needed software:"  ${software[*]}

isInstalled () {
    if which -s $1; then
        true
    elif brew ls --cask $1 &> /dev/null; then # if there is no console command check brew casks
        true
    else
        false
    fi
}

for sf in "${software[@]}"; do
    SECONDS=0
    echo ">> Installing" $sf

    case $sf in
        homebrew)
            if isInstalled brew; then
                echo ">> Homebrew already installed > skip"
                continue
            fi

            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
        asdf)
            if isInstalled asdf; then
                echo ">> ASDF already installed > skip"
                continue
            fi

            brew install asdf
            echo "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
        ;;
        hyper)
            if isInstalled hyper; then
                echo ">> ASDF already installed > skip"
                continue
            fi

            brew install --cask hyper

            # solarized theme
            echo ">> Setting theme"
            hyper i hyper-solarized-light
            # prompt
            echo ">> Setting prompt"
            echo "\n PROMPT=\"%B%F{1}%n%f%b%F{8}@%f%F{24}%m%f%B%F{8}%d%f%b%F{8}:~$%f \"" >> ${ZDOTDIR:-~}/.zshrc
        ;;
        elixir)
            if isInstalled elixir; then
                echo ">> elixir already installed > skip"
                continue
            fi

            brew install elixir
        ;;
        git)
            git config --global user.name $gitUsername
            git config --global user.email $gitEmail

            echo ">> Git config"
            git config --global -l
        ;;
        nvm)
            # if nvm -v &> /dev/null; then # which -s nvm doesn't return path
            #     echo ">> nvm already installed > skip"
            #     continue
            # fi

            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        ;;
        pgadmin4)
            if isInstalled pgadmin4; then
                echo ">> pgadmin already installed > skip"
                continue
            fi

            brew install --cask pgadmin4
        ;;
        dash)
            if isInstalled dash; then
                echo ">> dash already installed > skip"
                continue
            fi

            brew install --cask dash
        ;;
        neovim)
            if isInstalled nvim; then # command is different from package name
                echo ">> neovim already installed > skip"
                continue
            fi

            brew install neovim
        ;;
        sublime-text)
            if isInstalled subl; then # command is different from package name
                echo ">> sublime already installed > skip"
                continue
            fi

            brew install --cask sublime-text
        ;;
    esac

    duration=$SECONDS
    echo ">> completed install of" $sf "in" "$(($duration / 60)) minutes and $(($duration % 60)) seconds"
done

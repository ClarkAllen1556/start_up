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
)

gitUsername="ClarkAllen1556"
gitEmail="allenclark@u.boisestate.edu"

echo ">> Setting following needed software:"  ${software[*]}

for sf in "${software[@]}"; do
    SECONDS=0
    echo ">> Installing" $sf
    case $sf in
        homebrew)
            if command -v brew &> /dev/null
            then
                echo ">> Homebrew already installed > skip"
                continue
            fi

            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
        asdf)
            if command -v asdf &> /dev/null
            then
                echo ">> ASDF already installed > skip"
                continue
            fi

            brew install asdf
            echo "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
        ;;
        hyper)
            if command -v hyper &> /dev/null
            then
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
            if command -v elixir &> /dev/null
            then
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
            if command -v nvm &> /dev/null
            then
                echo ">> nvm already installed > skip"
                continue
            fi

            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        ;;
    esac

    duration=$SECONDS
    echo ">> completed install of" $sf "in" "$(($duration / 60)) minutes and $(($duration % 60)) seconds"
done

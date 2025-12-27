#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # Pas de couleur (Reset)

draw_banner() {
    clear
    echo -e "${BLUE}${BOLD}"
    echo "  █████╗ ██████╗ ██████╗ ███████╗██████╗  █████╗ "
    echo " ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗"
    echo " ███████║██████╔╝██████╔╝█████╗  ██████╔╝███████║"
    echo " ██╔══██║██╔══██╗██╔══██╗██╔══╝  ██╔══██╗██╔══██║"
    echo " ██║  ██║██║  ██║██║  ██║███████╗██║  ██║██║  ██║"
    echo " ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝"
    echo -e "${CYAN}"
    echo " ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗"
    echo " ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝"
    echo " ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝ "
    echo " ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗ "
    echo " ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗"
    echo "╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝"
    echo -e "${NC}"
}

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}Error: This script must be run as root${NC}"
        exit 1
    fi
}

install_repo(){
    if [ -f "./install_repos.sh" ]; then
        chmod +x ./install_repos.sh
        ./install_repos.sh
        dnf update -y
    else
        echo -e "${RED}Erreur: Le script install_repos.sh est introuvable.${NC}"
        echo -e "${YELLOW}Veuillez créer ce script pour définir vos dépôts.${NC}"
        read -p "Appuyez sur Entrée pour continuer..."
    fi
}

install_app(){
    # Installation des paquets depuis app.txt
    if [ -s "app.txt" ]; then
        echo -e "${YELLOW}Installation des applications listées dans app.txt...${NC}"
        dnf install -y $(cat app.txt)
    else
        echo -e "${YELLOW}Fichier app.txt manquant ou vide. Ignoré.${NC}"
    fi

    # Suppression des paquets depuis remove.txt
    if [ -s "remove.txt" ]; then
        echo -e "${YELLOW}Suppression des applications listées dans remove.txt...${NC}"
        dnf remove -y $(cat remove.txt)
    else
        echo -e "${YELLOW}Fichier remove.txt manquant ou vide. Ignoré.${NC}"
    fi

    # Installation des paquets Flatpak depuis flatpack.txt
    if [ -s "flatpack.txt" ]; then
        if command -v flatpak &> /dev/null; then
            echo -e "${YELLOW}Installation des paquets Flatpak listés dans flatpack.txt...${NC}"
            flatpak install -y $(cat flatpack.txt)
        else
            echo -e "${RED}Erreur : Flatpak n'est pas installé. Impossible de traiter flatpack.txt.${NC}"
        fi
    else
        echo -e "${YELLOW}Fichier flatpack.txt manquant ou vide. Ignoré.${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..."
}

update(){
    dnf update -y
    flatpak update -y
    read -p "Appuyez sur Entrée pour continuer..."
}

conf_sys(){
    if [ -f "./configure_system.sh" ]; then
        chmod +x ./configure_system.sh
        ./configure_system.sh
        echo -e "${GREEN}Configuration du système terminée.${NC}"
        echo -e "${YELLOW}Veuillez redémarrer votre système pour appliquer les modifications.${NC}"
        read -p "Appuyez sur Entrée pour continuer..."
    else
        echo -e "${RED}Erreur: Le script configure_system.sh est introuvable.${NC}"
        echo -e "${YELLOW}Veuillez créer ce script pour définir vos dépôts.${NC}"
        read -p "Appuyez sur Entrée pour continuer..."
    fi
}

menu(){
    echo -e "${BLUE} ╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE} ║${BOLD}                  MENU DE CONFIGURATION                     ${NC}${BLUE}║${NC}"
    echo -e "${BLUE} ╠════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${BLUE} ║${NC}                                                            ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[1]${NC} Installer les dépôts                                  ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[2]${NC} Installer et supprimer les applications               ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[3]${NC} Mettre à jour le système                              ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[4]${NC} Configuration du système                              ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[5]${NC} Installation des depost, application et configuration ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${RED}[6]${NC} reboot                                                ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}                                                            ${BLUE}║${NC}"
    echo -e "${BLUE} ╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    read -p "Entrez votre choix (1-4): " choix

    case $choix in
        1) install_repo ;;
        2) install_app ;;
        3) echo "Not implemented yet" ;;
        4) echo "Not implemented yet" ;;
        5) install_repo && install_app && echo "Not implemented yet" ;;
        6) reboot ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
}

main() {
    draw_banner
    check_root
    menu
}

main
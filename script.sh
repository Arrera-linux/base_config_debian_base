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

menu(){
    echo -e "${BLUE} ╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE} ║${BOLD}                  MENU DE CONFIGURATION                     ${NC}${BLUE}║${NC}"
    echo -e "${BLUE} ╠════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${BLUE} ║${NC}                                                            ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[1]${NC} Installer les dépôts                                  ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[2]${NC} Installer et supprimer les applications               ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${GREEN}[3]${NC} Mettre à jour le système                              ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}  ${RED}[4]${NC} Quitter                                               ${BLUE}║${NC}"
    echo -e "${BLUE} ║${NC}                                                            ${BLUE}║${NC}"
    echo -e "${BLUE} ╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

main() {
    draw_banner
    check_root
    menu
}

main
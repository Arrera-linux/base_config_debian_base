[English](readme_en.md)

# Base Config 

Ce projet a pour but de fournir une base modulaire pour créer des scripts d'installation et de configuration d'environnement sur Linux (spécifiquement distribution base sur Debian). Il permet d'automatiser l'installation de dépôts, de paquets, d'applications Flatpak et la configuration système via une interface menu ou des fichiers de configuration simples.

## Prérequis

*   **OS** : Debian, Linux MINT et Pop_OS! (Uniquement pour les dépôts)
*   **Droits** : Le script principal doit être exécuté en tant que **root** (administrateur).

## Utilisation

1.  Rendez le script principal exécutable (si ce n'est pas déjà fait) :
    ```bash
    chmod +x script.sh
    ```
2.  Lancez le script avec les privilèges root :
    ```bash
    sudo ./script.sh
    ```
3.  Un menu interactif s'affichera, vous permettant de choisir les actions à effectuer (installation des dépôts, des applications, configuration système, etc.).

## Configuration des fichiers

Le script s'appuie sur plusieurs fichiers présents dans le même répertoire pour savoir quoi installer ou configurer. Voici comment rédiger chacun d'eux.

### 1. `install_repos.sh`
Ce fichier est un **script Bash** exécuté pour installer les dépôts supplémentaires (comme RPM Fusion).

*   **Format** : Script shell standard.
*   **Exemple** :
    ```bash
    #!/bin/bash
    echo "Installation des dépôts supplémentaires..."
    
    # Ajouter Debian Backports
    echo "Ajout de Debian Backports..."
    apt-add-repository -y "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main contrib non-free"
    
    # Ajouter des dépôts tiers (exemple: Docker)
    echo "Ajout du dépôt Docker..."
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
    apt-add-repository -y "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    
    # Mettre à jour la liste des paquets
    apt-get update
    ```

### 2. `app.txt` & `remove.txt`
Ces fichiers contiennent la liste des paquets DNF à **installer** (`app.txt`) ou à **supprimer** (`remove.txt`).

*   **Format** : Une liste de noms de paquets, séparés par des espaces ou des sauts de ligne.
*   **Exemple pour `app.txt`** :
    ```text
    git vim htop
    curl wget
    vlc firefox
    ```

### 3. `flatpack.txt`
Ce fichier contient la liste des applications **Flatpak** à installer.

*   **Format** : Une liste d'identifiants d'applications Flatpak (Application ID), séparés par des espaces ou des sauts de ligne.
*   **Note** : Flatpak doit être installé sur le système pour que cela fonctionne.
*   **Exemple** :
    ```text
    org.gimp.GIMP
    com.spotify.Client
    org.videolan.VLC
    ```

### 4. `configure_system.sh`
Ce fichier est un **script Bash** exécuté à la fin pour appliquer des configurations système spécifiques (pare-feu, services, utilisateurs, etc.).

*   **Format** : Script shell standard.
*   **Exemple** :
    ```bash
    #!/bin/bash
    echo "Activation du Pare-feu..."
    systemctl enable --now firewalld
    
    echo "Configuration de Git..."
    git config --system user.name "MonNom"
    
    ```
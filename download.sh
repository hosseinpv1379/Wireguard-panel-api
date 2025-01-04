#!/bin/bash

LIGHT_RED="\033[1;31m"
LIGHT_GREEN="\033[1;32m"
LIGHT_YELLOW="\033[1;33m"
LIGHT_BLUE="\033[1;34m"
CYAN="\033[0;36m"
NC="\033[0m"  

prompt_action() {
    echo -e "${CYAN}Do you want to update or install?${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo -e "${LIGHT_YELLOW}1)${LIGHT_GREEN} Update${NC}"
    echo -e "${LIGHT_YELLOW}2)${NC} Install/Reinstall${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    read -p "Enter (1 or 2): " ACTION_CHOICE
}

update_files() {
    REPO_URL="https://github.com/Azumi67/Wireguard-panel.git"
    TMP_DIR="/tmp/wireguard-panel-update"
    SCRIPT_DIR="/usr/local/bin/Wireguard-panel"

    echo -e "${CYAN}Updating Wireguard Panel...${NC}"

    if [ -d "$TMP_DIR" ]; then
        echo -e "${LIGHT_YELLOW}Removing existing temporary directory...${NC}"
        sudo rm -rf "$TMP_DIR"
    fi

    echo -e "${LIGHT_YELLOW}Cloning repository...${NC}"
    git clone "$REPO_URL" "$TMP_DIR"

    if [ $? -ne 0 ]; then
        echo -e "${LIGHT_RED}[Error]: Failed to clone repository.${NC}"
        return
    fi

    echo -e "${CYAN}Replacing files...${NC}"

    if [ -f "$TMP_DIR/src/app.py" ]; then
        sudo mv "$TMP_DIR/src/app.py" "$SCRIPT_DIR/src/" && echo -e "${LIGHT_GREEN}✔ Updated: app.py${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: app.py${NC}"
    else
        echo -e "${LIGHT_RED}[Error]: app.py not found in repository.${NC}"
    fi

    if [ -d "$TMP_DIR/src/static" ]; then
        sudo rm -rf "$SCRIPT_DIR/src/static"
        sudo mv "$TMP_DIR/src/static" "$SCRIPT_DIR/src/" && echo -e "${LIGHT_GREEN}✔ Updated: static${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: static${NC}"
    else
        echo -e "${LIGHT_RED}[Error]: static directory not found in repository.${NC}"
    fi

    if [ -d "$TMP_DIR/src/templates" ]; then
        sudo rm -rf "$SCRIPT_DIR/src/templates"
        sudo mv "$TMP_DIR/src/templates" "$SCRIPT_DIR/src/" && echo -e "${LIGHT_GREEN}✔ Updated: templates${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: templates${NC}"
    else
        echo -e "${LIGHT_RED}[Error]: templates directory not found in repository.${NC}"
    fi

    if [ -f "$TMP_DIR/src/telegram/robot.py" ]; then
        sudo mv "$TMP_DIR/src/telegram/robot.py" "$SCRIPT_DIR/telegram/" && echo -e "${LIGHT_GREEN}✔ Updated: telegram/robot.py${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: telegram/robot.py${NC}"
    else
        echo -e "${LIGHT_RED}[Error]: telegram/robot.py not found in repository.${NC}"
    fi

    if [ -f "$TMP_DIR/src/telegram/robot-fa.py" ]; then
        sudo mv "$TMP_DIR/src/telegram/robot-fa.py" "$SCRIPT_DIR/telegram/" && echo -e "${LIGHT_GREEN}✔ Updated: telegram/robot-fa.py${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: telegram/robot-fa.py${NC}"
    else
        echo -e "${LIGHT_RED}[Error]: telegram/robot-fa.py not found in repository.${NC}"
    fi

    if [ -f "$TMP_DIR/src/setup.sh" ]; then
        sudo mv "$TMP_DIR/src/setup.sh" "$SCRIPT_DIR/" && echo -e "${LIGHT_GREEN}✔ Updated: setup.sh${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: setup.sh${NC}"
        sudo chmod +x "$SCRIPT_DIR/setup.sh" && echo -e "${LIGHT_GREEN}✔ setup.sh is now executable.${NC}" || echo -e "${LIGHT_RED}✘ Failed to make setup.sh executable.${NC}"
    else
        echo -e "${LIGHT_RED}[Error]: setup.sh not found in repository.${NC}"
    fi

    echo -e "${CYAN}Cleaning up temporary files...${NC}"
    sudo rm -rf "$TMP_DIR" && echo -e "${LIGHT_GREEN}✔ Temporary files removed.${NC}" || echo -e "${LIGHT_RED}✘ Failed to remove temporary files.${NC}"

    read -p "$(echo -e "${CYAN}Press Enter to re-run the updated setup.sh...${NC}")"
    bash "$SCRIPT_DIR/setup.sh"
    if [ $? -ne 0 ]; then
        echo -e "${LIGHT_RED}✘ Running setup.sh failed. Please check the script for errors.${NC}"
        return
    fi
    echo -e "${LIGHT_GREEN}✔ setup.sh ran successfully.${NC}"

    echo -e "${LIGHT_GREEN}Update completed successfully!${NC}"
}



reinstall() {
    TARGET_DIR="/usr/local/bin/Wireguard-panel"
    REPO_URL="https://github.com/Azumi67/Wireguard-panel.git"

    echo -e "${LIGHT_YELLOW}Reinstalling... Removing old setup directory.${NC}"
    sudo rm -rf "$TARGET_DIR"
    echo -e "${LIGHT_BLUE}Cloning Wireguard-panel repo into $TARGET_DIR...${NC}"
    sudo git clone "$REPO_URL" "$TARGET_DIR"
    echo -e "${LIGHT_GREEN}Reinstall complete.${NC}"
}

create_wire_script() {
    WIRE_SCRIPT="/usr/local/bin/wire"

    echo -e "${CYAN}Recreating the 'wire' script...${NC}"

    sudo rm -f "$WIRE_SCRIPT"

    echo -e "#!/bin/bash" | sudo tee "$WIRE_SCRIPT" > /dev/null
    echo -e "cd /usr/local/bin/Wireguard-panel/src && sudo ./setup.sh" | sudo tee -a "$WIRE_SCRIPT" > /dev/null

    echo -e "${CYAN}Making 'wire' script runable...${NC}"
    sudo chmod +x "$WIRE_SCRIPT" && echo -e "${LIGHT_GREEN}✔ 'wire' script is now executable.${NC}" || echo -e "${LIGHT_RED}✘ making 'wire' script executable wasn't possible.${NC}"
}

main() {
    prompt_action  

    if [ "$ACTION_CHOICE" -eq 2 ]; then
        reinstall
    else
        update_files
    fi

    create_wire_script

    echo -e "${LIGHT_GREEN}Process complete.${NC}"
}

main

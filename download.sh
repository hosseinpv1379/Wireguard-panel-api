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
    echo -e "${LIGHT_YELLOW}2)${LIGHT_RED} Install/Reinstall${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    read -p "Enter (1 or 2): " ACTION_CHOICE
}

update_files() {
    REPO_URL="https://github.com/Azumi67/Wireguard-panel.git"
    TMP_DIR="/tmp/wireguard-panel-update"
    SCRIPT_DIR="/usr/local/bin/Wireguard-panel"

    echo -e "${CYAN}Updating Wireguard Panel...${NC}"

    if [ -d "$TMP_DIR" ]; then
        echo -e "${LIGHT_YELLOW}Pulling latest changes...${NC}"
        git -C "$TMP_DIR" pull
    else
        echo -e "${LIGHT_YELLOW}Cloning repo...${NC}"
        git clone "$REPO_URL" "$TMP_DIR"
    fi

    if [ $? -ne 0 ]; then
        echo -e "${LIGHT_RED}[Error]: Clone or pull from repo failed.${NC}"
        return
    fi

    echo -e "${CYAN}Replacing files...${NC}"

    cp "$TMP_DIR/src/app.py" "$SCRIPT_DIR/" && echo -e "${LIGHT_GREEN}✔ Updated: app.py${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: app.py${NC}"
    cp -r "$TMP_DIR/src/templates" "$SCRIPT_DIR/" && echo -e "${LIGHT_GREEN}✔ Updated: templates${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: templates${NC}"
    cp -r "$TMP_DIR/src/static" "$SCRIPT_DIR/" && echo -e "${LIGHT_GREEN}✔ Updated: static${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: static${NC}"

    if [ ! -d "$SCRIPT_DIR/telegram" ]; then
        echo -e "${LIGHT_YELLOW}Creating telegram directory...${NC}"
        sudo mkdir -p "$SCRIPT_DIR/telegram"
    fi

    cp "$TMP_DIR/src/telegram/robot.py" "$SCRIPT_DIR/telegram/" && echo -e "${LIGHT_GREEN}✔ Updated: telegram/robot.py${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: telegram/robot.py${NC}"
    cp "$TMP_DIR/src/telegram/robot-fa.py" "$SCRIPT_DIR/telegram/" && echo -e "${LIGHT_GREEN}✔ Updated: telegram/robot-fa.py${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: telegram/robot-fa.py${NC}"

    echo -e "${LIGHT_YELLOW}Skipping update for other telegram files (telegram.yaml, config.json)...${NC}"

    cp -r "$TMP_DIR/src/setup.sh" "$SCRIPT_DIR/" && echo -e "${LIGHT_GREEN}✔ Updated: setup.sh${NC}" || echo -e "${LIGHT_RED}✘ Failed to update: setup.sh${NC}"

    echo -e "${CYAN}Making setup.sh runnable...${NC}"
    chmod +x "$SCRIPT_DIR/setup.sh" && echo -e "${LIGHT_GREEN}✔ setup.sh is now runnable.${NC}" || echo -e "${LIGHT_RED}✘ making setup.sh executable wasn't possible.${NC}"

    read -p "$(echo -e "${CYAN}Press Enter to re-run the updated setup.sh...${NC}")"
    bash "$SCRIPT_DIR/setup.sh"
    if [ $? -ne 0 ]; then
        echo -e "${LIGHT_RED}✘ Running setup.sh failed. Please check the script for errors.${NC}"
        return
    fi
    echo -e "${LIGHT_GREEN}✔ setup.sh ran successfully.${NC}"

    echo -e "${CYAN}Restarting services...${NC}"
    systemctl restart wireguard-panel && echo -e "${LIGHT_GREEN}✔ Restarted: wireguard-panel service${NC}" || echo -e "${LIGHT_RED}✘ Failed to restart: wireguard-panel service${NC}"

    if systemctl is-active --quiet telegram-bot-fa.service; then
        systemctl restart telegram-bot-fa.service && echo -e "${LIGHT_GREEN}✔ Restarted: telegram-bot-fa service${NC}" || echo -e "${LIGHT_RED}✘ Failed to restart: telegram-bot-fa service${NC}"
    elif systemctl is-active --quiet telegram-bot-en.service; then
        systemctl restart telegram-bot-en.service && echo -e "${LIGHT_GREEN}✔ Restarted: telegram-bot-en service${NC}" || echo -e "${LIGHT_RED}✘ Failed to restart: telegram-bot-en service${NC}"
    else
        echo -e "${LIGHT_YELLOW}No active Telegram bot service found.${NC}"
    fi

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

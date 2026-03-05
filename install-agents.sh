#!/bin/bash

# TRON Agents Installer for Claude Code
# Interactive script to install/uninstall TRON agents

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_DIR="$SCRIPT_DIR/agents"
GLOBAL_AGENTS_DIR="$HOME/.claude/agents"
LOCAL_AGENTS_DIR=".claude/agents"
CLAUDE_AGENTS_DIR=""
INSTALL_MODE=""

GITHUB_RAW_BASE="https://raw.githubusercontent.com/transatron/awesome-tron-agents/main"

# Agent definitions (name, file, description)
AGENT_FILES=(
  "tron-architect.md"
  "tron-developer-tronweb.md"
  "tron-integrator-trc20.md"
  "tron-integrator-shieldedusdt.md"
  "tron-integrator-usdt0.md"
  "transatron-architect.md"
  "transatron-integrator.md"
)
AGENT_NAMES=(
  "tron-architect"
  "tron-developer-tronweb"
  "tron-integrator-trc20"
  "tron-integrator-shieldedusdt"
  "tron-integrator-usdt0"
  "transatron-architect"
  "transatron-integrator"
)
AGENT_DESCS=(
  "TRON architecture — resource model, fee optimization, smart contract strategy"
  "TronWeb SDK — DApps, transactions, wallets, general patterns"
  "TRC-20 tokens — transfer, approve, transferFrom, energy estimation, USDT handling"
  "Shielded TRC-20 — zk-SNARK privacy, mint/transfer/burn"
  "USDT0 (LayerZero OFT) — cross-chain bridging to ETH/SOL/TON"
  "Transatron architecture — integration patterns, payment modes, trade-offs"
  "Transatron implementation — fee payments, coupons, delayed transactions"
)

has_local_claude_dir() {
    [[ -d ".claude" ]]
}

has_local_agents() {
    [[ -d "$AGENTS_DIR" ]]
}

show_header() {
    clear
    echo -e "${BOLD}${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              TRON Agents Installer                         ║"
    echo "║          TronWeb & Transatron for Claude Code               ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    if [[ -n "$INSTALL_MODE" ]]; then
        local mode_str=""
        if [[ "$INSTALL_MODE" == "global" ]]; then
            mode_str="Global (~/.claude/agents/)"
        else
            mode_str="Local (.claude/agents/)"
        fi
        echo -e "${BLUE}Mode: ${mode_str}${NC}\n"
    fi
}

select_install_mode() {
    show_header
    echo -e "${BOLD}Select installation mode:${NC}\n"
    echo -e "  ${YELLOW}1)${NC} Global installation ${CYAN}(~/.claude/agents/)${NC}"
    echo -e "     Available for all projects"
    echo ""

    if has_local_claude_dir; then
        echo -e "  ${YELLOW}2)${NC} Local installation ${CYAN}(.claude/agents/)${NC}"
        echo -e "     Only for current project"
    else
        echo -e "  ${BLUE}2)${NC} Local installation ${CYAN}(not available)${NC}"
        echo -e "     ${YELLOW}No .claude/ directory found in current directory${NC}"
    fi
    echo ""
    echo -e "  ${YELLOW}q)${NC} Quit"
    echo ""

    read -p "Enter your choice: " choice

    case "$choice" in
        1)
            CLAUDE_AGENTS_DIR="$GLOBAL_AGENTS_DIR"
            INSTALL_MODE="global"
            mkdir -p "$CLAUDE_AGENTS_DIR"
            ;;
        2)
            if has_local_claude_dir; then
                CLAUDE_AGENTS_DIR="$LOCAL_AGENTS_DIR"
                INSTALL_MODE="local"
                mkdir -p "$CLAUDE_AGENTS_DIR"
            else
                echo -e "\n${RED}Local installation not available. No .claude/ directory found.${NC}"
                sleep 2
                select_install_mode
                return
            fi
            ;;
        q|Q)
            echo -e "\n${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please try again.${NC}"
            sleep 1
            select_install_mode
            ;;
    esac
}

install_agent() {
    local agent_file="$1"

    # Try local copy first
    if [[ -f "$AGENTS_DIR/$agent_file" ]]; then
        cp "$AGENTS_DIR/$agent_file" "$CLAUDE_AGENTS_DIR/$agent_file"
        return 0
    fi

    # Fall back to remote download
    if command -v curl &> /dev/null; then
        local url="$GITHUB_RAW_BASE/agents/$agent_file"
        if curl -sS "$url" -o "$CLAUDE_AGENTS_DIR/$agent_file" 2>/dev/null; then
            return 0
        fi
    fi

    return 1
}

select_agents() {
    local agent_states=()

    # Initialize states based on current installation
    for agent_file in "${AGENT_FILES[@]}"; do
        if [[ -f "$CLAUDE_AGENTS_DIR/$agent_file" ]]; then
            agent_states+=(1)
        else
            agent_states+=(0)
        fi
    done

    while true; do
        show_header
        echo -e "${BOLD}Available TRON Agents:${NC}\n"
        echo -e "Use number keys to toggle selection. ${GREEN}[✓]${NC} = will be installed, ${RED}[ ]${NC} = will be removed\n"

        local i=1
        for idx in "${!AGENT_FILES[@]}"; do
            local agent_file="${AGENT_FILES[$idx]}"
            local agent_name="${AGENT_NAMES[$idx]}"
            local agent_desc="${AGENT_DESCS[$idx]}"
            local is_installed=""
            local status_icon=""
            local status_color=""

            if [[ -f "$CLAUDE_AGENTS_DIR/$agent_file" ]]; then
                is_installed=" ${BLUE}(installed)${NC}"
            fi

            if [[ ${agent_states[$idx]} -eq 1 ]]; then
                status_icon="[✓]"
                status_color="${GREEN}"
            else
                status_icon="[ ]"
                status_color="${RED}"
            fi

            echo -e "  ${YELLOW}$i)${NC} ${status_color}${status_icon}${NC} ${BOLD}$agent_name${NC}$is_installed"
            echo -e "     ${CYAN}$agent_desc${NC}"
            echo ""
            ((i++))
        done

        echo -e "  ${YELLOW}a)${NC} Select all"
        echo -e "  ${YELLOW}n)${NC} Deselect all"
        echo -e "  ${YELLOW}c)${NC} Confirm selection"
        echo -e "  ${YELLOW}q)${NC} Quit"
        echo ""

        read -p "Enter your choice: " choice

        case "$choice" in
            [0-9]*)
                if (( choice >= 1 && choice <= ${#AGENT_FILES[@]} )); then
                    local idx=$((choice-1))
                    if [[ ${agent_states[$idx]} -eq 1 ]]; then
                        agent_states[$idx]=0
                    else
                        agent_states[$idx]=1
                    fi
                fi
                ;;
            a|A)
                for i in "${!agent_states[@]}"; do
                    agent_states[$i]=1
                done
                ;;
            n|N)
                for i in "${!agent_states[@]}"; do
                    agent_states[$i]=0
                done
                ;;
            c|C)
                local to_install=()
                local to_uninstall=()

                for idx in "${!AGENT_FILES[@]}"; do
                    local agent_file="${AGENT_FILES[$idx]}"
                    local is_selected=${agent_states[$idx]}
                    local was_installed=0

                    if [[ -f "$CLAUDE_AGENTS_DIR/$agent_file" ]]; then
                        was_installed=1
                    fi

                    if [[ $was_installed -eq 0 && $is_selected -eq 1 ]]; then
                        to_install+=("$agent_file")
                    elif [[ $was_installed -eq 1 && $is_selected -eq 0 ]]; then
                        to_uninstall+=("$agent_file")
                    fi
                done

                confirm_and_apply to_install to_uninstall
                return
                ;;
            q|Q)
                echo -e "\n${GREEN}Goodbye!${NC}"
                exit 0
                ;;
        esac
    done
}

confirm_and_apply() {
    local -n _install=$1
    local -n _uninstall=$2

    local install_count=${#_install[@]}
    local uninstall_count=${#_uninstall[@]}

    # Filter empty
    [[ ${_install[0]} == "" ]] && install_count=0
    [[ ${_uninstall[0]} == "" ]] && uninstall_count=0

    show_header
    echo -e "${BOLD}Confirmation${NC}\n"

    if [[ $install_count -eq 0 && $uninstall_count -eq 0 ]]; then
        echo -e "${YELLOW}No changes to apply.${NC}"
        echo ""
        read -p "Press Enter to continue..."
        return
    fi

    if [[ $install_count -gt 0 ]]; then
        echo -e "${GREEN}Agents to install ($install_count):${NC}"
        for agent_file in "${_install[@]}"; do
            [[ -n "$agent_file" ]] && echo -e "  ${GREEN}+${NC} ${agent_file%.md}"
        done
        echo ""
    fi

    if [[ $uninstall_count -gt 0 ]]; then
        echo -e "${RED}Agents to uninstall ($uninstall_count):${NC}"
        for agent_file in "${_uninstall[@]}"; do
            [[ -n "$agent_file" ]] && echo -e "  ${RED}-${NC} ${agent_file%.md}"
        done
        echo ""
    fi

    echo -e "${BOLD}Summary:${NC} ${GREEN}$install_count to install${NC}, ${RED}$uninstall_count to uninstall${NC}"
    echo ""

    read -p "Apply these changes? (y/N): " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo ""

        for agent_file in "${_install[@]}"; do
            if [[ -n "$agent_file" ]]; then
                if install_agent "$agent_file"; then
                    echo -e "${GREEN}✓${NC} Installed: ${agent_file%.md}"
                else
                    echo -e "${RED}✗${NC} Failed to install: ${agent_file%.md}"
                fi
            fi
        done

        for agent_file in "${_uninstall[@]}"; do
            if [[ -n "$agent_file" ]]; then
                if [[ -f "$CLAUDE_AGENTS_DIR/$agent_file" ]]; then
                    rm "$CLAUDE_AGENTS_DIR/$agent_file"
                    echo -e "${RED}✓${NC} Uninstalled: ${agent_file%.md}"
                fi
            fi
        done

        echo ""
        echo -e "${GREEN}${BOLD}Changes applied successfully!${NC}"
    else
        echo -e "${YELLOW}Changes cancelled.${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Main
main() {
    select_install_mode
    while true; do
        select_agents
    done
}

main

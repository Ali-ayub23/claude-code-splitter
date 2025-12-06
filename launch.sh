#!/bin/bash

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo "Claude Code not found. Installing..."
    if command -v npm &> /dev/null; then
        npm install -g @anthropic-ai/claude-code
    else
        echo "Error: npm is not installed. Please install Node.js and npm to continue."
        exit 1
    fi
fi

# Verify installation
if ! command -v claude &> /dev/null; then
    echo "Error: Failed to install Claude Code. Please install manually: npm i -g @anthropic-ai/claude-code"
    exit 1
fi

echo "Claude Code is ready."

# Test script to verify tmux logic for 7 agents

SESSION="test_agents"
tmux kill-session -t $SESSION 2>/dev/null
sleep 0.5
tmux new-session -d -s $SESSION
tmux set -g pane-border-status top
tmux set -g pane-border-format " #T "

# Agent 1
tmux send-keys 'echo "Agent 1 ready"' C-m; tmux select-pane -T "Agent-1"

# Logic for 7 agents (max 3 cols)
# Cols = 3
# Create columns
tmux split-window -h
tmux send-keys 'echo "Agent 2 ready"' C-m; tmux select-pane -T "Agent-2"
tmux split-window -h
tmux send-keys 'echo "Agent 3 ready"' C-m; tmux select-pane -T "Agent-3"

# Go back to layout tiled?
tmux select-layout tiled

# Create remaining 4 agents
tmux split-window -v
tmux send-keys 'echo "Agent 4 ready"' C-m; tmux select-pane -T "Agent-4"
tmux split-window -v
tmux send-keys 'echo "Agent 5 ready"' C-m; tmux select-pane -T "Agent-5"
tmux split-window -v
tmux send-keys 'echo "Agent 6 ready"' C-m; tmux select-pane -T "Agent-6"
tmux split-window -v
tmux send-keys 'echo "Agent 7 ready"' C-m; tmux select-pane -T "Agent-7"

tmux select-layout tiled

# List panes to verify
tmux list-panes -t $SESSION -F "#{pane_index}: #{pane_title}"

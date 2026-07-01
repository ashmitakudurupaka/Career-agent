#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# AI Job Application Command Centre — Lemma SDK Setup
# Gappy AI Hackathon · June 2026
# Run this once from the repo root: bash setup.sh
# ─────────────────────────────────────────────────────────────────────────────
set -e
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info()  { echo -e "${GREEN}[✓]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }

echo ""
echo "🎯  AI Career Command Centre · Lemma SDK Setup"
echo "────────────────────────────────────────────────"
echo ""

# ── Step 1: Install Lemma Stack ───────────────────────────────────────────────
info "Installing Lemma Stack (backend + frontend + infra in containers)..."
curl -fsSL https://raw.githubusercontent.com/lemma-work/lemma-platform/main/install.sh | bash
info "Lemma Stack installed."

# ── Step 2: Configure model provider ─────────────────────────────────────────
echo ""
warn "You need an Anthropic API key (or OpenAI-compatible key)."
warn "Get one free at: https://console.anthropic.com"
echo ""
read -rp "Paste your Anthropic API key (sk-ant-...): " ANTHROPIC_KEY

if [[ -n "$ANTHROPIC_KEY" ]]; then
  lemma-stack config set LEMMA_DEFAULT_MODEL_TYPE anthropic_compat
  lemma-stack config set LEMMA_ANTHROPIC_API_KEY "$ANTHROPIC_KEY"
  lemma-stack config set LEMMA_ANTHROPIC_DEFAULT_MODEL claude-sonnet-4-5
  lemma-stack restart
  info "Model configured: Claude Sonnet via Anthropic"
else
  warn "Skipped API key. Set it later with:"
  warn "  lemma-stack config set LEMMA_DEFAULT_MODEL_TYPE anthropic_compat"
  warn "  lemma-stack config set LEMMA_ANTHROPIC_API_KEY sk-ant-..."
fi

# ── Step 3: Install Lemma CLI ─────────────────────────────────────────────────
echo ""
info "Installing Lemma CLI (lemma-terminal)..."
uv tool install lemma-terminal
info "CLI installed. Logging in..."

lemma servers select local
lemma auth login
info "Authenticated."

# ── Step 4: Install Lemma skills into Claude Code ────────────────────────────
echo ""
info "Installing Lemma builder skills into Claude Code..."
lemma skills install --target claude
info "Skills installed. Claude Code can now build and operate pods."

# ── Step 5: Import the career pod ────────────────────────────────────────────
echo ""
info "Importing the Career Command Centre pod..."
lemma pod import ./pod
info "Pod imported successfully."

# ── Step 6: Deploy the operator app ──────────────────────────────────────────
echo ""
info "Deploying the career app UI..."
lemma apps deploy career-app ./pod/apps/index.html
info "App deployed."

# ── Step 7: Summary ───────────────────────────────────────────────────────────
echo ""
echo "────────────────────────────────────────────────"
echo -e "${GREEN}✅  Setup complete!${NC}"
echo ""
echo "  🌐 Local app:     http://127-0-0-1.sslip.io:3711"
echo "  🔌 API docs:      http://127-0-0-1.sslip.io:8711/scalar"
echo ""
echo "  Quick test:"
echo "    lemma describe                              # see your pod"
echo "    lemma tables list                           # see applications + resume_context tables"
echo "    lemma chat 'what can you do in this pod?'  # talk to career_agent"
echo ""
echo "  To deploy to lemma.work (for the hackathon live link):"
echo "    lemma servers select cloud"
echo "    lemma auth login"
echo "    lemma pod import ./pod"
echo "    lemma apps deploy career-app ./pod/apps/index.html"
echo ""
echo "  📖 Docs:   https://lemma.work/docs"
echo "  💬 Help:   https://discord.gg/6dVR7zTvy"
echo ""

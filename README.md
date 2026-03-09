# alphaclaw-agentspace
Repo to house alphaclaw agent infrastructure.

## AlphaClaw WhatsApp onboarding patch

This workspace contains a patch against `https://github.com/chrysb/alphaclaw` that adds WhatsApp as a setup-channel option (alongside Telegram and Discord), including onboarding validation, config wiring, pairing/status support, and tests.

### Files

- `patches/alphaclaw-whatsapp-onboarding.patch` – git patch to apply on top of AlphaClaw upstream.
- `scripts/create_alphaclaw_agent.sh` – helper script that clones AlphaClaw into this workspace and applies the patch.

### Quick use

```bash
./scripts/create_alphaclaw_agent.sh
```

By default this creates `./alphaclaw-agent` and applies the patch. You can pass a custom destination:

```bash
./scripts/create_alphaclaw_agent.sh /workspace/my-alphaclaw-agent
```

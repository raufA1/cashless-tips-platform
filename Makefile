plan: analyze
	@true

resume:
	@echo "----- NEXT_STEPS.md -----"; [ -f NEXT_STEPS.md ] && sed -n '1,120p' NEXT_STEPS.md || echo "Run: make plan"
	@echo; echo "Open issues:"; gh issue list -L 10 || true

snapshot:
	@bash scripts/snapshot.sh
	@git add STATUS.md NEXT_STEPS.md SESSION_LOG.md snapshots || true
	@git commit -m "chore: session snapshot" || true
	@echo "Done."

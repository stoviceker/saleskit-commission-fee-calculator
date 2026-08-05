# Saleskit – kalkulačka provizních výnosů pro partnery

Statická webová aplikace (jeden HTML soubor) připravená k úspornému nasazení na
**Coolify** přes Docker.

## Tech stack

- `index.html` – celá kalkulačka, bez backendu a databáze
- neprivilegovaný Nginx s jedním workerem
- Docker image s pevně připnutou verzí a healthcheckem
- port `8080`, endpointy `GET /health` a `GET /healthz`

## Lokální spuštění

```bash
docker build -t saleskit-kalkulacka .
docker run --rm -p 8080:8080 saleskit-kalkulacka
# → http://localhost:8080
```

Healthcheck: `curl http://localhost:8080/health` → `{"status":"ok"}`

## Nasazení na Coolify

1. V Coolify → **New Resource → Application → Public/Private GitHub Repository**.
2. Vyber tento repozitář a větev `main`.
3. **Build Pack: Dockerfile** (Coolify Dockerfile detekuje automaticky).
4. **Port: `8080`**.
5. Nastav healthcheck na `/health`.
6. Pro tento VPS nech **Automatic Deployment vypnutý** a nasazuj ověřený commit řízeně.
7. Pro tuto statickou aplikaci stačí limit `64 MB RAM` a `0.25 CPU`.
8. Deploy → Coolify přidělí dočasnou technickou doménu.
9. Později v **Domains** nahraď za vlastní subdoménu (Coolify zařídí HTTPS přes Let's Encrypt).

> Pozn.: Aplikace načítá z internetu jen písma (Google Fonts) a logo Saleskit (jejich CDN).
> Na hostovaném webu s připojením to funguje bez problémů.

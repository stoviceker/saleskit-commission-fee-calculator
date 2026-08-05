# Saleskit – kalkulačka provizních výnosů pro partnery

Statická webová aplikace (jeden HTML soubor) zabalená do minimálního Node.js serveru,
připravená k nasazení na **Coolify** (VPS) přes Docker s autodeployem z GitHubu.

## Tech stack

- **Node.js 20** (bez runtime závislostí – čistý `http` modul)
- `server.js` – servíruje složku `public/` a poslouchá na `PORT` (Coolify ho nastaví automaticky)
- `Dockerfile` – `node:20-alpine`, `EXPOSE 3000`
- Aplikace samotná: `public/index.html`

## Lokální spuštění

```bash
node server.js
# nebo
npm start
# → http://localhost:3000
```

Volitelně přes Docker:

```bash
docker build -t saleskit-kalkulacka .
docker run -p 3000:3000 saleskit-kalkulacka
# → http://localhost:3000
```

Health-check endpoint: `GET /health` → `200 ok`

## Nasazení na Coolify

1. V Coolify → **New Resource → Application → Public/Private GitHub Repository**.
2. Vyber tento repozitář a větev `main`.
3. **Build Pack: Dockerfile** (Coolify Dockerfile detekuje automaticky).
4. **Port: `3000`** (odpovídá `EXPOSE`/`PORT` v Dockerfile).
5. Zapni **Automatic Deployment** (deploy při každém pushi do `main`).
6. Deploy → Coolify přidělí dočasnou technickou doménu.
7. Později v **Domains** nahraď za vlastní subdoménu (Coolify zařídí HTTPS přes Let's Encrypt).

> Pozn.: Aplikace načítá z internetu jen písma (Google Fonts) a logo Saleskit (jejich CDN).
> Na hostovaném webu s připojením to funguje bez problémů.

## Nahrání na GitHub

Repozitář je už inicializovaný s prvním commitem. Stačí přidat remote a pushnout:

```bash
# Přes GitHub CLI (nejrychlejší):
gh repo create saleskit-kalkulacka --private --source=. --remote=origin --push

# NEBO ručně – nejdřív vytvoř prázdný repo na github.com, pak:
git remote add origin https://github.com/<uzivatel>/saleskit-kalkulacka.git
git branch -M main
git push -u origin main
```

Odkaz na repozitář pak stačí dát kolegovi, který ho v Coolify napáruje na autodeploy.

# 📖 Guide d'Implémentation Pas-à-Pas

## Objectif
Transformer le BLE Spam de la version 6.9 à une version 7.0 **production-ready** avec:
- ✅ Gestion mémoire sécurisée
- ✅ Validation d'entrées robuste
- ✅ Délais adaptatifs par plateforme
- ✅ Compatibilité Rogue Master 0.97.0+
- ✅ Code maintenable et documenté

---

## 📋 Prérequis

### Avant de Commencer
1. **Flipper Zero physique** ou **Simulator Rogue Master**
2. **VS Code** avec extensions C/C++
3. **SDK Flipper Zero** (v0.97.0+)
4. **Git** pour versioning
5. **Make** ou **Ninja** pour builds

### Extensions VS Code Requises
```bash
# Installer les extensions critiques
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cmake-tools
code --install-extension sonarsource.sonarlint-vscode
code --install-extension eamodio.gitlens
```

---

## 🎯 Phase 1: Préparation (30 minutes)

### Étape 1.1: Créer Structure de Répertoires

```bash
cd c:\Users\Lucas\Downloads\Flipper\ble_spam

# Créer structure
mkdir -p src\config
mkdir -p src\core
mkdir -p src\ble
mkdir -p src\utils
mkdir -p tests\unit
mkdir -p build
mkdir -p .vscode

# Vérifier création
tree src
```

**Résultat attendu:**
```
src/
├── config/
├── core/
├── ble/
└── utils/
```

### Étape 1.2: Copier Fichiers Existants

```bash
# Copier source existants dans src/
copy ble_spam.c src\
copy ble_spam.h src\
copy application.fam .
copy -r protocols src\
copy -r scenes src\
copy -r assets .
```

### Étape 1.3: Initialiser Git (si nécessaire)

```bash
git init
git add .
git commit -m "Initial commit - v6.9 baseline"
```

---

## 🔧 Phase 2: Configuration Centralisée (45 minutes)

### Étape 2.1: Créer config/config.h

**Chemin:** `c:\Users\Lucas\Downloads\Flipper\ble_spam\src\config\config.h`

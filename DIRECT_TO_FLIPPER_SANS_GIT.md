# 🚀 DIRECT TO FLIPPER - Pas de Git, Juste l'App!

## ⚡ 3 Options: Choisissez Celle qui Marche pour Vous

---

## ✅ OPTION 1: UTILISATEUR LAMBDA (La Plus Simple)

**Si vous avez un fichier `.fap` prêt à l'emploi:**

### Étape 1: Connecter Flipper en USB
```
Flipper Zero → USB → Ordinateur
```

### Étape 2: Accéder au Stockage
```
Windows: Flipper apparait comme "lecteur E:" ou autre
Ou: Utilisez le Flipper Updater
```

### Étape 3: Copier le fichier
```
Chercher: ble_spam.fap (dans build/ ou téléchargé)
Coller vers: /ext/apps/bluetooth/

Chemin exact sur Flipper:
E:\apps\bluetooth\ble_spam.fap
```

### Étape 4: Déconnecter et Utiliser
```
Flipper → Apps → Bluetooth → BLE Spam
Voilà! L'app est installée! ✅
```

**Temps total: 5 minutes**

---

## ✅ OPTION 2: VOUS AVEZ LE CODE, BESOIN DE COMPILER

**Si vous avez téléchargé les sources:**

### Étape 1: Avoir SDL SDK + Flipper SDK installé
```
Voir: https://github.com/flipperdevices/flipperzero-firmware
```

### Étape 2: Dans le dossier du projet
```bash
cd c:\Users\Lucas\Downloads\Flipper\ble_spam

# Si build/ n'existe pas:
mkdir build
cd build

# Compiler
cmake ..
make -j4
```

### Résultat:
```
build/ble_spam.fap ← Fichier généré ✅
```

### Étape 3: Copier vers Flipper
```
Même que Option 1:
Flipper USB → E:\apps\bluetooth\
Copier: build\ble_spam.fap
```

**Temps total: 15-20 minutes**

---

## ✅ OPTION 3: VOUS AVEZ ROGUE MASTER + CLI

**Si vous avez Flipper CLI configuré:**

### Étape 1: Compiler (pareil qu'avant)
```bash
cd c:\Users\Lucas\Downloads\Flipper\ble_spam
mkdir build
cd build
cmake ..
make -j4
```

### Étape 2: Installer directement
```bash
# Si FVT (Flipper Venv Tool) est dispo:
fvm install ble_spam

# Ou avec fbt (Flipper Build Tool):
./fbt install
```

**Temps total: 20 minutes**

---

## 🎯 RÉSUMÉ RAPIDE

| Votre Situation | Action | Temps |
|-----------------|--------|-------|
| J'ai le `.fap` déjà | Copier sur Flipper USB | 5 min |
| J'ai le code source | Compiler + Copier | 20 min |
| J'ai CLI/fvm | Compiler + fvm install | 20 min |

---

## 💡 LA PLUS RAPIDE: OPTION 1

**Exact procedure:**

### 1. Chercher le fichier
```
Dans: c:\Users\Lucas\Downloads\Flipper\ble_spam\build\
Fichier: ble_spam.fap
```

**Si n'existe pas? Aller Option 2 (compiler d'abord)**

### 2. Connecter Flipper
```
USB cable: Flipper ↔ PC
```

### 3. Copier fichier
```
Depuis: build\ble_spam.fap
Vers: E:\apps\bluetooth\ble_spam.fap
(E: = votre Flipper mounté)
```

### 4. Utiliser
```
Flipper menu:
Apps → Bluetooth → BLE Spam
✅ DONE!
```

---

## 🚨 PROBLÈMES COURANTS

### "Je vois pas E:\ sur mon PC"
→ Flipper est pas en mode USB mass storage
→ Solution: Brancher en USB, puis sur Flipper: Paramètres → USB → Mode Mass Storage

### "E:\apps\bluetooth\ n'existe pas"
→ Créer le dossier manuellement
→ Ou utiliser Flipper Manager GUI au lieu d'explorer

### "ble_spam.fap introuvable"
→ Vous devez compiler (Option 2)
→ Ou télécharger une version pré-compilée

### "App ne se lance pas"
→ Vérifier version Flipper: 0.97.0+
→ Restart Flipper
→ Recopier le fichier

---

## 📱 APRÈS L'INSTALLATION

### Tester l'app
```
1. Ouvrir: Apps → Bluetooth → BLE Spam
2. Voir le menu d'attaques? ✓
3. Click sur "Kitchen Sink"? ✓
4. Voir l'LED bleu clignote? ✓
5. Pas de crash? ✓

→ SI OUI: TOUT MARCHE! 🎉
```

---

## 🎯 CHOIX FINAL

**Vous dites "je m'en fous du Git":**

→ **OPTION 1** si vous avez `.fap` (5 min)
→ **OPTION 2** si vous avez le code à compiler (20 min)

**Choisissez maintenant et on y va!** 🚀

---

## ⚡ ULTRA-COURT WORKFLOW

```
1. Compiler (20 sec):
   cd c:\Users\Lucas\Downloads\Flipper\ble_spam\build
   cmake .. && make -j4

2. Attendre (5 min)

3. Brancher Flipper USB

4. Copier fichier (1 min):
   build\ble_spam.fap → E:\apps\bluetooth\

5. Utiliser! (1 min):
   Flipper: Apps → Bluetooth → BLE Spam

TOTAL: 10 minutes maximum!
```

---

**C'est aussi simple que ça!** ✅

**Lancez maintenant: quelle option voulez-vous?**

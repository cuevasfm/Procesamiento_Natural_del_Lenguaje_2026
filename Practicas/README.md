# Prácticas de NLP 2026

Esta carpeta contiene las practicas del curso. El entorno, para no
interferir con las actualizaciones del proyecto base (fork).

## Estructura

```
.. (raíz)
├── setup.sh            # Prepara el entorno (solo ejecutarlo)
├── requirements.txt    # Dependencias
├── .gitignore          # Ignora .venv y datos
├── .venv/              # Entorno virtual (local, ignorado por git)
└── Practicas/
    ├── notebooks/      # Tus notebooks de práctica
    ├── src/            # Código reutilizable (nlp_utils.py)
    └── Tareas/         # Tareas del curso
```

## Preparar el entorno (una sola vez)

Desde la **raíz del proyecto**:

```bash
bash setup.sh
```

## Uso diario

```bash
# Desde la raíz del proyecto
source .venv/bin/activate
jupyter lab
# Abre Practicas/notebooks/ y usa el kernel "Python (NLP Prácticas 2026)"
deactivate   # para salir
```

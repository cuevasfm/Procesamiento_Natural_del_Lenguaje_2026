
set -euo pipefail

# Moverse a la carpeta de este script
cd "$(dirname "$0")"

ENV_NAME="nlp_practicas_2026"
KERNEL_DISPLAY="Python (NLP Prácticas 2026)"

echo "============================================================"
echo "   Configurando entorno LOCAL de Prácticas NLP 2026"
echo "============================================================"


PY_BIN=""
for v in 3.12 3.11 3.10; do
  if command -v "python$v" >/dev/null 2>&1; then
    PY_BIN="$(command -v python$v)"
    break
  fi
done

if [ -n "$PY_BIN" ]; then
  echo "✅ Python compatible encontrado: $PY_BIN"
  echo "→ Creando entorno local con: python -m venv .venv"
  "$PY_BIN" -m venv .venv
elif command -v uv >/dev/null 2>&1; then
  echo "ℹ️  No hay Python 3.10-3.12 en el sistema (tienes 3.14)."
  echo "✅ Usando uv para crear .venv con Python 3.12: $(uv --version)"
  uv venv --python 3.12 .venv
else
  echo "❌ No se encontró Python 3.10-3.12 ni 'uv'."
  echo "   Opción A (recomendada): instala uv -> brew install uv"
  echo "   Opción B: instala Python 3.12 -> brew install python@3.12"
  exit 1
fi

source .venv/bin/activate
echo "✅ Entorno activado: $(python --version) en $(pwd)/.venv"

echo ""
echo "→ Instalando dependencias (puede tardar varios minutos)..."
python -m pip install --upgrade pip
python -m pip install -r requirements.txt


echo ""
echo "→ Descargando modelos de spaCy (es / en)..."
python -m spacy download es_core_news_sm
python -m spacy download en_core_web_sm


echo ""
echo "→ Descargando recursos de NLTK..."
python - <<'PYCODE'
import nltk
recursos = ['punkt', 'punkt_tab', 'stopwords', 'wordnet', 'omw-1.4',
            'movie_reviews', 'averaged_perceptron_tagger',
            'averaged_perceptron_tagger_eng',
            'maxent_ne_chunker', 'words']
for r in recursos:
    try:
        nltk.download(r, quiet=True)
        print(f"  ✅ {r}")
    except Exception as e:
        print(f"  ⚠️  {r}: {e}")
PYCODE

echo ""
echo "→ Registrando kernel de Jupyter..."
python -m ipykernel install --user --name "${ENV_NAME}" --display-name "${KERNEL_DISPLAY}"

echo ""
echo "============================================================"
echo "  ✅ ¡Entorno local listo!"
echo "============================================================"
echo ""
echo "  Para empezar a trabajar (desde la raíz del proyecto):"
echo "    1. Activa el entorno:   source .venv/bin/activate"
echo "    2. Inicia Jupyter:      jupyter lab"
echo "    3. Abre:                Practicas/notebooks/practica_00_plantilla.ipynb"
echo "    4. Kernel:              \"${KERNEL_DISPLAY}\""
echo ""
echo "  Para salir del entorno:   deactivate"
echo ""

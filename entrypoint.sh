#/bin/bash

if [[ "$1" != /* ]]; then
  INPUT_CONFIG="/github/workspace/$1"
else
  INPUT_CONFIG="$1"
fi

if [[ "$2" != /* ]]; then
  TARGET_DIR="/github/workspace/$2"
else
  TARGET_DIR="$2"
fi

echo "Executando ScriptLattes action"
echo "Arquivo de entrada: $1"

cd /target/

echo "Executando python scriptLattes.py $1"

/target/scriptLattes.py $INPUT_CONFIG || exit 1

OUTPUT_DIR=$(grep '^global-diretorio_de_saida' $INPUT_CONFIG | cut -d'=' -f2 | xargs)

cp -r $OUTPUT_DIR $TARGET_DIR || exit 1

echo "Arquivos de saída do ScriptLattes disponíveis em $TARGET_DIR"
echo "Concluindo execução da ScriptLattes Action"

exit 0
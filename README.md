# ScriptLattes para GitHub Actions

## Introdução

ScriptLattes é uma ferramenta que gera páginas Web com informações
bibliométricas de um grupo de pesquisa conforme configurações especificadas
utilizando arquivos de texto de entrada. As páginas web resultantes têm as
informações atualizadas diretamente dos [Currículos Lattes](https://lattes.cnpq.br/)
dos membros do grupo de pesquisa especificados.

A utilização desta Github Action permite, por exemplo, a atualização automática
página de produção bibliográfica de um grupo de pesquisa utilizando um cron job
para especificar a periodicidade da atualização.

A execução desta action utiliza como base a imagem Docker do ScriptLattes
cujas informações podem ser obtidas no
[repositório Github](https://github.com/igorjrd/scriptlattes-docker-image) e
no [Docker Registry](https://hub.docker.com/r/igorjrd/scriptlattes).

## Configurando a Action

Abaixo está um exemplo de como configurar a action do ScriptLattes para realizar
as seguinte etapas:

1. Checkout no repositório git em que está definida a action
2. Limpa arquivos antigos do diretório em que estão as páginas web geradas pelo
ScriptLattes
3. Executa o ScriptLattes para gerar uma atualização da página
4. Faz commit e push das modificações, caso haja alguma

O input `config-file-path` indica o caminho relativo para o arquivo
`*.config` dentro do workspace da action. Já o input `output-directory-path`
indica o caminho para o qual deve ser copiado o diretório de saída resultante da
execução do ScriptLattes.

```
# /github/workflows/scriptlattes.yml

on:
  workflow_dispatch:
  schedule:
    - cron: '0 6 * * 5'

jobs:
  run-scriptlattes:
    runs-on: ubuntu-latest
    name: Executa ScriptLattes
    steps:
      - name: Checkout no repositório
        uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
      - name: Limpa arquivos anteriores gerados por ScriptLattes
        run: |
          if [ -d "./output" ]; then
            rm -r ./output
            echo "Diretório ./output limpo"
          fi
      - name: Executa scriptlattes action
        uses: ./
        with:
          config-file-path: ./scriptlattes.config
          output-directory-path: ./output
      - name: Comita e envia alterações ao repositório
        run: |
          if [ ! -d "./output" ]; then
            echo "Diretório de saída do ScriptLattes não encontrado. Não serão executadas alterações no repositório"
          fi
          git config --global user.name "github-actions[bot]"
          git config --global user.email "github-actions[bot]@users.noreply.github.com"

          git add output/
          git commit -m "chore: atualizações automáticas no diretório output/" || echo "Nenhuma alteração para commitar"
          git push
```


## Créditos
Aqui consta a lista de idealizadores e colaboradores responsáveis pela codificação/implementação e melhorias/modificações e correções:

### Idealização

    Jesús P. Mena-Chalco (UFABC)
    Roberto M. Cesar-Jr (USP)

### Versão Python

    Cátia Nascimento (UFRGS)
    Celina Maki Takemura (EMBRAPA)
    Christina von Flach G. Chavez (UFBA)
    Evelyn Perez Cervantes (IME-USP)
    Fabio N. Kepler (UNIPAMPA)
    Helena Caseli (UFSCar)
    Richard W. Valdivia (UNIFESP)
    Wonder Alexandre Luz Alves (UNINOVE).

### Versão Perl

    Carlos Morais de Oliveira Filho (IME-USP)
    Christina von Flach G. Chavez (UFBA)
    Luc Quoniam (Université Du Sud Toulon Var)
    Renato Novais (UFBA)
    Silvio de Paula (USP)

### Setup de construção de imagem Docker

    Igor Jordão Marques (INTM-UFPE)

### Criação da Github Action

    Igor Jordão Marques (INTM-UFPE)

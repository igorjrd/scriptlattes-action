FROM igorjrd/scriptlattes

COPY entrypoint.sh /target/entrypoint.sh

ENTRYPOINT [ "/bin/bash", "/target/entrypoint.sh" ]
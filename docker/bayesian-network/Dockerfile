FROM rockerjp/verse:latest

RUN mkdir -p /workspace/kmedu_data_analysis
WORKDIR /workspace
ENV DISPLAY=host.docker.internal:0.0

COPY R/ /workspace/kmedu_data_analysis/R
COPY app.R /workspace/kmedu_data_analysis/
COPY data/ /workspace/kmedu_data_analysis/data/

RUN R -e 'install.packages("rlang")' \
    && R -e 'install.packages("readxl", dependencies = TRUE)' \
    && R -e 'install.packages("bnlearn", dependencies = TRUE)' \
    && R -e 'install.packages("BiocManager", dependencies = TRUE)' \
    && R -e 'BiocManager::install("Rgraphviz")' \
    && R -e 'install.packages("fastICA", dependencies = TRUE)' \
    && R -e 'install.packages("extrafont", dependencies = TRUE)' \
    && R -e 'install.packages("tidyverse", dependencies = TRUE)' \
    && R -e 'install.packages("shiny", dependincies = TRUE)'

EXPOSE 3838

CMD R -e 'shiny::runApp("/workspace/kmedu_data_analysis/app.R", port = 3838, host = "0.0.0.0")'

FROM jupyter/all-spark-notebook

RUN curl -L "https://ipafont.ipa.go.jp/IPAexfont/ipaexg00201.zip" > font.zip
RUN unzip font.zip
RUN cp ipaexg00201/ipaexg.ttf /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/ipaexg.ttf
RUN echo "font.family : IPAexGothic" >>  /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc
RUN pip install jupyterlab
RUN jupyter serverextension enable --py jupyterlab

RUN rm -r ./.cache

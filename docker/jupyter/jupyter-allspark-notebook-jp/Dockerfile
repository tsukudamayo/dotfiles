FROM jupyter/all-spark-notebook

RUN curl -L "https://ipafont.ipa.go.jp/IPAexfont/ipaexg00201.zip" > font.zip
RUN unzip font.zip
RUN cp ipaexg00201/ipaexg.ttf /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/ipaexg.ttf
RUN echo "font.family : IPAexGothic" >>  /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc
RUN mkdir -p /home/jovyan/.fonts
RUN cp -r ipaexg00201 /home/jovyan/.fonts/ 
RUN pip install jupyterlab
RUN jupyter serverextension enable --py jupyterlab

RUN rm -r ./.cache

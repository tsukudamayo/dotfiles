FROM jupyter/all-spark-notebook

RUN curl -L "https://moji.or.jp/wp-content/ipafont/IPAexfont/IPAexfont00401.zip" > font.zip
RUN unzip font.zip
RUN cp IPAexfont00401/ipaexg.ttf /opt/conda/lib/python3.9/site-packages/matplotlib/mpl-data/fonts/ttf/ipaexg.ttf
RUN echo "font.family : IPAexGothic" >>  /opt/conda/lib/python3.9/site-packages/matplotlib/mpl-data/matplotlibrc
RUN mkdir -p /home/jovyan/.fonts
RUN cp -r IPAexfont00401 /home/jovyan/.fonts/ 
RUN pip install jupyterlab
RUN jupyter serverextension enable --py jupyterlab

RUN rm -r ./.cache

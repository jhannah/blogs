
TITLE="Roberta Jenkins Mail Archive"

mhonarc \
   -outdir cooked \
   -title "$TITLE" -ttitle "$TITLE" \
   -spammode -rcfile mhonarc.mrc \
   raw/* 


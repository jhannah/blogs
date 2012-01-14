
RJ=/home/jhannah/public_html/roberta2
TITLE="Roberta Jenkins Mail Archive"

/home/jhannah/MHonArc/bin/mhonarc \
   -outdir $RJ \
   -title "$TITLE" -ttitle "$TITLE" \
   -spammode -rcfile $RJ/mhonarc.mrc \
   $RJ/raw/* 


From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ne1619 (really solved)
Message-Id: <20030731084216.41e47a32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307291959.07420.ondrej.cecak@centrum.cz>
In-Reply-To: <200307291959.07420.ondrej.cecak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> my mistake - I thouht, that eeprom must be unloaded.
> Full output is in attachement.

OK, that was just to check the script was running. You will see that
most of it is only crap because the script decodes DIMMs, not RIMMS, and
the eeproms are different on those. Maybe we'll write another script
someday, but actually I doubt it (since it's not very interesting IMHO).

OK, I think we can say lm_sensors now fully supports your system :) Only
the oops remain. If you can provide the ksymoops output of one, send it
to us (start a new thread please) and we'll see what we can do.

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

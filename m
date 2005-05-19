From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: suggested -V flag for sensors
Message-Id: <20020525104152.0a2701df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello.

I added a -V flag to the sensors program. It stands for "verbose". My
idea is that most people don't care about adapter name and algorithm
used, so I disabled them being displayed by default, and they are back
with -V.

Patch attached, please tell me what you do think about it.
(against 2.6.3, works with current CVS)

You may think that adapter and algorithm should really be displayed by
default. In this case, we still can have a flag that hides them (-A
comes to mind).

Any feedback appreciated, thanks.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.6.3-verbose.diff
Type: application/octet-stream
Size: 2106 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020525/86a21b72/lm_sensors-2.6.3-verbose.obj

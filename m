From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <1080225261.4062eded463e2@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Eric <plukje@gmx.net>:

> root@pathfinder eric # i2cdump 0 0x4e
> (...)

Great, at least we have a preliminary idea of what it does look like. I
don't have an idea about what it can be though.

It would be interesting if you could try to dump it again from times to
times, preferably with changing conditions (e.g. after a reboot, or
under heavy CPU load) and see if any value change.

What I plan to do is use the constant parts of this dump to recognize
this chip, whatever it is, and prevent sensors-detect from declaring it
a MAX1617 or LM84 (the two easily misdetected chips of the ADM1021
family).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

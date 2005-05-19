From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: lm_sensors2/lib chips.c
Message-Id: <20040121200144.7379410a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> (mmh) Undo earlier temp. magnitude workarounds for w83781d vs. kernel
> 2.6. The workarounds were obviated by Khali's patch which was merged
> into Linus' tree at 2.6.1-bk6.  Tested here on w83781d - would
> appreciate testing on the other w83's...

He he, I had the patch ready and was waiting for the the change to be
applied to Linus' tree to commit it... You beat me ;)

I tested on my as99127f and it worked OK (except the negative
temperatures limits problem, but that's a different thing).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

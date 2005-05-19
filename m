From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: lm_sensors and kernel 2.6.1
Message-Id: <1073653931.3ffea8ab71e87@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073648608.1269.3.camel@bubursuc.celuloza.ro>
In-Reply-To: <1073648608.1269.3.camel@bubursuc.celuloza.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> thanks, now it works.
> but it still complains about
> 
> ERROR: Can't get alarm data!

Aha. I forgot to fix this one in CVS. Will do that this evening.

In the mean time, you can fix it by yourself, it's trivial:
in lib/chips.c, line 2640, remove the last two values [, 0, "alarm"],
and it should be OK.
(The same fix is needed at line 3787 for the it87 chip, but you probably
don't care about this one.)

Sorry for missing this one.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

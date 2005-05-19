From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Ticket number 1467
Message-Id: <20031211193222.6e521a0c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031210225306.55ceb34e.khali@linux-fr.org>
In-Reply-To: <20031210225306.55ceb34e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> < clip >
> > Version 2.8.0:
> > w83782d-i2c-0-2d
> <clip>
> > Version 2.8.1:
> > as99127f-i2c-0-2d
> 
> Just wanted to point out that the 2.8.0 printout was for w83782d,
> while 2.8.1 was for as99127f. So different compute rules in
> sensors.conf were applied.

Stupid me. Thanks for the notice.

Richard, do you confirm that recent versions of sensors-detect tell
you you have a revision 2 AS99127F?

I've checked an improved version of sensors.conf in our CVS repository.
Get it here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg

Copy it to /etc/sensors.conf, and edit the "as99127f-*" section. You'll
find commented out lines for AS99127F rev.2 in5 and in6. Uncomment them
and you're (hopefully) done.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

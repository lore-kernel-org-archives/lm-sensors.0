From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710093755.4a37ae13.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Remember you have to *install* i2c before trying to *compile*
> > lm_sensors2. I would do a fresh CVS checkout and reinstall
> > everything from scratch, just to make sure no file was accidentally
> > modified in your local directories.
> Yes I done that. First make and make install in /usr/src/modules/i2c
> and then in /usr/src/lm_sensors2
> 
> I removed all the directories in /usr/src/modules and then done a
> fresh compile. I even done a cvs update -d before I compiled.
> 
> Did I forget anything?

Did you by any chance forgot the "-r lk2-4" when checking i2c out? The
default (HEAD) branch is deprecated and unmaintained, the one that is
known to work is lk2-4. This would explain the errors your get.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

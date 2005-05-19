From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031126231702.0e370387.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > [root@workstation1 cvs2]# i2cdump 1 50 c
> >   WARNING! This program can confuse your I2C bus, cause data loss
> >   and worse! I will probe file /dev/i2c-1, address 0x32, mode byte
> >   consecutive read You have five seconds to reconsider and press
> >   CTRL-C!
> > 
> > Segmentation fault

Still this needs fixing. Mark, any idea about that? Could it be caused
by the i2c-nforce2 driver? Doing the same here (i2c-i801) exits cleanly:
Error: Write start address failed, return code -1

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

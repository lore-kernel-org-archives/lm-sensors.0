From: mds@mds.gotdns.com (Mark Studebaker)
Date: Tue, 28 Feb 2006 04:47:33 +0000
Subject: [lm-sensors] Microchip 24LC256
Message-Id: <4403D5E5.5040506@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060227225941.36483.qmail@web31004.mail.mud.yahoo.com>
In-Reply-To: <20060227225941.36483.qmail@web31004.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

one of the userspace tools in prog/eepromer may be sufficient for what 
you need. You could do a new chip driver for the big eeprom but then you 
have to go through /sys files which is awkward for eeproms;
look hard at doing userspace access through /dev/i2c-x,
better and you don't have to write a new driver.

mds


Thomas Loos wrote:
> Hello All!
> I need to support three Microchip 24LC256 EEPROMs in a
> project.  We are using a ColdFire 5485, Freescale
> 2.6.10 distribution.  I2C is working and the i2c-tools
> i2cset, i2cdump, and i2cdetect are compiled in to the
> kernel.  Is this chip supported already?  If not, I
> will be writing a driver, my first, to be included
> with the lm_sensors package.  I have spent the last
> few days reading the documentation, which is good, but
> will most likely need your help!!!
> 
> Cheers!
> Tom
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 


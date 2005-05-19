From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: [PATCH] New driver-id for radeon-i2c
Message-Id: <20030823222405.0bdde673.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030823173658.GA3278@kroah.com>
In-Reply-To: <20030823173658.GA3278@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Hi Greg,
> > I forgot to cc you when I sent the radeonfb-i2c patch to fbdev. I
> > need a new driver-id:
> > 
> > 
> > --- linux-2.6.vanilla/include/linux/i2c-id.h	Tue Jul 15 14:27:55
> > 2003+++ linux-2.6/include/linux/i2c-id.h	Wed Aug 20 19:22:58 2003
> > @@ -99,6 +99,7 @@
> >  #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
> >  #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
> >  #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
> > +#define I2C_DRIVERID_RADEON	54	/* I2C bus on Radeon boards	*/
> 
> You need to coordinate this with the developers on the sensors mailing
> list.  I've cc:ed the message there to get their approval (or
> suggestion for a different number.

ID approved, change committed to our CVS repository as well.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

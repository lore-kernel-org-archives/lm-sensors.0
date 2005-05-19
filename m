From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: [PATCH 2.4] Trivial changes to I2C stuff
Message-Id: <20031122182902.26f859fd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031122161510.7d5b4d20.khali@linux-fr.org>
	<20031122154720.GA18110@alpha.home.local>
In-Reply-To: <20031122154720.GA18110@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willy Tarreau <willy@w.ods.org>
Cc: marcelo@cyclades.com, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com, greg@kroah.com

> > @@ -199,7 +199,7 @@
> >  #define I2C_HW_SMBUS_AMD756	0x05
> >  #define I2C_HW_SMBUS_SIS5595	0x06
> >  #define I2C_HW_SMBUS_ALI1535	0x07
> > -#define I2C_HW_SMBUS_W9968CF	0x08
> > +#define I2C_HW_SMBUS_W9968CF	0x0d
> 
> Is this one intentionnal or just a typo ?

Intentional. 0x08 is I2C_HW_SMBUS_SIS630 in both i2c-CVS and Linux 2.6.0-test9, so I chose the next available ID, which happens to be 0x0d. Anyway, these IDs have no real use AFAIK, so there is nothing to be afraid of here.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

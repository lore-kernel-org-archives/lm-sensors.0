From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Compilation question
Message-Id: <20040222183932.46d8b4b9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> After applying i2c-2.8.4.tar.gz to linux-2.4.25 the following options
> are no longer compilable
> (as they do not correspond to the new I2C interface?):
> 
>     Character devices -> I2C support -> NatSemi SCx200 I2C GPIO pins 
>     (CONFIG_SCx200_I2C)
>     Character devices -> I2C support -> NatSemi SCx200 ACCESS.bus 
>     (CONFIG_SCx200_ACB)
>     Multimedia devices -> Video For Linux -> SAA5249 Teletext
>     processor (CONFIG_VIDEO_SAA5249)
>     Multimedia devices -> Video For Linux -> SAB3036 tuner 
>     (CONFIG_TUNER_3036)
> 
> (files: scx200_i2c.c, scx200_acb.c, saa5249.c, tuner-3036.c).
> 
> What can be done to make them back again? Are they supported anymore?

Get my patch here:
http://delvare.nerim.net/i2c/

This is the same as the one you'd obtain using mkpatch.pl, plus
additional ones that workaround the compatibility issues you have been
encountering.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

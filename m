From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c-piix4 fix undo
Message-Id: <20031219204004.58581f82.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031206221027.45ecfdea.khali@linux-fr.org>
In-Reply-To: <20031206221027.45ecfdea.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Sure, got patch?  :)
> 
> Here you go:
> (...)

Checked to apply cleanly against linux-2.6.0. Added to my collection as
linux-2.6.0-i2c-piix4-hstcfg.diff.

BTW, I removed linux-2.6.0-test11-i2c-nforce2.diff from my collection
now that it made it into linux-2.6.0.

Greg, I have a patch pending that you might not be aware of. Although it
touches a driver outside of the i2c subsystem, it is related to i2c:

http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.0-test9-pcmcia-sa1100-noi2c.diff

It simply prevents the sa1100 PCMCIA driver from including the i2c.h
header file while not making any use of it. This change was part of the
recent wave of patches I sent to Marcelo. Since he accepted it, it seems
logical to update the 2.6 driver in the same way.

Could you please have this patch applied to the 2.6 kernel tree?
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

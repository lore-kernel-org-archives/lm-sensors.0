From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: max1619
Message-Id: <20040526232112.6833cfba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> About this misterious chip, yesterday i did open my computer and found
> many chips ;-)    . Some i identifide and some not.
> 
> W48C111-16H   - Fregency generator
> SST 28SF040A -  EEPROM
> HIN 211CAS - ???
> LTC 1736 CG - Step Down
> W40S11-02W - SDRAM buff
> H043 FDS - ???
> 4431 AWGT 118 - ???
> AD373 - ???
> H8 3434 - PROM
> LM 358 - ??? somthing for powersuplay
> 4463 AH(A or D) T12A - ???
> 724661-001 - ???
> P12AB   FST3383 - ???
> PCA3356  TK41111 - ???
> LM4880M - amplfire
> OCDC42K  MC4303 - ???
> PU 2211  OCK - ???
> EP7209-CV-D   -   mp3 (whau i have a mp3  :-o )
> 
> maybe you  can halp me to recognise some of them :-)

Not really. I hardly know any of these.

Your best chance is to ask Google about them. You are looking for a chip
that is I2C or SMBus compatible, with 0x1f being a possible address
(some docs could refer to is as 0x3e, which is more or less the "read
address" for i2c address 0x1f).

Remember that you are probably after a really small chip, since it has
very few registers.

Good luck.

-- 
Jean Delvare
http://khali.linux-fr.org/

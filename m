From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: [PATCH 2.6-bk] Update IXP4xx I2C bus driver
Message-Id: <1082536811.4086336b26c4d@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415180759.GA15522@plexity.net>
In-Reply-To: <20040415180759.GA15522@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The change stems from naming change in the ARM port to the IXP4xx.
> The original code had various variables, macros, and functions named
> ixp425_, ixp42x_, and ixp4xx_. All these were cleaned up to be
> ixp4xx instead since the port works on all CPUs in that family.

I understood that.

> W/O these changes, the I2C driver will not build (actually, it won't
> even appear as an options) once the ARM bits are pushed upstream.

I had not realized that the changes to the i2c bus driver were not
independant from the other changes, sorry.

> You can see the latst IXP4xx patch @
> ftp://source.mvista.com/pub/ds-patches/patch-2.6.4-ds1.gz

Well, that patch doesn't sound very informative to me. The i2c-ixp42x.c
driver is already in 2.6.5 so the relevant patch would be against
2.6.5, not 2.6.4.

BTW, don't you intend to rename i2c-ixp42x.c to i2c-ixp4xx.c as well?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

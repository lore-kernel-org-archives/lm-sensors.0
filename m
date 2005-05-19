From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: [PATCH 2.6-bk] Update IXP4xx I2C bus driver
Message-Id: <20040421155904.GA16285@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415180759.GA15522@plexity.net>
In-Reply-To: <20040415180759.GA15522@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Apr 21 2004, at 10:40, Jean Delvare was caught saying:
> > The change stems from naming change in the ARM port to the IXP4xx.
> > The original code had various variables, macros, and functions named
> > ixp425_, ixp42x_, and ixp4xx_. All these were cleaned up to be
> > ixp4xx instead since the port works on all CPUs in that family.
> 
> I understood that.
> 
> > W/O these changes, the I2C driver will not build (actually, it won't
> > even appear as an options) once the ARM bits are pushed upstream.
> 
> I had not realized that the changes to the i2c bus driver were not
> independant from the other changes, sorry.

I should have explained it in full detail in my original message. :)

> > You can see the latst IXP4xx patch @
> > ftp://source.mvista.com/pub/ds-patches/patch-2.6.4-ds1.gz
> 
> Well, that patch doesn't sound very informative to me. The i2c-ixp42x.c
> driver is already in 2.6.5 so the relevant patch would be against
> 2.6.5, not 2.6.4.

True but the I2C-specific portion I posted here applies to 2.6.5. 
I'm working on getting a full 2.6.5 patch out the door the next 
few days (or 2.6-rc if we have one by then).

> BTW, don't you intend to rename i2c-ixp42x.c to i2c-ixp4xx.c as well?

Yep. The easiest way to do this with BK, is to 'bk move i2c-ixp42x
i2c-ixp4xx' and than apply the patch on top to rename the references
to ixp4xx in the "new" i2c-ixp4xx.c. 

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6

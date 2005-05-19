From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: [PATCH 2.6-bk] Update IXP4xx I2C bus driver
Message-Id: <20040421061219.GA13977@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415180759.GA15522@plexity.net>
In-Reply-To: <20040415180759.GA15522@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Apr 15 2004, at 20:45, Jean Delvare was caught saying:
> > The 2.6 IXP4xx code has been cleaned up to change all references to
> > IXP42x/IXP425 with IXP4xx. The following patch updates the I2C bits.
> > Before applying, you need to 'bk move i2c-ixp42x.c ixp-4xx.c".
> 
> Much noise with no apparent benefit IMVHO. What motivated such a change?

The change stems from naming change in the ARM port to the IXP4xx. The
original code had various variables, macros, and functions named ixp425_, ixp42x_, 
and ixp4xx_. All these were cleaned up to be ixp4xx instead since the port works on 
all CPUs in that family. W/O these changes, the I2C driver will not build (actually,
it won't even appear as an options) once the ARM bits are pushed upstream.  You
can see the latst IXP4xx patch @

   ftp://source.mvista.com/pub/ds-patches/patch-2.6.4-ds1.gz

Option is to either apply this or to have a broken driver in the tree.
The IXP4xx code is not reverting to the mess it was in. :)

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6

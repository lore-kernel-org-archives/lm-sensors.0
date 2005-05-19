From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH 2.6] sensor chip driver refactoring
Message-Id: <20040311224623.3ec13447.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040311051537.GA6566@earth.solarsys.private>
In-Reply-To: <20040311051537.GA6566@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I think this patch will apply (without fuzz) to your current I2C tree.
> If it doesn't, please post a plain diff of your tree and I'll redo.

2.6.4-mm1 can be used as a base since it contains Greg's i2c tree.

Also, you can get my patch set here:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.4-i2c.patch.gz

It should never be really far from Greg's as long as patches are sent to
the mailing-list before he applies them.

Your patch actually applies, with some fuzz on it87 due to the fact that
Takeru's first patch had some broken indentation (not really his fault
since they came from the original driver in the first place). I've fixed
my own patches collection to reflect that and fixed some more noise too,
so it now applies against 2.6.4 cleanly and brings the i2c tree to the
same point as 2.6.4-mm1 does, as far as I can tell.

> This patch is a refactoring of some common code among all sensors chip
> drivers (except asb100, which was written this way to begin with.)
> It saves a handful of lines and ~100-300 bytes per module.  It
> compiles ok.  I've only tested it against one of the drivers, but the
> changes are similar across the board and quite mechanical.  Please
> apply.

Tested, compiles fine and works OK (AS99127F rev.1, ADM1032). I like the
idea much and just have to say I support Mark here :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

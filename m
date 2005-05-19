From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] 1/4 WIP I2C kernel patches-config
Message-Id: <m2ptzxbxyq.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20AD5.5554A03@bellsouth.net>
In-Reply-To: <3CE20AD5.5554A03@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "albert" = Albert Cranford <ac9410@bellsouth.net> writes:

Hi

albert> Hello All,
albert> I'm Albert Cranford and I'm working to get I2C ready for
albert> submission to Linus for inclusion into the 2.5 kernel.

I sent a question yesterday about that.  Why we changed the names of
th econfig files?  I am really not sure that we want that, it looks
that old names are better, only reason to change is if they support
more devices, but then a change in the text of the config option looks
in order. also.

albert> My current base is i2c-2.6.3.  I've split the patches into
albert> Linus sizes with:
albert> 1/4 being Config module.
albert> 2/4 being the core modules.
albert> 3/4 being driver modules.
albert> 4/4 being fixes needed to compile inline or modules.

albert> I would like to get some feedback/synchronization of my
albert> suggested changes into CVS 2.6.4.  My comments will be
albert> followed by each patch.  Fell free to reply.
albert> After this patch set is in the kernel, I will submit
albert> i2c-2.6.4 changes.
albert> Thanks,
albert> Albert
albert> Patch 1 assumes we really want to change CONFIG names to
albert> match the *.c modules that use them.
albert> PHILIPSPAR -> BITLP
albert> ELV -> BITELV
albert> VELLEMAN -> BITVELLE
albert> ELEKTOR -> PCFISA

albert> --- linux/drivers/i2c/Config.in.orig    2002-05-05 23:38:06.000000000 -0400
albert> +++ linux/drivers/i2c/Config.in 2002-02-18 20:06:01.000000000 -0500
albert> @@ -10,14 +10,14 @@
 
albert> dep_tristate 'I2C bit-banging interfaces'  CONFIG_I2C_ALGOBIT $CONFIG_I2C
albert> if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
albert> -      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
albert> -      dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
albert> -      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
albert> +      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_BITLP $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
albert> +      dep_tristate '  ELV adapter' CONFIG_I2C_BITELV $CONFIG_I2C_ALGOBIT
albert> +      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_BITVELLE $CONFIG_I2C_ALGOBIT
albert> fi
 
albert> dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
albert> if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then
albert> -      dep_tristate '  Elektor ISA card' CONFIG_I2C_ELEKTOR $CONFIG_I2C_ALGOPCF
albert> +      dep_tristate '  Elektor ISA card' CONFIG_I2C_PCFISA $CONFIG_I2C_ALGOPCF
albert> fi
 
albert> if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
albert> @@ -45,6 +45,7 @@
 
albert> dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
 
albert> -   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
albert> +   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
albert> +
albert> fi
albert> endmenu

albert> -- 
albert> Albert Cranford Deerfield Beach FL USA
albert> ac9410@bellsouth.net


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

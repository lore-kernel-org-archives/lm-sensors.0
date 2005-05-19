From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [patch]i2c/Config.in and i2c/Makefile and i2c-core.c and i2c-pport.c
Message-Id: <3D803947.EAC0F5EA@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D7EDA60.13842A10@attbi.com>
In-Reply-To: <3D7EDA60.13842A10@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Done and I added IBM OCP as well.  Also corrected a couple
drivers __init and __exit proc definitions.
Later,
Sleepy Albert
"Mark D. Studebaker" wrote:
> 
> Great.
> I had forgotten about i2c-core initialization part.
> Can you add in IBM OCP as well.
> 
> Go ahead and check the stuff in, that's great,
> let us know when you're happy.
> 
> Albert Cranford wrote:
> >
> > Hi Mark,
> > This is a better patch for i2c/Config.in and i2c/Makefile.
> > This is what I'll send to Linus.  You might check mkpatch
> > to see it it has the the new configurations that I
> > added below.
> > While testing, I found missing parts in i2c/i2c-core.c
> > This patch will also be sent to Linus.
> > If you can wait to create i2c-2.6.5 until after Wednesday
> > evening, I'll update CVS i2c-core.
> > I also had to adjust i2c-pport.c to get a good compile.
> > This also will go to Linus and I'll adjust CVS.
> > Later,
> > Sleepy Albert
> > ------------------
> > --- linux-2.5/34/drivers/i2c/Config.in.orig    2002-09-10 22:28:32.000000000 -0400
> > +++ linux/drivers/i2c/Config.in 2002-09-10 22:28:12.000000000 -0400
> > @@ -13,11 +13,16 @@
> >        dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
> >        dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
> >        dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
> > +      dep_tristate '  Basic I2C on Parallel Port' CONFIG_I2C_PPORT $CONFIG_I2C_ALGOBIT
> > +      if [ "$CONFIG_ARCH_SA1100" = "y" ]; then
> > +         dep_tristate 'SA1100 I2C Adapter' CONFIG_I2C_FRODO $CONFIG_I2C_ALGOBIT
> > +      fi
> >     fi
> >
> >     dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
> >     if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then
> >        dep_tristate '  Elektor ISA card' CONFIG_I2C_ELEKTOR $CONFIG_I2C_ALGOPCF
> > +      dep_tristate '  PCF on EPP port' CONFIG_I2C_PCFEPP $CONFIG_I2C_ALGOPCF
> >     fi
> >
> >     if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
> > --- linux-2.5.34/drivers/i2c/Makefile.orig     2002-09-11 00:37:51.000000000 -0400
> > +++ linux/drivers/i2c/Makefile  2002-09-11 00:38:31.000000000 -0400
> > @@ -11,8 +11,11 @@
> >  obj-$(CONFIG_I2C_PHILIPSPAR)   += i2c-philips-par.o
> >  obj-$(CONFIG_I2C_ELV)          += i2c-elv.o
> >  obj-$(CONFIG_I2C_VELLEMAN)     += i2c-velleman.o
> > +obj-$(CONFIG_I2C_PPORT)                += i2c-pport.o
> > +obj-$(CONFIG_I2C_FRODO)                += i2c-frodo.o
> >  obj-$(CONFIG_I2C_ALGOPCF)      += i2c-algo-pcf.o
> >  obj-$(CONFIG_I2C_ELEKTOR)      += i2c-elektor.o
> > +obj-$(CONFIG_I2C_PCFEPP)       += i2c-pcf-epp.o
> >  obj-$(CONFIG_ITE_I2C_ALGO)     += i2c-algo-ite.o
> >  obj-$(CONFIG_ITE_I2C_ADAP)     += i2c-adap-ite.o
> >  obj-$(CONFIG_I2C_PROC)         += i2c-proc.o
> > ----------------------------
> > --- linux-2.5.34/drivers/i2c/i2c-core.c.orig   2002-09-10 23:11:04.000000000 -0400
> > +++ linux/drivers/i2c/i2c-core.c        2002-09-10 23:20:19.000000000 -0400
> > @@ -1508,6 +1508,12 @@
> >  #ifdef CONFIG_I2C_VELLEMAN
> >         extern int i2c_bitvelle_init(void);
> >  #endif
> > +#ifdef CONFIG_I2C_PPORT
> > +       extern int i2c_bitpport_init(void);
> > +#endif
> > +#ifdef CONFIG_I2C_FRODO
> > +       extern int i2c_frodo_init(void);
> > +#endif
> >  #ifdef CONFIG_I2C_BITVIA
> >         extern int i2c_bitvia_init(void);
> >  #endif
> > @@ -1518,6 +1524,9 @@
> >  #ifdef CONFIG_I2C_ELEKTOR
> >         extern int i2c_pcfisa_init(void);
> >  #endif
> > +#ifdef CONFIG_I2C_PCFEPP
> > +       extern int i2c_pcfepp_init(void);
> > +#endif
> >
> >  #ifdef CONFIG_I2C_ALGO8XX
> >         extern int i2c_algo_8xx_init(void);
> > @@ -1553,6 +1562,15 @@
> >  #ifdef CONFIG_I2C_VELLEMAN
> >         i2c_bitvelle_init();
> >  #endif
> > +#ifdef CONFIG_I2C_PPORT
> > +       i2c_bitpport_init();
> > +#endif
> > +#ifdef CONFIG_I2C_FRODO
> > +       i2c_frodo_init();
> > +#endif
> > +#ifdef CONFIG_I2C_BITVIA
> > +       i2c_bitvia_init();
> > +#endif
> >
> >         /* --------------------- pcf -------- */
> >  #ifdef CONFIG_I2C_ALGOPCF
> > @@ -1561,6 +1579,9 @@
> >  #ifdef CONFIG_I2C_ELEKTOR
> >         i2c_pcfisa_init();
> >  #endif
> > +#ifdef CONFIG_I2C_PCFEPP
> > +       i2c_pcfepp_init();
> > +#endif
> >
> >         /* --------------------- 8xx -------- */
> >  #ifdef CONFIG_I2C_ALGO8XX
> > ------------------
> > --- linux-2.5.34/drivers/i2c/i2c-pport.c.orig  2001-10-13 14:09:01.000000000 -0400
> > +++ linux/drivers/i2c/i2c-pport.c       2002-09-11 01:37:52.000000000 -0400
> > @@ -148,7 +148,7 @@
> >         return 0;
> >  }
> >
> > -static void bit_pport_exit(void)
> > +static void __exit bit_pport_exit(void)
> >  {
> >         release_region((base+2),1);
> >  }
> > @@ -203,7 +203,7 @@
> >         bit_pport_unreg,
> >  };
> >
> > -static int __init i2c_bitpport_init(void)
> > +int __init i2c_bitpport_init(void)
> >  {
> >         printk("i2c-pport.o: i2c Primitive parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
> > --
> > Albert Cranford Deerfield Beach FL USA
> > ac9410@bellsouth.net

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

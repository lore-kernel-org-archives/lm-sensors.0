From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [patch 1/9]Four new i2c drivers and __init/__exit cleanup toi2c
Message-Id: <3D872F81.61BC7167@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This specific change set was for i2c-algo-8xx.c and 2.5.34.
I propose the following changes to satisfy 2.5 kernel
requirements.  Of course the #include changes and 
MODULE_LICENSE will not be checked into CVS.

Jeff, here was the original code which saved flags and
interrupted.  The goal was to remove the cli, so the new
code that Ingo suggested is:local_irq_save(flags);
Redesigning with semaphores is not possible.

        /* Chip bug, set enable here */
        save_flags(flags); cli();
        i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
        i2c->i2c_i2cer = 0xff;
        i2c->i2c_i2mod = 1;     /* Enable */
        i2c->i2c_i2com = 0x81;  /* Start master */

        /* Wait for IIC transfer */
        interruptible_sleep_on(&iic_wait);
        restore_flags(flags);

Jeff, the busy-wait works fine, but Russell commented that
Athlon cpu's would destroy itself, so cpu_relax was added.
I don't think its needed on this chip myself.

Anyone see a problem with 2.2 or 2.4 and these changes?
Regards,
Albert
--- i2c-algo-8xx.c      2002-08-03 18:48:18.000000000 -0400
+++ /usr/src/linux/drivers/i2c/i2c-algo-8xx.c   2002-09-17 09:04:53.000000000 -0400
@@ -54,7 +54,7 @@
 static void
 cpm_iic_interrupt(void *dev_id, void *regs)
 {
-       volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;
+       i2c8xx_t *i2c = (i2c8xx_t *)dev_id;
 
        if (cpm_debug > 1)
                printk("cpm_iic_interrupt(dev_id=%p)\n", dev_id);
@@ -75,8 +75,8 @@
 static void
 cpm_iic_init(struct i2c_algo_8xx_data *cpm_adap)
 {
-       volatile iic_t          *iip = cpm_adap->iip;
-       volatile i2c8xx_t       *i2c = cpm_adap->i2c;
+       iic_t           *iip = cpm_adap->iip;
+       i2c8xx_t        *i2c = cpm_adap->i2c;
 
        if (cpm_debug) printk("cpm_iic_init() - iip=%p\n",iip);
 
@@ -110,11 +110,12 @@
        /* Initialize Tx/Rx parameters.
        */
        if (cpm_adap->reloc = 0) {
-               volatile cpm8xx_t *cp = cpm_adap->cp;
+               cpm8xx_t *cp = cpm_adap->cp;
 
                cp->cp_cpcr                         mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
-               while (cp->cp_cpcr & CPM_CR_FLG);
+               while (cp->cp_cpcr & CPM_CR_FLG)
+                       cpu_relax(); /* prevent Athlons self-destruct */
        }
 
        /* Select an arbitrary address.  Just make sure it is unique.
@@ -145,7 +146,7 @@
 static int
 cpm_iic_shutdown(struct i2c_algo_8xx_data *cpm_adap)
 {
-       volatile i2c8xx_t *i2c = cpm_adap->i2c;
+       i2c8xx_t *i2c = cpm_adap->i2c;
 
        /* Shut down IIC.
        */
@@ -157,7 +158,7 @@
 }
 
 static void 
-cpm_reset_iic_params(volatile iic_t *iip)
+cpm_reset_iic_params(iic_t *iip)
 {
        iip->iic_tbase = r_tbase;
        iip->iic_rbase = r_rbase;
@@ -185,14 +186,15 @@
 static void force_close(struct i2c_algo_8xx_data *cpm)
 {
        if (cpm->reloc = 0) {
-               volatile cpm8xx_t *cp = cpm->cp;
+               cpm8xx_t *cp = cpm->cp;
 
                if (cpm_debug) printk("force_close()\n");
                cp->cp_cpcr                         mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
                        CPM_CR_FLG;
 
-               while (cp->cp_cpcr & CPM_CR_FLG);
+               while (cp->cp_cpcr & CPM_CR_FLG)
+                       cpu_relax(); /* prevent Athlons self-destruct */
        }
 }
 
@@ -203,10 +205,10 @@
 static int
 cpm_iic_read(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf, int count)
 {
-       volatile iic_t *iip = cpm->iip;
-       volatile i2c8xx_t *i2c = cpm->i2c;
-       volatile cpm8xx_t *cp = cpm->cp;
-       volatile cbd_t  *tbdf, *rbdf;
+       iic_t *iip = cpm->iip;
+       i2c8xx_t *i2c = cpm->i2c;
+       cpm8xx_t *cp = cpm->cp;
+       cbd_t   *tbdf, *rbdf;
        u_char *tb;
        unsigned long flags;
 
@@ -246,7 +248,7 @@
        rbdf->cbd_bufaddr = __pa(buf);
        rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
 
-       invalidate_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
+       dma_cache_inv((unsigned long) buf, (unsigned long) (buf+count));
 
        /* Chip bug, set enable here */
        local_irq_save(flags);
@@ -287,7 +289,7 @@
        }
 
 
-       invalidate_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
+       dma_cache_inv((unsigned long) buf, (unsigned long) (buf+count));
 
        return count;
 }
@@ -298,10 +300,10 @@
 static int
 cpm_iic_write(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf,int count)
 {
-       volatile iic_t *iip = cpm->iip;
-       volatile i2c8xx_t *i2c = cpm->i2c;
-       volatile cpm8xx_t *cp = cpm->cp;
-       volatile cbd_t  *tbdf;
+       iic_t *iip = cpm->iip;
+       i2c8xx_t *i2c = cpm->i2c;
+       cpm8xx_t *cp = cpm->cp;
+       cbd_t   *tbdf;
        u_char *tb;
        unsigned long flags;
 
@@ -366,10 +368,10 @@
 static int
 cpm_iic_tryaddress(struct i2c_algo_8xx_data *cpm, int addr)
 {
-       volatile iic_t *iip = cpm->iip;
-       volatile i2c8xx_t *i2c = cpm->i2c;
-       volatile cpm8xx_t *cp = cpm->cp;
-       volatile cbd_t *tbdf, *rbdf;
+       iic_t *iip = cpm->iip;
+       i2c8xx_t *i2c = cpm->i2c;
+       cpm8xx_t *cp = cpm->cp;
+       cbd_t *tbdf, *rbdf;
        u_char *tb;
        unsigned long flags, len;
 
@@ -573,20 +575,14 @@
        return 0;
 }
 
+static void __exit i2c_algo_8xx_exit(void) 
+{
+}
+
 
-#ifdef MODULE
 MODULE_AUTHOR("Brad Parker <brad@heeltoe.com>");
 MODULE_DESCRIPTION("I2C-Bus MPC8XX algorithm");
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
-#endif
 
-int init_module(void) 
-{
-       return i2c_algo_8xx_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
+module_init(i2c_algo_8xx_init);
+module_exit(i2c_algo_8xx_exit);

Jeff Garzik wrote:
> 
> Albert Cranford wrote:
> > +static void
> > +cpm_iic_interrupt(void *dev_id, void *regs)
> > +{
> > +     volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;
> 
> no need for volatile
> 
> > +}
> > +
> > +static void
> > +cpm_iic_init(struct i2c_algo_8xx_data *cpm_adap)
> > +{
> > +     volatile iic_t          *iip = cpm_adap->iip;
> > +     volatile i2c8xx_t       *i2c = cpm_adap->i2c;
> 
> no need for volatile.  repeat this comment several times...
> 
> > +     if (cpm_adap->reloc = 0) {
> > +             volatile cpm8xx_t *cp = cpm_adap->cp;
> > +
> > +             cp->cp_cpcr > > +                     mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
> > +             while (cp->cp_cpcr & CPM_CR_FLG)
> > +                     cpu_relax(); /* prevent Athlons self-destruct */
> > +     }
> 
> don't busy-wait in a context where you can sleep
> 
> > +static void force_close(struct i2c_algo_8xx_data *cpm)
> > +{
> > +     if (cpm->reloc = 0) {
> > +             volatile cpm8xx_t *cp = cpm->cp;
> > +
> > +             if (cpm_debug) printk("force_close()\n");
> > +             cp->cp_cpcr > > +                     mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
> > +                     CPM_CR_FLG;
> > +
> > +             while (cp->cp_cpcr & CPM_CR_FLG)
> > +                     cpu_relax(); /* prevent Athlons self-destruct */
> > +     }
> 
> likewise for volatile and busy-wait
> 
> > +     tbdf->cbd_bufaddr = __pa(tb);
> > +     tbdf->cbd_datlen = count + 1;
> > +     tbdf->cbd_sc > > +             BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
> > +             BD_SC_WRAP | BD_IIC_START;
> > +
> > +     rbdf->cbd_datlen = 0;
> > +     rbdf->cbd_bufaddr = __pa(buf);
> > +     rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
> > +
> > +     dma_cache_inv((unsigned long) buf, (unsigned long) (buf+count));
> > +
> > +     /* Chip bug, set enable here */
> > +     local_irq_save(flags);
> > +     i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
> > +     i2c->i2c_i2cer = 0xff;
> > +     i2c->i2c_i2mod = 1;     /* Enable */
> > +     i2c->i2c_i2com = 0x81;  /* Start master */
> 
> __pa should very rarely be used in drivers
> 
> > +     /* Wait for IIC transfer */
> > +     interruptible_sleep_on(&iic_wait);
> > +     local_irq_restore(flags);
> > +     if (signal_pending(current))
> > +             return -EIO;
> 
> local_irq_xxx should not be used...
> 
> And it is very likely you should be using a semaphore here...
> 
> > +     /* Chip bug, set enable here */
> > +     local_irq_save(flags);
> > +     i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
> > +     i2c->i2c_i2cer = 0xff;
> > +     i2c->i2c_i2mod = 1;     /* Enable */
> > +     i2c->i2c_i2com = 0x81;  /* Start master */
> > +
> > +     /* Wait for IIC transfer */
> > +     interruptible_sleep_on(&iic_wait);
> > +     local_irq_restore(flags);
> > +     if (signal_pending(current))
> > +             return -EIO;
> 
> likewise
> 
> > +     printk("i2c-algo-8xx.o: adapter unregistered: %s\n",adap->name);
> > +
> > +#ifdef MODULE
> > +     MOD_DEC_USE_COUNT;
> > +#endif
> > +     return 0;
> 
> Is this MOD_DEC_USE_COUNT is for a file op, use ->owner instead.
> 
> > +#ifdef MODULE
> > +MODULE_AUTHOR("Brad Parker <brad@heeltoe.com>");
> > +MODULE_DESCRIPTION("I2C-Bus MPC8XX algorithm");
> > +#ifdef MODULE_LICENSE
> > +MODULE_LICENSE("GPL");
> > +#endif
> > +
> > +int init_module(void)
> > +{
> > +     return i2c_algo_8xx_init();
> > +}
> > +
> > +void cleanup_module(void)
> > +{
> > +}
> 
> kill ifdef MODULE.
> use module_init, module_exit

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

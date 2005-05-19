From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] 3/4 WIP I2C kernel patches-drivers
Message-Id: <m2elgdbwv4.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20B24.EF974F90@bellsouth.net>
In-Reply-To: <3CE20B24.EF974F90@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "albert" = Albert Cranford <ac9410@bellsouth.net> writes:

More commets

albert> @@ -49,8 +48,8 @@
albert> /* respectively. This makes sure that the algorithm works. Some chips   */
albert> /* might not like this, as they have an internal timeout of some mils  */
albert> /*
albert> -#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[minor].veryslow))\
albert> -                        cond_resched();
albert> +#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
albert> +                        if (need_resched) schedule();
albert> */
 
 
albert> @@ -117,12 +116,13 @@
albert> * while they are processing data internally. 
albert> */
albert> setscl(adap,1);
albert> -               if (time_after_eq(jiffies, start+adap->timeout)) {
albert> +               if (start+adap->timeout <= jiffies) {
albert> return -ETIMEDOUT;
albert> }
albert> -               cond_resched();
albert> +               if (current->need_resched)
albert> +                       schedule();

this three changes are bogus, the good changes are the ones in the kernel.

albert> @@ -620,7 +620,9 @@
albert> #ifdef MODULE
albert> MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
albert> MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif

Again, compat cruft.
 
albert> /* check to see S1 now used as R/W ctrl -
albert> PCF8584 does that when ESO is zero */
albert> -       /* PCF also resets PIN bit */
albert> -       if ((temp = get_pcf(adap, 1)) != (0)) {
albert> -               DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
albert> +       if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
albert> +               DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
albert> return -ENXIO; /* definetly not PCF8584 */
albert> }

If someone knows why this needs to be & with 0x7f will be nice,
i.e. one place where a commet will be on order.
 
albert> @@ -535,7 +533,9 @@
albert> #ifdef MODULE
albert> MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
albert> MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif

Again not needed.
 
 
albert> -static void __exit pcf_isa_exit(void)
albert> +static void pcf_isa_exit(void)
albert> {
albert> if (irq > 0) {
albert> disable_irq(irq);

Wrong change, that is an exit function.

albert> @@ -300,7 +302,9 @@
albert> #ifdef MODULE
albert> MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
albert> MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif

not needed again.
 
albert> -static void __exit bit_elv_exit(void)
albert> +static void bit_elv_exit(void)
albert> {
albert> release_region( base , (base = 0x3bc)? 3 : 8 );
albert> }

also exit function.

 
albert> @@ -200,7 +198,9 @@
albert> #ifdef MODULE
albert> MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
albert> MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif

Not needed again. 
 
albert> --- linux/drivers/i2c/i2c-philips-par.c.orig    2002-05-09 18:21:56.000000000 -0400
albert> +++ linux/drivers/i2c/i2c-philips-par.c 2002-05-14 18:02:15.000000000 -0400
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif

Not needed again. 

 
albert> -static void __exit bit_velle_exit(void)
albert> +static void bit_velle_exit(void)
albert> {      
albert> release_region( base , (base = 0x3bc)? 3 : 8 );
albert> }


it is really an exit function.
 
albert> #ifdef MODULE
albert> MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
albert> MODULE_DESCRIPTION("I2C-Bus adapter routines for Velleman K8000 adapter");
albert> +#ifdef MODULE_LICENSE
albert> MODULE_LICENSE("GPL");
albert> +#endif
 
Not needed.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

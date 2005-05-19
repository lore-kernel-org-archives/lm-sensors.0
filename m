From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Patches to Marcelo and Linus
Message-Id: <m2y9embjgj.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CDFF579.88423391@paradyne.com>
In-Reply-To: <3CDFF579.88423391@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "albert" = Albert Cranford <ac9410@bellsouth.net> writes:

Hi

albert> OK I'll work on i2c & lm_sensors2 in 2.5.  Are you also
albert> integrating i2c in 2.4?

i2c mkpatch, generates this parts in the patch that I think are
wrong. could someone confirm that they are wrong?
I think that we should put that things on cvs, I am not sure if this
should be there.


--- linux-old/drivers/i2c/i2c-algo-bit.c	Tue May  7 11:03:31 CEST 2002
+++ linux/drivers/i2c/i2c-algo-bit.c	Tue May  7 11:03:31 CEST 2002
@@ -50,5 +49,5 @@
 /* might not like this, as they have an internal timeout of some mils	*/
 /*
-#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[minor].veryslow))\
+#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
                         if (need_resched) schedule();
 */
@@ -118,5 +117,5 @@
  		 */
 		setscl(adap,1);
-		if (time_after_eq(jiffies, start+adap->timeout)) {
+		if (start+adap->timeout <= jiffies) {
 			return -ETIMEDOUT;
 		}

This change is bogus, time_after/time_before is the right interface.


--- linux-old/drivers/i2c/i2c-elektor.c	Tue May  7 11:03:33 CEST 2002
+++ linux/drivers/i2c/i2c-elektor.c	Tue May  7 11:03:33 CEST 2002
@@ -160,5 +160,5 @@
 
 
-static void __exit pcf_isa_exit(void)
+static void pcf_isa_exit(void)
 {
 	if (irq > 0) {

Other exit change.

--- linux-old/drivers/i2c/i2c-elv.c	Tue May  7 11:03:33 CEST 2002
+++ linux/drivers/i2c/i2c-elv.c	Tue May  7 11:03:33 CEST 2002
@@ -116,5 +114,5 @@
 }
 
-static void __exit bit_elv_exit(void)
+static void bit_elv_exit(void)
 {
 	release_region( base , (base = 0x3bc)? 3 : 8 );

this should be marked exit, really.

--- linux-old/drivers/i2c/i2c-proc.c	Tue May  7 11:03:34 CEST 2002
+++ linux/drivers/i2c/i2c-proc.c	Tue May  7 11:03:34 CEST 2002
@@ -120,8 +122,4 @@
 	}
 	*name = kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
-	if (!*name) {
-		printk (KERN_WARNING "i2c_create_name: not enough memory\n");
-		return -ENOMEM;
-	}
 	strcpy(*name, name_buffer);
 	return 0;

Removing than looks really bad, you need to check for no memory.


@@ -181,7 +179,8 @@
 
 	if (!(new_header = register_sysctl_table(new_table, 0))) {
+		printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by kernel!\n");
 		kfree(new_table);
 		kfree(name);
-		return -ENOMEM;
+		return -EPERM;
 	}

I am not sure about this change, ENOMEM looks more sane here, not sure about this.

 
--- linux-old/drivers/i2c/i2c-velleman.c	Tue May  7 11:03:34 CEST 2002
+++ linux/drivers/i2c/i2c-velleman.c	Tue May  7 11:03:34 CEST 2002
@@ -104,5 +103,5 @@
 }
 
-static void __exit bit_velle_exit(void)
+static void bit_velle_exit(void)
 {	
 	release_region( base , (base = 0x3bc)? 3 : 8 );

Why do you remove this s/__exit//?
THis function is only called from a exit funcion.


--- linux-old/drivers/i2c/Config.in	Tue May  7 11:03:35 CEST 2002
+++ linux/drivers/i2c/Config.in	Tue May  7 11:03:35 CEST 2002
@@ -11,20 +11,14 @@
    dep_tristate 'I2C bit-banging interfaces'  CONFIG_I2C_ALGOBIT $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
-      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
-      dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
-      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_BITLP $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
+      dep_tristate '  ELV adapter' CONFIG_I2C_BITELV $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_BITVELLE $CONFIG_I2C_ALGOBIT


Why s/PHILPSPAR/BITLP/?
Why s/ELV/BITELV/?
Why s/VELLEMAN/BITVELLE/?


-      dep_tristate '  Elektor ISA card' CONFIG_I2C_ELEKTOR $CONFIG_I2C_ALGOPCF
+      dep_tristate '  Elektor ISA card' CONFIG_I2C_PCFISA $CONFIG_I2C_ALGOPCF

Why this change s/ELEKTOR/PFCISA/?
 
-   if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
-      dep_tristate 'ITE I2C Algorithm' CONFIG_ITE_I2C_ALGO $CONFIG_I2C
-      if [ "$CONFIG_ITE_I2C_ALGO" != "n" ]; then
-         dep_tristate '  ITE I2C Adapter' CONFIG_ITE_I2C_ADAP $CONFIG_ITE_I2C_ALGO
-      fi
-   fi

i2c 2.6.3 don't have this driver either, and kernel has it.

@@ -40,13 +35,10 @@
    fi
 
-   if [ "$CONFIG_ALL_PPC" = "y" ] ; then
-      dep_tristate 'Keywest I2C interface in Apple Core99 machines' CONFIG_I2C_KEYWEST $CONFIG_I2C
-   fi
-

I2C don't have this driver :(



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

From: jamagallon@able.es (J . A . Magallon)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: __exit modifiers
Message-Id: <20011028233732.C2816@werewolf.able.es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

More questions on recent CVS. After your CONFIG_xxx update (thanks), 
mkpatch still spits this (cropped lo leave the interesting part):

--- linux-old/drivers/i2c/i2c-elektor.c Sun Oct 28 23:20:59 CET 2001
+++ linux/drivers/i2c/i2c-elektor.c Sun Oct 28 23:20:59 CET 2001
@@ -160,5 +159,5 @@
 
 
-static void __exit pcf_isa_exit(void)
+static void pcf_isa_exit(void)
 {
    if (irq > 0) {
--- linux-old/drivers/i2c/i2c-elv.c Sun Oct 28 23:21:00 CET 2001
+++ linux/drivers/i2c/i2c-elv.c Sun Oct 28 23:21:00 CET 2001
@@ -116,5 +114,5 @@
 }

-static void __exit bit_elv_exit(void)
+static void bit_elv_exit(void)
 {
    release_region( base , (base = 0x3bc)? 3 : 8 );
--- linux-old/drivers/i2c/i2c-velleman.c    Sun Oct 28 23:21:04 CET 2001
+++ linux/drivers/i2c/i2c-velleman.c    Sun Oct 28 23:21:04 CET 2001
@@ -104,5 +103,5 @@
 }

-static void __exit bit_velle_exit(void)
+static void bit_velle_exit(void)
 {
    release_region( base , (base = 0x3bc)? 3 : 8 );


Note the __exit present in standard kernel and missing in i2c CVS tree. I think
it drops the exit functions when built statically.

Should it be added, isn't it ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-ac3-beo #1 SMP Sun Oct 28 09:44:34 CET 2001 i686

From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: [PATCH] cli & sti replaced in 2.5.28
Message-Id: <3D48BA63.C4651CAD@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,
Ingo Molner removed cli, sti, save_flags, restore_flags
in 2.5.28.
His document/reasoning is in:
linux/Documentation/cli-sti-removal.txt

I have taken this info and made adjustment for kernels:
2.4.18, 2.4.19 and 2.5.29 on my web page.
I am able to quicktest on i386 architecture only.  For the
2.2.21 kernel I was able to compile only and need some help
testing.  Other architectures compile successfully but need
testing.

The modules affected are:
i2c_adap_ite
i2c-adap_ibm_ocp
i2c_algo_8xx
i2c_pcf_epp
i2c-elektor

Any feedback is welcomed,
Albert

#### cli()/sti() removal guide, started by Ingo Molnar <mingo@redhat.com>
as of 2.5.28, five popular macros have been removed on SMP, and
are being phased out on UP:

 cli(), sti(), save_flags(flags), save_flags_cli(flags), restore_flags(flags)
----------
    local_irq_save(flags)     => save the current IRQ state into flags and
                                 disable interrupts.
    local_irq_restore(flags)  => restore the IRQ state from flags.
--------------

--- i2c-elektor.c.orig  2002-07-30 01:17:21.000000000 -0400
+++ i2c-elektor.c       2002-07-30 01:19:24.000000000 -0400
@@ -119,14 +119,15 @@
 static void pcf_isa_waitforpin(void) {
 
        int timeout = 2;
+       spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
 
        if (irq > 0) {
-               cli();
+               spin_lock_irq(&driver_lock);
                if (pcf_pending = 0) {
                        interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
                } else
                        pcf_pending = 0;
-               sti();
+               spin_unlock_irq(&driver_lock);
        } else {
                udelay(100);
        }
--- i2c-algo-8xx.c      2002-06-11 22:29:54.000000000 -0400
+++ /usr/src/linux/drivers/i2c/i2c-algo-8xx.c   2002-07-30 23:27:52.000000000 -0400
@@ -248,7 +248,7 @@
        invalidate_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
 
        /* Chip bug, set enable here */
-       save_flags(flags); cli();
+       local_irq_save(flags);
        i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
        i2c->i2c_i2cer = 0xff;
        i2c->i2c_i2mod = 1;     /* Enable */
@@ -257,7 +256,7 @@
 
        /* Wait for IIC transfer */
        interruptible_sleep_on(&iic_wait);
-       restore_flags(flags);
+       local_irq_restore(flags);
        if (signal_pending(current))
                return -EIO;
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

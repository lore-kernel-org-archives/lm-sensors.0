From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Jul 2005 22:38:52 +0000
Subject: [lm-sensors] problems loading i2c-proc
Message-Id: <20050707223836.35996bc8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> Problems happen in i686 and athlon architectures.  Opteron (x86_64)is
> ok. Compiles are clean on all.
> When I do  modprobe i2c-proc, the following happens:
> 
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol create_proc_entry_R0be93f3a
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol kmalloc_R93d4cfe6
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol __generic_copy_to_user_Rd523fdd3
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol remove_proc_entry_Re94539f7
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol proc_bus_Rd6eafc0f
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol sprintf_R1d26aa98
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol kfree_R037a0cba
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o:
> unresolved  symbol printk_R1b7d4074
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o: insmod
> 
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o failed
> /lib/modules/2.4.21-32.0.1.ELsmp/kernel/drivers/i2c/i2c-core.o: insmod
> 
> i2c-procfailed
> 
> 
> Any idea what might be wrong?  Some wrong header getting into the
> compile somewhere?  Other?  As I say, x86_64 version is OK.

Make sure you have File Systems > /proc file system support enabled
(CONFIG_PROC_FS). In theory i2c-proc should depend on it (in Config.in),
but now it looks like it doesn't...

Another possibility is a problem with symbol versioning, which you seem
to have enabled. It should work, but maybe you could try without
versioning, just in case.

Hope that helps,
-- 
Jean Delvare

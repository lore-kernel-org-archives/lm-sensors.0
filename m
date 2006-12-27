From: a@gaydenko.com (Andrew Gaydenko)
Date: Wed, 27 Dec 2006 22:49:34 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <200612280149.34257@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, being waiting for answer, I have tried to patch a kernel. Patching
was OK (except for rejecting in ./Documentation/...). Kernel making gives:

...
Kernel: arch/x86_64/boot/bzImage is ready  (#25)
  Building modules, stage 2.
  MODPOST 165 modules
WARNING: "msr_read" [drivers/hwmon/coretemp.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

.config contains this row: CONFIG_X86_MSR=y I have tried to see
all 'msr_read' occurences, 'grep 'msr_read' -R /usr/src/linux-2.6.19-w-r2/*'
output is:

Binary file /usr/src/linux-2.6.19-w-r2/arch/x86_64/kernel/msr.o matches
Binary file /usr/src/linux-2.6.19-w-r2/arch/x86_64/kernel/built-in.o matches
/usr/src/linux-2.6.19-w-r2/arch/i386/kernel/msr.c:static ssize_t msr_read(struct file *file, char __user * buf,
/usr/src/linux-2.6.19-w-r2/arch/i386/kernel/msr.c:      .read = msr_read,
Binary file /usr/src/linux-2.6.19-w-r2/arch/i386/kernel/msr.o matches
/usr/src/linux-2.6.19-w-r2/drivers/hwmon/coretemp.c:            msr_read(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
/usr/src/linux-2.6.19-w-r2/drivers/hwmon/coretemp.c:            err = msr_read(data->id, 0xee, &eax, &edx);
/usr/src/linux-2.6.19-w-r2/drivers/hwmon/coretemp.c:    err = msr_read(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
Binary file /usr/src/linux-2.6.19-w-r2/drivers/hwmon/coretemp.o matches
/usr/src/linux-2.6.19-w-r2/System.map:ffffffff8026b3d0 t msr_read
Binary file /usr/src/linux-2.6.19-w-r2/vmlinux matches

Where is my failt? 
gentoo-sources-2.6.19-r2 kernel tree is in use.


Andrew


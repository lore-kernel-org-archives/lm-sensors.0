From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710122919.715ca2e6.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Jul 2003 11:51:37 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> OK, I see what's happening. You do have I2C enabled in your current
> kernel, *built-in* (CONFIG_I2C=y), don't you?
> 
> INSTALL says:
> Your I2C support must NOT be built-in your kernel already!
> It must either be disabled or enabled as modules.
> 
> We don't prevent i2c from compiling in this case for very specific
> cases, but it generally won't work, because then lm_sensors has to use
> your kernel i2c headers, which are out of date.
> 
> If I'm right, you'll have to rebuild a kernel with either I2C as a
> module or disabled, and then i2c and lm_sensors will install properly.

Ok, great. Compiled and installed. Thanks!

But now I get the ususal 'no sensors detected'

I tried to force load some ISA/Bus and now sensors-detect gives me a segmentation fault after
whitie:/usr/src/modules/lm_sensors2# sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.
 
 BIOS vendor (ACPI): ASUS
 System vendor (DMI): System Manufacturer
 BIOS version (DMI): ASUS PU-DLS/533 ACPI BIOS Revision 1003
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.
 
 We will now try to load each adapter module in turn.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.
 
 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
Segmentation fault

Any ideas?

Thanks for your Feedback.

Zeno

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Thu, 22 Mar 2012 14:40:40 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <20120322144039.GC16653@burratino>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320231656.GC12339@burratino>
In-Reply-To: <20120320231656.GC12339@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Luca Tettamanti wrote:

> Not really, I _suspect_ that there's a bug in the BIOS, but I wasn't
> able to confirm it; maybe it's something that the driver does.
> In the thread that you link Javier never replied with the results of the test.

Oh!  Let's pursue that if possible.

Here's a diff between Javier's and GSR's DSDT --- they are pretty
similar.  This means the custom ACPI method from [1] should work
without needing any change, right?

Instructions:

 0. Prerequisites:

	apt-get install git build-essential

 2. Get the kernel, if you don't already have it:

	git clone \
	  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

 3. Configure:

	cd linux
	cp /boot/config-$(uname -r) .config; # current configuration
	make localmodconfig; # optional: minimize configuration
	make nconfig; # tweak configuration:
	 Device Drivers --> Hardware Monitoring support --> ACPI drivers
	  --> ASUS ATK0110 (make it a module)
	 Power management and ACPI options ---> ACPI Support
	  ---> Allow ACPI methods to be inserted/replaced at run time
	  (enable it or make it a module)

 4. Build:

	make deb-pkg; # optionally with -j<num> for parallel build
	dpkg -i ../<name of package>; # as root

 5. Make sure asus_atk0110 driver doesn't autoload:

	echo blacklist asus_atk0110 >/etc/modprobe.d/gsr-fix-keyboard.conf

 6. Test:

	reboot
	mount -t debugfs debug /sys/kernel/debug
	modprobe custom_method
	cat DSDT.aml >/sys/kernel/debug/acpi/custom_method
	... everything ok? ...
	modprobe asus_atk0110
	... everything still ok? ...

The DSDT.aml with custom method mentioned above can be found at [1].

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.linux.drivers.sensors/24194/focus&426

diff --git 1/javier-DSDT.dsl 2/gsr-DSDT.dsl
index e8e12dbd..7446f856 100644
--- 1/javier-DSDT.dsl
+++ 2/gsr-DSDT.dsl
@@ -2,14 +2,14 @@
  * Intel ACPI Component Architecture
  * AML Disassembler version 20100528
  *
- * Disassembly of DSDT.dat, Tue Jun  7 17:53:36 2011
+ * Disassembly of DSDT.dat, Thu Mar 22 08:57:47 2012
  *
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000EF4D (61261)
+ *     Length           0x0000EEF8 (61176)
  *     Revision         0x01 **** ACPI 1.0, no 64-bit math support
- *     Checksum         0x4D
+ *     Checksum         0xC1
  *     OEM ID           "A1326"
  *     OEM Table ID     "A1326001"
  *     OEM Revision     0x00000001 (1)
@@ -17537,17 +17537,6 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, "A1326", "A1326001", 0x00000001)
             "Crazy-3.7G", 
             "Crazy-3.8G"
         })
-        Name (GF10, Package (0x08)
-        {
-            0x0F080000, 
-            "CPU Level Up", 
-            Zero, 
-            Zero, 
-            0x03, 
-            "Original", 
-            "Crazy-3.8G", 
-            "Crazy-4.0G"
-        })
         Method (GRPF, 0, NotSerialized)
         {
             Store (GNVS (0x52D1), Local0)
@@ -17632,16 +17621,6 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, "A1326", "A1326001", 0x00000001)
                                                     GF09
                                                 })
                                             }
-                                            Else
-                                            {
-                                                If (LEqual (_T_0, 0x0A))
-                                                {
-                                                    Return (Package (0x01)
-                                                    {
-                                                        GF10
-                                                    })
-                                                }
-                                            }
                                         }
                                     }
                                 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

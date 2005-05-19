From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH] RC1 2.6 busses docummentation
Message-Id: <20050301172315.GA16780@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0502242000290.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0502242000290.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Thu, Feb 24, 2005 at 08:04:01PM +0100, Rudolf Marek wrote:
> Hello,
Hi !
 
> Last chance for comments :)
I have looked a it, looks fine for me, except a few cosmetic changes
concerning spaces and indentation. Please find my comments below.

Bye,
Aurelien


diff -Naur a/Documentation/i2c/busses/i2c-ali15x3 b/Documentation/i2c/busses/i2c-ali15x3
--- a/Documentation/i2c/busses/i2c-ali15x3	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-ali15x3	2005-02-24 17:12:19.000000000 +0100
+ * "Aladdin Pro 2" Includes the M1621 Slot 1 North bridge with AGP and
                    ^
   no need to capitalize the first letter
+ 		100MHz CPU Front Side bus
+ * "Aladdin V" Includes the M1541 Socket 7 North bridge with AGP and 100MHz
                ^
              idem
..
+  * "Aladdin IV" Includes the M1541 Socket 7 North bridge
                  ^
		idem
+   		with host bus up to 83.3 MHz.
..
+For an overview of these chips see http://www.acerlabs.com At this time the
                                                          ^^^
                                                     A dot is missing
diff -Naur a/Documentation/i2c/busses/i2c-ali1563 b/Documentation/i2c/busses/i2c-ali1563
--- a/Documentation/i2c/busses/i2c-ali1563	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-ali1563	2005-02-24 17:08:36.000000000 +0100
+The M1563 southbridge is deceptively similar to the M1533, with a  few
                                                                  ^
                                                               too much spaces 
+notable exceptions. One of those happens to be the fact they  upgraded the
                                                              ^
                                                            idem
+i2c core to be SMBus 2.0 compliant, and happens to be almost  identical to
                                                             ^
                                                            idem
diff -Naur a/Documentation/i2c/busses/i2c-parport-light b/Documentation/i2c/busses/i2c-parport-light
--- a/Documentation/i2c/busses/i2c-parport-light	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-parport-light	2005-02-24 17:18:15.000000000 +0100
@@ -0,0 +1,11 @@
+Kernel driver i2c-parport-light
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+This driver is a light version of i2c-parport.  It doesn't depend
+on the parport driver, and uses direct I/O access instead.  This might be
+prefered on embedded systems where wasting memory for  the clean but heavy
                                                       ^
						     too much spaces
+parport handling is not an option.  The   drawback is a reduced portability
                                         ^
                                        idem
+and the impossibility to dasiy-chain other parallel port devices.
+
+Please see i2c-parport for documentation.
diff -Naur a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
--- a/Documentation/i2c/busses/i2c-piix4	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-piix4	2005-02-24 17:18:45.000000000 +0100
+On some computers (most notably, some Dells), the SMBus is disabled by
+default. If you use the insmod parameter 'force=1', the kernel module  will
                                                                      ^
                                                                  too much space								    
diff -Naur a/Documentation/i2c/busses/i2c-sis5595 b/Documentation/i2c/busses/i2c-sis5595
--- a/Documentation/i2c/busses/i2c-sis5595	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-sis5595	2005-02-24 17:19:20.000000000 +0100
@@ -0,0 +1,59 @@
+Kernel driver i2c-sis5595
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>,
+	Philip Edelbrock <phil@netroedge.com>
indentation problem. Two lines are indented with tabs, the other with spaces.

+WARNING: If you are trying to access the integrated sensors on the  SiS5595
                                                                   ^^^
                                                                 too much space
diff -Naur a/Documentation/i2c/busses/i2c-sis630 b/Documentation/i2c/busses/i2c-sis630
--- a/Documentation/i2c/busses/i2c-sis630	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-sis630	2005-02-24 17:20:24.000000000 +0100
+* force = [1|0] Forcibly enable the SIS630. DANGEROUS!
+		This can be interesting for chipsets not named
+		above to check if it works for you chipset, but DANGEROUS!
+
+* high_clock = [1|0] Forcibly set Host Master Clock to 56KHz (default,what
                                                                     ^^^
                                                                 space is missing
+			your BIOS use). DANGEROUS! This should be a bit
+			faster, but freeze some systems (i.e. my Laptop).
Would be nice to have this indented the same way as for force

diff -Naur a/Documentation/i2c/busses/i2c-sis69x b/Documentation/i2c/busses/i2c-sis69x
--- a/Documentation/i2c/busses/i2c-sis69x	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-sis69x	2005-02-24 17:21:09.000000000 +0100
those of the SiS630, although they are located in a completely different
+place.  Thanks to Alexander Malysh <amalysh@web.de> for providing the
+SiS630 datasheet (and  driver).
                     ^^^^
                   too much space

+If you cant see it  please look on quirk_sis_96x_smbus
                  ^^^^
		  idem
		  
-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

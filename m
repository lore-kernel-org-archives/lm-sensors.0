From: joerg@dorchain.net (Joerg Dorchain)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031216101852.GF953@GreenHouse.dorchain.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 15, 2003 at 09:04:57PM +0100, Jean Delvare wrote:
> No, no. At 0x2d there is your main chipset (ASB100 "Bach"). The
> W83L785TS-S is really at 0x2e.
> 
> Please provide the output of "i2cdump 1 0x2e" anew so that I can compare
> with the old values.

Ok:
 i2cdump 1 0x2e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x2e, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff XX ff ff ff ff ff ff ff ff ff ff ff ff    ...X............
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 39 3a 00 00 00 00 58 28 00 00 00 ff 00 ff 00 00    9:....X(........
30: 00 00 00 00 00 00 00 50 4b 50 4b 00 00 00 00 00    .......PKPK.....
40: 0d 00 00 00 00 80 ff ff ff ff ff ff a3 5c 70 ff    ?....?......?\p.
50: 06 04 03 64 7f 4b 46 4b 46 00 fa bc ff ff ff ff    ???d?KFKF.??....
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff 00 18 ff ff ff ff ff ff ff ff ff    ......?.........
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: c9 02 3a 71 39 38 37 33 ff ff ff ff ff ff XX ff    ??:q9873......X.
f0: ff 2e 00 XX XX XX 00 ff 00 00 ff 00 00 02 ff ff    ...XXX.......?..

> Well, you seem to know what you're talking about. I applied your patch
> but it doesn't seem to do anything. The EXLDFLAGS variable is not used
> when I compile sensors. Are there any other steps to take?

The EXLDFLAGS was just "there" in the main makefile. I just now learned
how the makefile approach for this package works, and IMHO it is a
great concept. A patch which works for all programs is included now.

BTW, one further optimization (i.e. play computer-scientists favourite
game "add another abstraction layer" ;-) might be to have variable like
COMPILE := $(CC) $(CFLAGS) and LINK := $(CC) $(LDFLAGS), as these
combinations seem to be common.

Bye,

Joerg


--- ./prog/detect/Module.mk.orig	2003-11-29 20:38:10.000000000 +0100
+++ ./prog/detect/Module.mk	2003-12-16 11:03:59.000000000 +0100
@@ -36,7 +36,7 @@
 user :: all-prog-detect
 
 $(MODULE_DIR)/i2cdetect: $(MODULE_DIR)/i2cdetect.ro prog/dump/i2cbusses.ro
-	$(CC) -o $@ $^
+	$(CC) $(EXLDFLAGS) -o $@ $^
 
 install-prog-detect: all-prog-detect
 	mkdir -p $(DESTDIR)$(SBINDIR)
--- ./prog/dump/Module.mk.orig	2003-11-21 05:05:48.000000000 +0100
+++ ./prog/dump/Module.mk	2003-12-16 11:04:42.000000000 +0100
@@ -38,10 +38,10 @@
 user :: all-prog-dump
 
 $(MODULE_DIR)/i2cdump: $(MODULE_DIR)/i2cdump.ro $(MODULE_DIR)/i2cbusses.ro
-	$(CC) -o $@ $^
+	$(CC) $(EXLDFLAGS) -o $@ $^
 
 $(MODULE_DIR)/i2cset: $(MODULE_DIR)/i2cset.ro $(MODULE_DIR)/i2cbusses.ro
-	$(CC) -o $@ $^
+	$(CC) $(EXLDFLAGS) -o $@ $^
 
 install-prog-dump: all-prog-dump
 	mkdir -p $(DESTDIR)$(SBINDIR)
--- ./prog/sensord/Module.mk.orig	2003-08-11 10:47:15.000000000 +0200
+++ ./prog/sensord/Module.mk	2003-12-16 11:05:59.000000000 +0100
@@ -38,7 +38,7 @@
 INCLUDEFILES += $(PROGSENSORDSOURCES:.c=.rd)
 
 $(PROGSENSORDTARGETS): $(PROGSENSORDSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
-	$(CC) -o $@ $(PROGSENSORDSOURCES:.c=.ro) -Llib -lsensors -lrrd
+	$(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORDSOURCES:.c=.ro) -Llib -lsensors -lrrd
 
 all-prog-sensord: $(PROGSENSORDTARGETS)
 user :: all-prog-sensord
--- ./prog/sensors/Module.mk.orig	2003-06-28 22:04:50.000000000 +0200
+++ ./prog/sensors/Module.mk	2003-12-16 11:06:24.000000000 +0100
@@ -34,7 +34,7 @@
 INCLUDEFILES += $(PROGSENSORSSOURCES:.c=.rd)
 
 $(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
-	$(CC) -o $@ $(PROGSENSORSSOURCES:.c=.ro) -Llib -lsensors
+	$(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.c=.ro) -Llib -lsensors
 
 all-prog-sensors: $(PROGSENSORSTARGETS)
 user :: all-prog-sensors
--- ./Makefile.orig	2003-12-14 15:40:38.000000000 +0100
+++ ./Makefile	2003-12-14 15:44:53.000000000 +0100
@@ -95,6 +95,8 @@
 # library files (both static and shared) will be installed.
 LIBDIR := $(PREFIX)/lib
 
+EXLDFLAGS := -Wl,-rpath,$(LIBDIR)
+
 # You should not need to change this. It is the directory into which the
 # executable program files will be installed. BINDIR for programs that are
 # also useful for normal users, SBINDIR for programs that can only be run

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031216/e7245769/attachment.bin

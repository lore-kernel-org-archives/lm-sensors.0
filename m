From: joerg@dorchain.net (Joerg Dorchain)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031214145805.GC953@GreenHouse.dorchain.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 14, 2003 at 03:24:26PM +0100, Jean Delvare wrote:
> 
> So it's already in there.

Yes, this should have been sufficient even for me ;)
> 
> BTW, could you please provide a dump of your chip? The data sheet isn't
> always clear about how things should be handled, so a sample dump would
> help:
> 
> i2cdump 0 0x2e (or i2cdump 1 0x2e if it's on the second bus).

Here you are:
 i2cdump 1 0x2e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x2e, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff XX ff XX ff    ............X.X.
10: ff XX ff ff ff ff ff ff ff ff XX XX ff ff ff ff    .X........XX....
20: 39 3a 00 00 00 00 59 2a 00 00 00 XX 00 ff 00 00    9:....Y*...X....
30: 00 00 00 00 00 XX 00 50 4b 50 4b 00 00 00 00 00    .....X.PKPK.....
40: 0d 00 00 00 00 80 ff ff ff XX ff ff a3 5c 70 ff    ?....?...X..?\p.
50: 06 04 03 64 7f 4b 46 XX 46 00 fa bc ff ff ff ff    ???d?KFXF.??....
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff XX ff ff ff ff ff    ..........X.....
80: ff ff ff ff ff 00 18 ff ff ff ff ff ff ff ff ff    ......?.........
90: ff XX ff ff ff ff ff ff ff XX ff ff ff ff ff ff    .X.......X......
a0: ff ff ff ff ff ff ff ff ff ff XX ff ff ff ff ff    ..........X.....
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff XX ff    ..............X.
e0: c9 02 3a 71 39 38 37 XX ff ff ff ff ff ff ff ff    ??:q987X........
f0: ff 2e 00 ff 00 62 00 ff 00 00 XX 00 00 XX ff ff    .....b....X..X..

> > One more note on making lm_sensors more "package-friendly". You could
> > add -rpath $PREFIX/lib (or -R, depending on the linker) to make sure
> > that libsensors is always found by the package binaries. For testing,
> > I use prefix=/usr/local/lm_sensors, so this would help me.
> 
> I'm not sure I understand what you need. Could you please provide a
> patch against CVS that does what you want?

Something like
--- Makefile.orig       2003-12-14 15:40:38.000000000 +0100
+++ Makefile    2003-12-14 15:44:53.000000000 +0100
@@ -95,6 +95,8 @@
 # library files (both static and shared) will be installed.
 LIBDIR := $(PREFIX)/lib
  
+EXLDFLAGS := -Wl,-rpath,$(LIBDIR)
+
 # You should not need to change this. It is the directory into which the
 # executable program files will be installed. BINDIR for programs that  are
 # also useful for normal users, SBINDIR for programs that can only be run

So that libraries are found. Verify e.g. with
 ldd /usr/local/lm_sensors/bin/sensors
        libsensors.so.3 => /usr/local/lm_sensors/lib/libsensors.so.3 (0x40018000)
        libc.so.6 => /lib/libc.so.6 (0x40045000)
        libm.so.6 => /lib/libm.so.6 (0x40178000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

Unfortunately I do not understand the recursive make system well enough
ATM for a complete patch.

Additionally, some toolchains use -R as the linker argument for the same
effect (e.g. Solaris ld). Luckily IMHO gnu ld is a sure assumption.

Bye,

Joerg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031214/0943c7ae/attachment.bin

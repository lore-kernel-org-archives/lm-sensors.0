From: joerg@dorchain.net (Joerg Dorchain)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031215135305.GD953@GreenHouse.dorchain.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 14, 2003 at 06:07:03PM +0100, Jean Delvare wrote:
> 
> > Here you are:
> >  i2cdump 1 0x2e
> > No size specified (using byte-data access)

Hm, with some close look I noticed that it is 0x2d. I have no idea what
the output means, but does this look better somehow?

 i2cdump 1 0x2d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: b6 bb a8 64 c4 ce 00 cd a7 f8 a5 ac 8c 68 54 f8    ???d??.??????hT?
10: a5 f8 a5 ff 00 00 00 19 50 4b 24 50 4b 00 00 00    ???....?PK$PK...
20: 6a 6a d1 b6 bd bd bd 1c 65 ff ff 7b 52 7b 52 e3    jj??????e..{R{R?
30: b9 cd a7 ed 9d 00 00 00 00 50 4b 20 05 00 00 00    ?????....PK ?...
40: 01 00 00 00 00 20 00 58 00 40 01 48 00 05 80 06    ?.... .X.@?H.???
50: ff ff 00 ff ff ff ff ff 31 8f 00 01 ff 84 e2 1f    ........1?.?.???
60: 6a 6a d1 b6 bd bd bd 1c 65 ff ff 7b 52 7b 52 e3    jj??????e..{R{R?
70: b9 cd a7 ed 9d 00 00 00 00 50 4b 20 05 00 00 00    ?????....PK ?...
80: b6 bb a8 64 c4 ce 00 cd a7 f8 a5 ac 8c 68 54 f8    ???d??.??????hT?
90: a5 f8 a5 ff 00 00 00 19 50 4b 24 50 4b 00 00 00    ???....?PK$PK...
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

just tell me if more or other dumps will help.

> Anyway, I just finished the new driver and commited it to our CVS
> repository. Support is preliminary, which means that the driver should
> work with minimal functions, and sensors-detect knows about the driver,
> but there is no sensors/libsensors support yet.
> 
> Could you please give it a try? You'll also have to get an updated
> i2c-id.h file. No need to reinstall i2c completely, get the updated file
> from here:
> http://www2.lm-sensors.nu/~lm78/cvs/i2c/kernel/i2c-id.h
> Then just update your local cvs lm_sensors2 checkout, compile it (maybe
> with DEBUG set at first), install it, and try loading the w83l785ts
> module.

Did so.

> 
> If it works, you should be able to see a temp file here:
> /proc/sys/dev/sensors/w83l785ts-i2c-0-2e/

 cat /proc/sys/dev/sensors/w83l785ts-i2c-1-2e/temp
-1 40

> Hmm. If I understand you well, this is meant so that at *runtime*, the
> sensors binary knows where to look for libsensors? There's already

Exactly.

> /etc/ld.so.conf for that, and LD_LIBRARY_PATH too. I'm not sure that
> binaries looking at specific places by themselves are considered very
> safe. And even without security considerations, what if the end-user
> wants to change which libraries are used? Wouldn't he/she get confused
> that the binary doesn't follow the usual ld.so.conf order?

I consider it good practice for packages that contain shared libraries
and binaries using them that they look for their own libraries under
their own prefix. It helps testing a lot, especially with several
non-distro-bundled packages or different version at the same time.
Of course, ld.so.conf does this, but systemwide for all programs, and
gets bloated when used this way. LD_LIBRARY_PATH is a bad hack and
does more harm than good if you use it like you should ld.so.conf 

This path is prepended to the paths in ld.so.conf, so in case it is a
standard path, it does not matter, and if not it follows the principle
of least surprise if a package program prefers its own libs and paths.
Even without any -rpath a program looks in /lib and /usr/lib, Adding one
more is no change in quality and only consequent when using a custom
install prefix.

The man-page section of gnu ld about -rpath and -rapth-link are quite
informative about it.

From the security point of view, use statically linked binaries. All
sort of user input, including possibly tainted shared libs, can't be
trusted. For the really paranoid you could replace the -rpath in LDFLAGS
by -static, Maybe with a comment in the makefile to chosse from
traditional, comfortable, or paranoid versions.

IMHO lm_sensors is about to reach "business grade" stability, so
non-functional features become more of a development focus than the
already settled and stable parts.

Bye,

Joerg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031215/5a715f4b/attachment.bin

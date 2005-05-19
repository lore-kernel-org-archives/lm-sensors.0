From: joerg@dorchain.net (Joerg Dorchain)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Installation report/Feedback
Message-Id: <20031214124333.GB953@GreenHouse.dorchain.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 07, 2003 at 11:28:08PM +0100, Jean Delvare wrote:
> > (...)
> > Unknown EEPROM type (32)
> 
> This is a known bug and is fixed in CVS.

Yes. Great!
> 
> Yes, it is very important, especially since version 2.8.1, because a
> change in the i2c structures make original modules and newly compiled
> module incompatible.

IMHO it could be stressed a bit more that all three (running kernel,
kernel source and lm_sensor) should be the same to avoid trouble. I
somehowhad a different source than the running kernel. Well, more idot
proof thing will created more creative idiot ;-)

> As for temp2, there are three possible formulae in sensors.conf, try the
> other ones.

Actually is is mentioned in the comments. Reading the right parts is an
art ;-)

> 
> > - sensors-detect produced a line # no driver for Winbond W83L785TS
> > yet, ask us for one! and so I do ;-)
> 
> OK, will write a driver if I can find some spare time.

Great! Thank you.
> 
> BTW, your chipset isn't really an AS99127F, but an ASB100. We now have a
> separate driver for it in CVS, you should give it a try. The i2c patch
> you used is OK, you just need to download and install lm_sensors2 CVS:
> http://secure.netroedge.com/~lm78/download.html#cvs
> We still need to update sensors-detect to reflect that, so don't trust
> it when it says you should use the w83781d driver, and use asb100
> instead.

This seems to be already done.

One more note on making lm_sensors more "package-friendly". You could
add -rpath $PREFIX/lib (or -R, depending on the linker) to make sure
that libsensors is always found by the package binaries. For testing, I
use prefix=/usr/local/lm_sensors, so this would help me.

Also a make uninstall target (of course, automatically in sync with make
install, in the worst case via a generated file list) would IMHO
encourage people to try things.

Bye,

Joerg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031214/c349e927/attachment.bin

From: oe@hentges.net (Matthias Hentges)
Date: Sun, 10 Sep 2006 19:15:51 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems	w/
Message-Id: <1157915751.8827.34.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Am Sonntag, den 10.09.2006, 19:48 +0200 schrieb Jean Delvare:
> Hallo Matthias,

> > I'm indeed getting an error from isaset: 
> > "Data mismatch, wrote 0xf5, read 0xf4 back."
> > 
> > I just tried again to be sure.
> 
> Odd, this register is supposed to be writable. Can you please try other
> values (e.g. 0xa4) to see if other bits in the register can be written?

Interesting, I can set the value 0xa4 (and then back to 0xf4) just fine.
BTW: I did this while the driver was loaded.

> You may also try writing to register 0x48, we don't care about the
> value there and it'll be an interesting test.

+root at mhcln01:/tmp >isaset -y 0x295 0x296 0x48 0xa5 
Data mismatch, wrote 0xa5, read 0x25 back.
+root at mhcln01:/tmp >isaset -y 0x295 0x296 0x48 0xa6
Data mismatch, wrote 0xa6, read 0x26 back.
+root at mhcln01:/tmp >isaset -y 0x295 0x296 0x48 0xb6
Data mismatch, wrote 0xb6, read 0x36 back.
+root at mhcln01:/tmp >isaset -y 0x295 0x296 0x48 0xc6
Data mismatch, wrote 0xc6, read 0x46 back.
+root at mhcln01:/tmp >

Dunno if that was to be expected heh.

> Pin 58 is shared between two functions, SI and AUXFANIN1. Your problem
> might have something to do with this, but I can't find information
> about function selection for this pin in the datasheet.
> 
> David, any idea?
> 
-- 
Matthias 'CoreDump' Hentges 

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060910/d6e9aca6/attachment.bin 

From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 04 Jun 2005 22:18:53 +0000
Subject: [lm-sensors] Re: Speeding up i2c-algo-bit.c?
Message-Id: <20050604201829.GB13229@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050524172703.GC17974@neu.nirvana>
In-Reply-To: <20050524172703.GC17974@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Jun 04, 2005 at 06:02:54PM +0200, Jean Delvare wrote:
> > currently the bit shift algorithm in i2c-algo-bit.c is using at least
> > 27 udelays per byte (3 per bit and another 3 per byte).
> > 
> > Can this be optimized for a block transfer? Does one need to check for
> > a timeout on each bit or is there a persistent error flag that can be
> > checked after a larger transaction?
> 
> I don't see any "check for timeout" thing in i2c-algo-bit.

There are checks like 

if (sclhi(adap)<0) { /* timed out */

but on second reading this is needed anyway.

> The delays are simply meant to control the frequency of the
> transmission. What you may be confused by is simply the fact that
> the implemented algorithm leads to a 33/67 duty cycle rather than a
> 50/50 one as you would expect.  There is nothing wrong with that,
> nothing in the I2C specification prevents you from doing so.
> 
> > The background is an i2c interface on a TV capture card which is used
> > for a firmware upload (a Hauppauge WinTV 150). The firmware is 14kB
> > and takes ~4-5 seconds of upload time on 100kHz.
> 
> 14kB at 100kHz should take no more than 1.5 second. More likely your bus
> is running at 33kHz rather than 100kHz. This is what you get when
> specifying .udelay = 10 for i2c-algo-bit. Each bit takes three delays,
> 1/(3*10us) = 33kHz. If you know all the chips on the bus can handle
> 100kHz (presumably guaranteed at 50/50 duty cycle), then you can try to
> lower .udelay to 5, I'd expect it to work.

That's probably my error in thinking, I thought a 100kHz bus would
imply a minimal udelay of 10us, but if 33/66 is allowed within the
10us, e.g. ~ 3us/6us then I'm already happy! :)

> You may want to look at i2c-algo-biths in the lm_sensors project. This
> was an attempt to get a 50/50 duty cycle bit-banging algorithm,
> supposedly faster than the original one. I'd expect "faster" to mean
> lower CPU load, as the speed itself merely depends on the chosen delays.
> It is no more built by default because it is unmaintained (it has no
> user and was never ported to Linux 2.6), but if you want to revive it
> and can prove it to be useful, it could replace the original
> implementation in the long run.

OK, thanks for the pointer, I will check this!
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050604/ab55c822/attachment-0001.bin

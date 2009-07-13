From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Jul 2009 12:10:41 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add TMP42x chip detection
Message-Id: <20090713141041.54aac765@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090712193403.GA4444@ubuntu>
In-Reply-To: <20090712193403.GA4444@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Jul 2009 13:44:35 +0200, Andre Prendel wrote:
> On Mon, Jul 13, 2009 at 10:53:54AM +0200, Jean Delvare wrote:
> > Hi Andre,
> > 
> > On Sun, 12 Jul 2009 21:34:04 +0200, Andre Prendel wrote:
> > > This patch adds detection for TI's TMP421, TMP422 and TMP423 chips to
> > > sensors-detect. Only the manufactory ID and the device ID is used for
> > > detection. I hope this is reliable enough.
> > > ---
> > > 
> > >  sensors-detect |   34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > > 
> > > Index: sensors/prog/detect/sensors-detect
> > > =================================> > > --- sensors.orig/prog/detect/sensors-detect	2009-07-10 22:15:41.000000000 +0200
> > > +++ sensors/prog/detect/sensors-detect	2009-07-12 19:26:14.000000000 +0200
> > > @@ -908,6 +908,21 @@
> > >  		i2c_addrs => [0x4c..0x4e],
> > >  		i2c_detect => sub { lm90_detect(@_, 10); },
> > >  	}, {
> > > +		name => "Texas Instruments TMP421",
> > > +		driver => "tmp421",
> > > +		i2c_addrs => [0x2a, 0x4c..0x4f],
> > 
> > Maybe you can add a comment about the other addresses supported by the
> > chip but not probed?
> 
> Ok, will do that. What's actually the reason why we dont probe all addresses?
> Why is it unsafe and what can happen probing an unsafe address?

We avoid probing addresses which are not very popular for hardware
monitoring chips. For addresses which are already probed for many
chips, adding one doesn't change much.

The reason is that I2C transactions do not have semantics attached. A
given transaction can do different things depending on the device which
receives it. Even transactions which SMBus says are "read"
transactions, can write to chips. Or they read but have side effects.
So we want to be extra cautious and not probe more than needed.

Bad things can happen when probing I2C devices in a way they did not
expect. The lm-sensors project has an history of (thankfully rare)
reports of sensors-detect confusing or even breaking pieces of hardware.
Sometimes the reason is design flaws in chips [1], sometimes it's just
that the chip did not like the probe [2].

[1] http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-2.10/README.thinkpad
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023020.html

Over time we have improved both sensors-detect [3] and some kernel
drivers [4] to prevent all known issues. But more issues are bound to
arise in the future again as long as we do SMBus probing. This is the
main reason why I recently changed the order of probes in
sensors-detect [5] and sensors-detect now skips SMBus probing if
Super-I/O sensors were found [6] (with some exceptions.) This is better
than the previous situation, but still not bullet-proof.

[3] http://www.lm-sensors.org/changeset/5245
[4] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h851d6eb4eeb0894f4d095dfdf8ab61c435ad57
[5] http://www.lm-sensors.org/changeset/5498
[6] http://www.lm-sensors.org/changeset/5511

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

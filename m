From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jul 2011 14:33:10 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add support for
Message-Id: <20110707163310.12f519f0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110707121403.6c0cf59b@endymion.delvare>
In-Reply-To: <20110707121403.6c0cf59b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Jul 2011 07:21:10 -0700, Guenter Roeck wrote:
> On Thu, Jul 07, 2011 at 06:14:03AM -0400, Jean Delvare wrote:
> > On Sun, 26 Jun 2011 13:38:36 -0700, Guenter Roeck wrote:
> > > +	if ($chip = 14) {
> > > +		return if ($conf & 0x2a) != 0;
> > > +		return if $rate > 0x09;
> > > +		return if $mid != 0xa1;		# NXP Semiconductor/Philips
> > > +		return 8 if $cid = 0x00;	# SA56004
> > 
> > A device ID of 0, unfortunately, is very fragile and thus certainly
> > doesn't deserve a confidence value of 8. 6, tops. It would also make
> > sense to check the unused bits in register 0xbf (Alert Mode / $conf2)
> > for this device, to make the detection somewhat more reliable, as we do
> > for many other LM90-compatible chips.
> > 
> Ok, I'll change that. Guess we should make the same change in the driver.

I already have a patch doing that, I'm only waiting for the register
dump to test it. The driver didn't even test the configuration and rate
registers, I added that as well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

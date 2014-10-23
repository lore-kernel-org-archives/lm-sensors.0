From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 23 Oct 2014 08:44:39 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (i5500_temp) Don't bind to disabled sensors
Message-Id: <20141023104439.2ec23771@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141022111321.22ab7122@endymion.delvare>
In-Reply-To: <20141022111321.22ab7122@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 22 Oct 2014 15:53:35 -0700, Guenter Roeck wrote:
> On Wed, Oct 22, 2014 at 07:54:49PM +0200, Romain Dolbeau wrote:
> > 2014-10-22 18:26 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
> > > Is there really no other register you can use to detect if the sensor is enabled ?
> > > How about the TSTIMER register ?
> > 
> > As far as I can tell (but I'm not an expert), all the documented
> > registers display "sane" values, so it's hard to tell apart working
> 
> Too bad. I thought that maybe the TSTIMER would have its poweron
> value of 0, though the datasheet is a bit confusing in that regard.
> It seems to state that the default value is 0 and 200,000 at the
> same time.

Value of this register is 0x07d30d40 on three boards where the driver
doesn't work. This means PRESCALER = 0x30d40 = 200000 and FILTER 0x07d = 125, as indicated in the datasheet. On the two boards where the
driver does work, the FILTER field has the same value, however the
PRESCALER has a different value (257600 on one, 257201 on the other.)

So we could at least improve the heuristic and only fail the driver
binding if TSFSC = 0x7F _and_ TSTIMER = 0x07D30D40. If someone changed
the prescaler or filter values, there are good chances that the driver
should work.

> Maybe it is as simple as VCCTS or TSIREF not connected on the
> 'failing' board.

I indeed suspect that this could be a wiring issue. Out of curiosity,
how did you find the relevant pin names?

> Did you check for 'thermal error enable' in the GERRCTL register ?

Interesting suggestion. But the bit is set on the only working board I
have access to (Thermal error reporting disabled) while it is cleared
on the non-working boards (Thermal error reporting enabled.) So I don't
think we can rely on it.

Another interesting register in device 00:14.2 is THRERRCTL. It's set
to 0x5 on the one working board I have access to, and to 0x0 on
non-working ones.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

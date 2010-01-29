From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jan 2010 13:46:03 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <20100129144603.74d30599@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2 Sep 2009 21:29:16 +0200, Jean Delvare wrote:
> On Wed, 2 Sep 2009 02:23:52 +0200, Hubert Kario wrote:
> > On Tuesday 01 September 2009 23:27:28 Tech2009 wrote:
> > > Thank you for the suggestions.
> > >
> > > I looked in sysfs on the factory distro, no sign of dme1737 there (see
> > > attached). However there are other i2c devices not on my debian
> > > install...you could be right about the direct port io, but without
> > > disassembling the library it's hard to tell.
> > >
> > > I tried loading dme1737 with force_start, but that made no difference
> > > for me.
> > I was thinking about using the 'force' parameter to givie the address 
> > explicitly to the module, the device may be on non standard port.
> > sensors-detect is usually more capable of detecting devices than kernel 
> > modules
> 
> Good point. The dme1737 driver only recognizes version/stepping value
> of 0x69 as the SCH5027. sensors-detect OTOH recognizes all version/
> steppings from 0x69 to 0x6f. It would be interesting to see a dump of
> the chip (modprobe i2c-dev then run i2cdump), I'd guess you have a
> version/stepping value > 0x69.

Ping. Can we have the output of i2cdump for your chip, please?

> It might help to have a physical look at the chip and read the top
> marking, if this is possible.

This would also be helpful, if possible.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jan 2012 14:57:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for G781 and G781-1
Message-Id: <20120123155754.20c33253@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327275811-29546-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327275811-29546-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jan 2012 06:22:00 -0800, Guenter Roeck wrote:
> On Mon, Jan 23, 2012 at 04:26:09AM -0500, Jean Delvare wrote:
> > On Sun, 22 Jan 2012 15:43:31 -0800, Guenter Roeck wrote:
> > > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > > (...)
> > > @@ -229,6 +230,12 @@ static const struct lm90_params lm90_params[] = {
> > >  		.alert_alarms = 0x7c,
> > >  		.max_convrate = 10,
> > >  	},
> > > +	[g781] = {
> > > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
> > > +		  | LM90_HAVE_BROKEN_ALERT,
> > 
> > How do you know it has broken alert? Playing it safe, or does anything
> > in the datasheet suggest so? So far, only Analog Devices chips are
> > known to need this. I'd rather have Mike test first, and only put this
> > flag if really needed (it has a cost.)
> > 
> Datasheet says "Note that the ALERT interrupt latch is not automatically
> cleared when the status flag bit is cleared." Maybe I misunderstood that ?
> No problem, though, I'll take it out.

Keep it in then :) I was suspecting a careless copy-n-paste, but
apparently I was wrong, sorry about that. I had not read the datasheet
carefully, while obviously you did exactly that.

> > > (...)
> > > +		    && ((address = 0x4C && chip_id = 0x01)      /* G781   */
> > > +			|| (address = 0x4D && chip_id = 0x03))) /* G781-1 */
> > 
> > As for the sensors-detect patch, 0x01 is the right value for both
> > variants of the chip.
> > 
> Datasheet says:
> 
> The G781 and G781-1 have the following SMBus
> slave address:
> 	A6 A5 A4 A3 A2 A1 A0
> G781	1  0  0  1  1  0  0
> G781-1	1  0  0  1  1  0  1
> 
> and:
> 
> MFGIO	FEh		0100 0111	Manufacturer ID
> DEVID	FFh	G781	0000 0001	Device ID
> 		G781-1	0000 0011
> 
> Obviously G781 can be on both addresses, but what to do with devid 0x03 ?

I read it the other way around. Obviously G781-1 has address 0x4D and
the same device ID as the G781. I.e. the datasheet is wrong. That would
be consistent with what the other manufacturers did (e.g. LM89 and
LM89-1 have the same device ID.)

I'd stick to what Mike has, at least we know this exists. If we get
reports of unsupported devices, we can add the new IDs later.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

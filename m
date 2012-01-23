From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jan 2012 08:36:49 +0000
Subject: Re: [lm-sensors] Support for SMBus based GMT G781 and G7811 temperature sensors.
Message-Id: <20120123093649.6061e036@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
In-Reply-To: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Jan 2012 13:11:36 -0800, Guenter Roeck wrote:
> On Sun, Jan 22, 2012 at 01:43:08PM -0500, Mike Gorchak wrote:
> > Hi All,
> >  
> > I've recently found that lm-sensors doesn't have support for Global Mixed-mode
> > Technology Inc. (GMT) G781 and G7811 temperature sensors.
> >  
> > Overview datasheets are available on manufacturer's site: http://www.gmt.com.tw
> > / , registers datasheet is available here: www.datasheetcatalog.org/datasheets2
> > /35/350422_1.pdf
> >  
> > It seems that this device is registers compatible with ADM1032. SMBus
> > manufacturer id 0x47, device ids 0x01 and 0x03.
>
> Should be safe to add support to the lm90 driver. Jean, any thoughts/comments ?

Indeed the G781 seems compatible with the other chips supported by the
lm90 driver, adding support to that driver sounds good. I'll gladly
review any patch.

> I seem to be unable to find a datasheet for G7811, though. We would need that to know
> its I2C bus address, and for the correct device id (0x03 ?).

GMT have a product sheet for the G7811 so it probably exists:
http://www.gmt.com.tw/product/datasheet/EDS-7811.pdf

Not enough to check for compatibility or write a proper driver though.
But its lack of remote sensor means it can't be fully compatible with
the ADM1032 anyway. Until we receive a formal support request and get a
datasheet (or at the very least a register dump) I think we can just
ignore the G7811.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

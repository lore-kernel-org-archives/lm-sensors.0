From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 22 Jan 2012 21:11:36 +0000
Subject: Re: [lm-sensors] Support for SMBus based GMT G781 and G7811 temperature sensors.
Message-Id: <20120122211136.GB12747@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
In-Reply-To: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 22, 2012 at 01:43:08PM -0500, Mike Gorchak wrote:
> Hi All,
>  
> I've recently found that lm-sensors doesn't have support for Global Mixed-mode
> Technology Inc. (GMT) G781 and G7811 temperature sensors.
>  
> Overview datasheets are available on manufacturer's site: http://www.gmt.com.tw
> / , registers datasheet is available here: www.datasheetcatalog.org/datasheets2
> /35/350422_1.pdf
>  
> It seems that this device is registers compatible with ADM1032. SMBus
> manufacturer id 0x47, device ids 0x01 and 0x03.
>  
Should be safe to add support to the lm90 driver. Jean, any thoughts/comments ?

I seem to be unable to find a datasheet for G7811, though. We would need that to know
its I2C bus address, and for the correct device id (0x03 ?).

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

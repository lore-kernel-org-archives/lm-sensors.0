From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 31 Oct 2011 13:11:23 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon: add support for MCP3204/3208
Message-Id: <20111031141123.7e81a198@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201110311247.p9VClrVx017871@home.pavel.comp>
In-Reply-To: <201110311247.p9VClrVx017871@home.pavel.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Mon, 31 Oct 2011 17:04:33 +0400, Paul Fertser wrote:
> On Mon, Oct 31, 2011 at 01:54:33PM +0100, Jean Delvare wrote:
> > > but at least the max1111 uses the former. Waiting for your feedback.
> > 
> > Thanks for pointing this out. I don't know how it managed to sneak in,
> > but it shouldn't have. I'll ask the driver author to align with the
> > standard interface quickly, otherwise we'll have to delete the driver
> > altogether.
> 
> What do you propose to use for raw ADC data then? How should i
> proceed?

Raw ADC data isn't supposed to be exported by hardware monitoring
drivers in the first place. If you need to do this, then hwmon is the
wrong place. Look at iio instead, maybe it allows this (not even sure).
hwmon drivers expose voltage values to user-space in mV, always. If the
LSB weight depends on the platform somehow, you may be able to pass it
as platform data to the I2C slave device, so that the driver can scale
properly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

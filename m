From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Feb 2011 16:53:08 +0000
Subject: Re: [lm-sensors] New sysfs attribute for fan control: fan pulses
Message-Id: <1298479988.24938.444.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110223035414.GA18074@ericsson.com>
In-Reply-To: <20110223035414.GA18074@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-02-23 at 11:29 -0500, Phillip Susi wrote:
> On 2/22/2011 10:54 PM, Guenter Roeck wrote:
> > Hi all,
> > 
> > while working on NCT6776F support, I realized that there is a fan control
> > attribute which is not currently supported by the syfs ABI: The number of
> > fan pulses per revolution. On the NCT6776F, this can be configured in Bank 6,
> > registers 0x44 to 0x46. Possible values are 0..3 for 4, 1, 2, or 3 pulses 
> > per revolution.
> > 
> > I encountered the same parameter when working on PMBus devices. At the time,
> > I thought this was a variant of a fan divisor (ie a divisor of 1, 2, 3, or 4),
> > but apparently it is different and independent of the fan divisor.
> 
> How is it any different than the fan divisor?

The divisor affects count granularity, since the fan speed reported by
the chip has to be multiplied with the divisor value to compute the
actual fan speed.
	speed = <reported value> * <divisor>
My understanding is that it is mainly used to increase the supported
speed range if there is a limited number of bits in the speed count
register.

Pulses per revolution tells the chip how many pulses per fan revolution
to expect for an accurate fan speed reading. The reported fan speed is
corrected by the chip based on this parameter, and the driver does not
have to do any fan speed calculations.
	speed = <reported value>

One could of course play around by always configuring the chip to a
fixed value for pulses/revolution and then use SW to calculate the real
speed. But it seems to me that would only add code and thus risk, and
not provide any real benefits (other maybe to be able to claim that
pulses/revolution is some kind of disguised fan divisor).

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

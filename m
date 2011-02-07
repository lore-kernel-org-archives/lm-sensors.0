From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 14:57:00 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207145700.GA1770@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 07, 2011 at 09:47:22AM -0500, Guenter Roeck wrote:
[ ... ] 
> > 
> > The second line happens on the first call to 'sensors'.  Rebooting
> > triggers it again, but rmmod/insmod does not.
> > 
> That is as expected. The driver loads the sensor value, detects that it is out of range,
> and automatically adjusts the divisor register.
> 
> Usually, in other drivers, it is possible to write into the divisor register.
> This can then be used to initialize the divisor to a reasonable value at startup.
> For some reason that is not implemented for this driver; I don't know why.
> 
> > Should the driver just fix up the divisors on load instead of on first read?
> > 
> No, the divisor should be writable so you can initialize it at startup. 
> I'll see if I can fix that.
> 
Ok, I know the reason. The divider is set automatically when the minimum speed is configured.
This is because both the current speed and the minimum speed are affected by the divider
settings, and the divider value has to work for both.

So what you'll have to do is to set a minimum speed, and the problem will go away.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

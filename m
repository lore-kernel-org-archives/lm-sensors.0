From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 06 Oct 2010 18:24:03 +0000
Subject: Re: [lm-sensors] local macro
Message-Id: <4CACBEC3.60108@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
In-Reply-To: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/06/10 19:13, Paul Thomas wrote:
> I'm planning a rev of the ads7871 driver. I want to add in the ability
> to set the gain on the chip as well as do differential reads. To do
> this I'm adding a bunch of SENSOR_DEVICE_ATTR lines. Awhile ago I had
> got a suggestion from Jonathan to use a local macro for these
> statements. Would that be a macro that looped through calling the
> other macro 8 times with values 0-7? Could someone point me to an
> example where this is used?
I suspect I meant something like

#define ADS7871_VOLTAGE_ATTR(n) SENSOR_DEVICE_ATTR(in##n##_input, S_IRUGO, show_voltage, NULL, n);
But looking back at the usage, it really is a matter of taste, and I'm
not sure my suggestion was a good one in this case!

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

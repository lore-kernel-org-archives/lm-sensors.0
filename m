From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Jul 2013 22:27:32 +0000
Subject: Re: [lm-sensors] Bug Report: Bus substitution causing a problem
Message-Id: <20130708222732.GA10676@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <51DAC98E.3090203@aeryon.com>
 <51DB2CB6.4060303@aeryon.com>
 <20130709000013.1ca77b1d@endymion.delvare>
In-Reply-To: <20130709000013.1ca77b1d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Chris Pattenden <chris-XAaQGU7qChDQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Jul 09, 2013 at 12:00:13AM +0200, Jean Delvare wrote:
> Hi Chris,
> 
> On Mon, 08 Jul 2013 17:18:46 -0400, Chris Pattenden wrote:
> > I'm working to configure lm_sensors and have notice a few strange issues.
> > 
> > I'm working on a TI 8148 on custom hardware.
> > Linux 2.6.37
> > lm_sensors lm_sensors-3.3.4
> > 
> > i2cdetect -l shows the following:
> > 
> > 	i2c-2   i2c             OMAP I2C adapter                        I2C adapter
> > 	i2c-4   i2c             OMAP I2C adapter                        I2C adapter
> > 
> > 
> > 
> > I have two TI ADC128D818 ADCs (I cobbled together my own driver while 
> > waiting for support -- I see that someone else requested the same driver 
> > last week :-). They are:
> > 	adc128d818-i2c-4-1d
> > 	adc128d818-i2c-4-37
> > 
> > 	
> > "sensors --bus-list" shows the following:
> > 	bus "i2c-4" "OMAP I2C adapter"
> > Why bus i2c-2 isn't shown, I don't know. That's likely an issue.
> 
> No it's not. sensors --bus-list only lists the relevant buses - the
> ones with at least one hwmon chip. There's no chip on i2c-2, so it's
> not listed.
> 
> > I started using the following sensors.conf:
> > 	chip "adc128d818-i2c-4-1d"
> > 	label in0 "Test"
> > 
> > However, I was told that the "bus was unidentified".
> > I used the following sensors.conf, hoping to fix the problem:
> > 	bus "i2c-4" "OMAP I2C adapter"
> > 	chip "adc128d818-i2c-4-1d"
> > 	label in0 "Test"
> > However, none in0 was not renamed as expected -- it printed as "in0".
> > 
> > It turns out that sensors_substitute_busses() incorrectly renumbers 
> > adc128d818-i2c-4-1d to adc128d818-i2c-2-1d and then can't find the 
> > labels.
> 
> The problem here is that your i2c bus driver is evil and attributes the
> same name to two different buses. It should not do that. This is a bug
> in the i2c-omap driver. It should give each bus a distinct name, for
> example by including the base I/O address in it.
> 
Unfortunately it is not the only such driver.

Same output on P2020:

i2c-0   i2c             MPC adapter                             I2C adapter
i2c-1   i2c             MPC adapter                             I2C adapter

And on P5040:

i2c-0   i2c             MPC adapter                             I2C adapter
i2c-1   i2c             MPC adapter                             I2C adapter
i2c-2   i2c             MPC adapter                             I2C adapter
i2c-3   i2c             MPC adapter                             I2C adapter

Question is ... would a patch to fix that be accepted by the i2c maintainers ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

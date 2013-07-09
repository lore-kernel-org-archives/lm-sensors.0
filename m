From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Jul 2013 05:51:30 +0000
Subject: Re: [lm-sensors] Bug Report: Bus substitution causing a problem
Message-Id: <20130709075130.775cd0fe@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <51DAC98E.3090203@aeryon.com>
	<51DB2CB6.4060303@aeryon.com>
	<20130709000013.1ca77b1d@endymion.delvare>
	<20130708222732.GA10676@roeck-us.net>
In-Reply-To: <20130708222732.GA10676-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Chris Pattenden <chris-XAaQGU7qChDQT0dZR+AlfA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 8 Jul 2013 15:27:32 -0700, Guenter Roeck wrote:
> On Tue, Jul 09, 2013 at 12:00:13AM +0200, Jean Delvare wrote:
> > The problem here is that your i2c bus driver is evil and attributes the
> > same name to two different buses. It should not do that. This is a bug
> > in the i2c-omap driver. It should give each bus a distinct name, for
> > example by including the base I/O address in it.
>
> Unfortunately it is not the only such driver.
> 
> Same output on P2020:
> 
> i2c-0   i2c             MPC adapter                             I2C adapter
> i2c-1   i2c             MPC adapter                             I2C adapter
> 
> And on P5040:
> 
> i2c-0   i2c             MPC adapter                             I2C adapter
> i2c-1   i2c             MPC adapter                             I2C adapter
> i2c-2   i2c             MPC adapter                             I2C adapter
> i2c-3   i2c             MPC adapter                             I2C adapter
> 
> Question is ... would a patch to fix that be accepted by the i2c maintainers ?

I think it would, yes, as long as you explain why it is needed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

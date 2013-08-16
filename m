From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Aug 2013 18:57:46 +0000
Subject: Re: [lm-sensors] it87.fix_pwm_polarity
Message-Id: <20130816185746.GA6334@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <kuasuu$1j8$1@ger.gmane.org>
In-Reply-To: <kuasuu$1j8$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 16, 2013 at 11:34:49AM -0500, Ian Pilcher wrote:
> On 08/12/2013 09:54 AM, Ian Pilcher wrote:
> > I am setting up a Thecus N5550 NAS, and I found that the it87 driver
> > disables PWM control of the drive bay fan (it87.656/pwm3) unless I pass
> > the fix_pwm_polarity parameter.  Once I add that parameter, fan control
> > appears to work just fine.
> > 
> > Does this setting actually invert the voltage that is supplied to the
> > fan?  If so, does this have the potential to damage the fan itself (or
> > other components)?
> 
> Anyone?
> 
It just changes the pwm polarity from active low to active high unless
fan control is set to automatic mode. That doesn't damage anything.

Does automatic fan control for the drive bay fan work if you don't load
the driver ? Also, what kernel log message do you get when you load the
driver with or without the parameter ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Aug 2013 19:57:49 +0000
Subject: Re: [lm-sensors] it87.fix_pwm_polarity
Message-Id: <20130816195749.GA4568@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <kuasuu$1j8$1@ger.gmane.org>
In-Reply-To: <kuasuu$1j8$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 16, 2013 at 02:28:14PM -0500, Ian Pilcher wrote:
> On 08/16/2013 01:57 PM, Guenter Roeck wrote:
> > It just changes the pwm polarity from active low to active high unless
> > fan control is set to automatic mode. That doesn't damage anything.
> 
> Good to know.
> 
> > Does automatic fan control for the drive bay fan work if you don't load
> > the driver ? Also, what kernel log message do you get when you load the
> > driver with or without the parameter ?
> 
> I don't believe so.  Without the module loaded the fan seems to always
> run at about 75% of its maximum speed.
> 
> It is hard to be 100% sure, because the temperatures reported by the
> IT8728F don't seem to ever vary by more than a few degrees, even when
> coretemp reports significant changes (around 20 degrees).  So it's
> possible that automatic fan control is "working," but getting garbage
> input.
> 
> If I load the module after a cold-boot without the parameter, I get:
> 
>   it87 it87.656: Detected broken BIOS defaults, disabling PWM interface
> 
> Once I've loaded it with the fix_pwm_polarity=1 one time, I can unload/
> reload the module without any special parameters, and PWM continues to
> work.  IIRC, this is true across warm reboots.
> 
In that case the driver does exactly what it is supposed to do.
It detects that the pwm configuration is broken and disables it.
With the parameter, it tries to correctly configure and enable it instead. 

Guenter

> Note that bad/incomplete setup by the BIOS appears to be somewhat common
> on this hardware.  This is a Thecus N5550 NAS, and the manufacturer
> expects people to run their Linux-based "firmware."  Their add-on kernel
> modules do some setup work (configuring ICH GPIOs) which would normally
> be done by the BIOS.
> 
> HTH
> 
> -- 
> ====================================
> Ian Pilcher                                         arequipeno@gmail.com
> Sometimes there's nothing left to do but crash and burn...or die trying.
> ====================================
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

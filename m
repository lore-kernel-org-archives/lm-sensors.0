From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:19:34 +0000
Subject: Re: [lm-sensors] fan control questions
Message-Id: <20090130181934.7875dd0c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <glni7k$fut$1@ger.gmane.org>
In-Reply-To: <glni7k$fut$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Tue, 27 Jan 2009 10:02:28 -0800, Mark Nienberg wrote:
> I was hoping to use the fan control program on a server with an ASUS KFN4-DRE 
> motherboard.  The BIOS has three settings for control of fans (disabled, smart fan, 
> smart fan II). The two smart fan options work very poorly, cycling through full speed 
> and low speed on about a 24 hour cycle with no apparent regard to temps.  That is why 
> I would like to take control and force something more rational.

It might be better to tweak the settings of the automatic modes than to
switch to software control. Sometimes the BIOS allows this. If not,
some of our drivers have sysfs files to tweak the settings.

> I assumed that if I am controlling fans from the OS then I don't want the BIOS to 
> also try to control fans, so I set it to "disabled" and then ran the pwmconfig 
> program. The program found three pwm devices and tried each one in turn, but there 
> was no effect on the two fans connected to the motherboard.  There are a total of 10 
> fan connectors on this board, six of which show up in lm_sensors.  The manual says 
> that the "smart fan" setting applies to all fan connectors.
> 
> Should I have tested with the BIOS settings other than "disabled"?

This shouldn't change anything. If pwmconfig finds a PWM output in
automatic mode, it'll warn you that you probably don't want to change
it to manual mode, but that's about it (you can override that if you
really want to.)

> Should I test the other 4 fan connectors that lm_sensors recognizes?

Yes, it can't hurt.

It would help if you would provide more information about your board.
In particular, which hardware monitoring chip(s) are found by
sensors-detect? What does the output of "sensors" look like?

If there is more than one chip, are the PWM outputs found on the same
chip that reports the fan speeds?

And do you see fan speeds change when in automatic control mode?

> Or is this just one of the boards that fan control won't be able to handle?

If the BIOS has options to control the fans then the wiring on the board
must be correct. You're probably not too far away.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jun 2007 20:38:35 +0000
Subject: Re: [lm-sensors] f71805f + J7F2;
Message-Id: <20070610223835.05d29ea1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609174408.170bfb85@hyperion.delvare>
In-Reply-To: <20070609174408.170bfb85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Sat, 09 Jun 2007 18:40:06 +0100, Phil Endecott wrote:
> Jean Delvare wrote:
> > On Fri, 08 Jun 2007 22:00:59 +0100, Phil Endecott wrote:
> >> I am currently using 40 kHz.  This is still well above audio range, but 
> >> the waveforms actually look like square waves giving better control.  
> >> Would this be a better default?  It would depend to some extent on the 
> >> particular fan.
> >
> > The default is from the chip, not from the driver. Usually we don't put
> > arbitrary initializations in the hardware monitoring drivers, unless
> > a given hardware default is particularly bad. This case might qualify.
> > Do you think we should initialize the PWM frequency to 40 kHz at driver
> > load time (if and only if the hardware default value is found)?
> >
> > Me, I am using 1500 Hz, but I agree that it wouldn't be a good default
> > as I suppose it could create an audible noise (2000 Hz and 400 Hz do
> > for me, for example.)
> 
> My fan makes an audible tone at any frequency within the normal hearing range.

Could be that mine does too, but it's mixed in the room's noise and I
don't hear it.

> It's clear that the right frequency to choose will depend on the 
> particular hardware, but I don't think we'll find anything where 187 
> kHz is a good choice.  It could perhaps be considered bizarre to choose 
> a default based on what I found worked with my unique home-made 
> hardware :-)  Jean, you must have written a script to get the numbers 
> in that graph; if you post it, perhaps other people can try it out and 
> we can see if there is a consensus?

I published my script here:
http://khali.linux-fr.org/devel/lm-sensors/draw_pwm_response.pl
It writes the results to a CSV file, it's up to you to make a graph out
of it (I think I used OOo calc).

>                                     (The 'other people' don't need to 
> be F71805 users since it's mainly measuring the characteristics of the 
> fan itself.)

This would be true if all the chips had perfectly square duty cycles at
all frequencies, but you found out yourself that this isn't the case
for the F71805F at high frequencies. Anyway, I suspect that fans are too
different and we won't find a frequency which pleases everyone.

I agree that the hardware default is poor and I would take a patch to
the f71805f driver setting the frequency to 40 kHz when the default
187.5 kHz is found.

> >> The next problem was that the fan's tacho output is thoroughly garbled 
> >> whenever PWM is used: during the off portion of the PWM waveform, the 
> >> tacho output first goes low and then floats high.  Google found one 
> >> suggestion to fix this by briefly turn the PWM to 100% before taking a 
> >> reading, but this doesn't help when you want to use the chip's 
> >> automatic mode.  I am curious to know if there are any motherboards out 
> >> there with additional components to fix this problem.
> 
> Jean, I assume that you got the numbers for your graph without any 
> hardware mods to make the tacho work.  So presumably there is something 
> on your motherboard to 'fix' this problem?

I confirm that I didn't modify my board in any way, maybe it includes
some additional circuitry. The problem isn't totally fixed though, as
you can see on the graph, below 1000 RPMs I lose the fan speed readings
(there were a couple bogus values which removed from the graph to make
it clearer.) Is it even worst on your side?

> > I admit the documentation isn't very clear on this particular point. I
> > would welcome a patch improving it.
> 
> Here's something...
> 
> --- linux-2.6.21/Documentation/hwmon/f71805f.orig	2007-06-09 
> 18:27:21.000000000 +0100
> +++ linux-2.6.21/Documentation/hwmon/f71805f	2007-06-09 
> 18:32:28.000000000 +0100
> @@ -136,16 +136,20 @@
>   corresponds to a pwm value of 106 for the driver. The driver doesn't
>   enforce this limit though.
> 
> -Three different fan control modes are supported:
> +Three different fan control modes are supported; the mode number is written
> +to the pwm<n>_enable file:
> 
> -* Manual mode
> -  You ask for a specific PWM duty cycle or DC voltage.
> +* 1: Manual mode
> +  You ask for a specific PWM duty cycle or DC voltage by writing to the
> +  pwm<n> file.
> 
> -* Fan speed mode
> -  You ask for a specific fan speed. This mode assumes that pwm1
> -  corresponds to fan1, pwm2 to fan2 and pwm3 to fan3.
> -
> -* Temperature mode
> +* 2: Temperature mode
>     You define 3 temperature/fan speed trip points, and the fan speed is
>     adjusted depending on the measured temperature, using interpolation.
>     This mode is not yet supported by the driver.
> +
> +* 3: Fan speed mode
> +  You ask for a specific fan speed by writing to the fan<n>_target file.
> +  This mode assumes that pwm1  corresponds to fan1, pwm2 to fan2 and pwm3
> +  to fan3.
> +

Patch looks good. If you could just add a leading comment saying what
the patch does, and your Signed-off-by line as described in section 12
of Documentation/SubmittingPatches, this would be perfect.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

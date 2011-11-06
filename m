From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Nov 2011 18:45:58 +0000
Subject: Re: [lm-sensors] Intel 2500K stock fan control
Message-Id: <20111106194558.53493594@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EB6CC0B.8050909@gmx.de>
In-Reply-To: <4EB6CC0B.8050909@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 06 Nov 2011 19:03:55 +0100, Soeren D. Schulze wrote:
> It's me with my NCT6776 again.
> 
> It doesn't seem to be the driver that is causing problems.
> 
> When I force the PWM to full duty cycle at low CPU temperature, I get
> about 2200 RPM.  I get the same thing when I disconnect the PWM pin
> completely (so apparently the driver sets the PWM duty cycle correctly).
> Voltage on the supply pin of the fan is 12 V.
> 
> When put load on the system and CPU temperature rises, though, the fan
> RPM rise up to 2800.  The question is:  What is the reason for this RPM
> rise?  It can't be the PWM signal, as the PWM pin is disconnected.  It
> can't be the voltage, because the voltage stays at 12 V (I measured it).
> 
> The only explanation that comes to my mind is that the fan does not
> actually go to full speed even at full PWM duty cycle until it senses
> high temperature itself.  This implies that the fan has some integrated
> temperature sensor.
> 
> Is this possible?  And if so, why would they do such a thing?

Yes, this is possible, I've seen this before.

Reason is that it allows for totally software and hardware agnostic fan
speed control. CPU safety is guaranteed by the fan itself and there is
no way to screw it (short of removing or under-powering the fan itself.)

Obviously the major drawback is that it takes control away from the
user, so I would stay away from such hardware if I can. But for lambda
users it makes some sense.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

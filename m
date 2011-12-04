From: Charles <c@catcons.co.uk>
Date: Sun, 04 Dec 2011 12:55:50 +0000
Subject: Re: [lm-sensors] pwmconfig/fancontrol error (version 3.3.1)
Message-Id: <4EDB6D03.1070908@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EDA21A1.6060301@catcons.co.uk>
In-Reply-To: <4EDA21A1.6060301@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/12/11 16:30, lm-sensors-request@lm-sensors.org wrote:
> Hi Charles,
> 
> Please keep the list CC'd.

Oops!  Sorry.

>> > Tested; no error messages and GKrellM shows sane processor core
>> > temperatures and fan speeds.
>> > 
>> > Sorry for the incomplete initial report:
>> > * I had applied the suggested workaround (thanks Jean and Guenter).
> Hmm. Please test the updated version of the script _without_ the
> workaround applied. That's the whole point of the update.

That's how I did test the update.  Should have made clear.

> Most likely because the CPU fan header is a 4-pin header, and the Intel
> CPU fan has 4 wires, while the case fan headers are 3-pin with a 3-wire
> fan.
> 
> On 4-pin headers, the PWM signal is separated from the power. So you
> can't control a 3-wire fan plugged in a 4-pin header (the PWM signal is
> on the unconnected pin [1].) This also explains the minimum speed of
> 4-wire PWM-controlled fans. This is per design. If the minimum speed
> doesn't please you, you have to either buy a different fan with a lower
> minimum, or lower the fan voltage using a serial resistor (Noctua
> amongst several other fan vendors includes such resistors in many of
> their product packages.)
> 
> [1] Some boards have jumpers that will let you turn a 4-pin fan header
> into a 3-pin one. You loose the benefits of 4-wire fans (such as linear
> fan speed control and reliable readings at low speed) but are no longer
> affected by the arbitrary fan minimum then.
> 

> Indeed, it is only recommended to connect similar fans to the same
> control output. There's a reason why board makers often connect the
> case fans together, but usually have a separate fan control for the
> CPU(s).

Thanks for explanations, Jean :)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

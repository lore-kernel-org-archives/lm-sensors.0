From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 13 Jan 2007 20:10:26 +0000
Subject: [lm-sensors] ADT7463
Message-Id: <4dfa50520701131210p11544219scb8e926c91284ba2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612172022.kBHKMM3N011597@srv1.nickelnetworks.com>
In-Reply-To: <200612172022.kBHKMM3N011597@srv1.nickelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

As usual, I'm squeezing too many things into too little time, but I'll
throw out some ideas. Apologies for not suggesting more in terms of
measuring the PWM peak voltage / PWM frequency / duty cycle without an
oscilloscope -- obviously you could do all that easily using the right
tools. The PWM frequency is the most non-obvious contributor to fan
control problems. (Since the duty cycle is directly controllable, and
voltage problems are usualy catastrophic, needing a board
replacement.)


> David, I got another board from Tyan and the same crappy problem. One thing
> I found today by playing with fan1. The connector has 3 cables. Looking it
> from one side are blue, red and black. If you disconnect the fan obviously
> sensors detects it and flags an alarm. I then separated the red cable from
> the fan molded connector and used a regular hard drive power connector (4
> cables, yellow, black, black, red) and connected them both. I think that is
> +5V. That way it goes from the power supply directly to the fan bypassing
> the motherboard. The other 2 cables, blue and black are still connected to
> the fan molded connector and to the motherboard.

I wonder if the fans you are using have a higher current rating (or,
equivalent, higher wattage) than the ADT7463 or Tyan board are
designed for. You'd need to consult the motherboard manual and ADT7463
datasheet, but if no information is there, it could still be a
problem.

> This spins the fan around 6K rpms and makes sensors still see the fan.
> However, you cannot control it.  I don't know exactly what this means, but I
> can only guess that either something funky is going on with the adt7463 or
> with some of the pwm circuitry maybe in another IC or resistor.

The ADT7463 datasheet should show a pinout. With an oscilloscope, you
could compare the voltage on the pin of the ADT7463 and the voltage at
the fan. That would indicate if any other circuitry is involved.

If the voltages (and waveforms) are pretty much the same, I still
wonder if the ADT7463 can put out the amperage / wattage to drive your
fans.

If it's not a problem driving the fans, you might need to change the
PWM frequency. This might be as simple as writing to the correct file
in sysfs. Or you might need to write support for it in the driver. I
don't know if the ADT7463 can even change its PWM frequency, but it's
a normal feature of PWM controllers, so I expect it can.

I was thinking of a diode-capacitor setup that would allow you to
measure peak voltage with a voltmeter, in the absense of an
oscilloscope. You could measure the PWM frequency using your
soundcard, if you have a good audio recording program (e.g. audacity
will work) once you are certain that the voltage range is reasonable.
You'll want to cut the voltage down with a voltage divider (a few
resistors) first, then route the signal to an input on your soundcard
(there may be a CD audio input you could attach to). None of the
components are very expensive (total price would be about US$0.25),
and it sounds like you're willing to work with these boards to find
out a solution. An oscilloscope would really be the best way.

I haven't looked at the ADT7463 datasheet, so these are random guesses
that might help you with the troubleshooting. Further, you'll want to
be really careful putting probes on your motherboard. You could damage
it (shorting out the ADT7463 would probably break important
motherboard functionality) ... proceed at your own risk, etc., etc.

I'll keep up on this thread and reply when I can,
David


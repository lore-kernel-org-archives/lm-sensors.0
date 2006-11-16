From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 16 Nov 2006 20:54:11 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG - here
Message-Id: <4dfa50520611161254u76bfd6b0v450c734dff4aa23a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

Very interesting result. It sounds like you did it right. I'm
curious--would an OPamp with enough driving power give you the same
result?

The w83627ehf and w83627dhg allow the fan output to be PWM or voltage
controlled. This is the fan*_mode file in sysfs. If you can hear the
PWM switching, you would know if you successfully set it in DC mode.
When I did diagnostic testing on the w83627ehf, I concluded that DC
mode runs the fan at lower RPMs for the same setting. I assume this is
because of the inductance in the fan, so PWM values in the top half of
the range all produce relatively high RPMs.

Anyway, thanks for the info.

David

On 11/16/06, Christian Mahr <christian.mahr.ulm at arcor.de> wrote:
>
>
> Hi David,
>
>
>
>
>
> in the mean time I tried the conversion form 4 to 3 pin fans but I am not
> content with the result.
>
>
>
> Circuitry verbally - brief
>  a voltage divider 4k7:1k8 connected to the pwm signal/pin4 drives a BC107
> npn transistor versus GND. draws a little less than 1 mA from the driving
> chip.
>  The collector of this drives a BD140 E versus +12V via a voltage divider
> 390 Ohm: 120 Ohm. The collector directly connected to the +12V of the fan.
>
>
> With this (maybe old-fashioned) contruction I had a lot of "pwm-noise" in
> the fan, but works somehow.
>
> The I tried to filter this a bit by inserting 3,3 Ohms and 100 micro-F into
> the fan-power +12V -line.
>
> This does make it better, but when driving low voltages, its still quite
> "pwm-noisy". Of course a RC-elemt is not a good contruction here because it
> is much more non-linar and depends on the fan impedance.
>
>
>
> Conclusion: The 3 pin fans need really good analogue voltage control.
>
>  I probably need to do something better by integrating the pwm signal maybe
> by an OPamp or so.... and driving the fan by BD139 as emitter follower.
>
>
>
> Incidentaly, the fan control on the board for the other fans seem much
> better - bu I dont have any circuirtry from the motherboard.
>
>
>
> Just to keep you informed.
>
>
>
> Christian
>
>
>
>
>
> Am Freitag, 3. November 2006 22:56 schrieben Sie:
>
>
> > Hi Christian,
>
> >
>
> > > - if not: Is there any suitable IC known which does all in one
>
> > > (otherwise I might need at least 4 resistors and 2 transistors...)
>
> >
>
> > Just off the top of my head, almost any transistor, MOSFET, or Op-Amp
>
> > would be able to switch 12V at 25 kHz and source > 100 mA. Do you have
>
> > a favorite online parts distributor?
>
> >
>
> > David
>
>


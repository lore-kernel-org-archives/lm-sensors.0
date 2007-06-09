From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 Jun 2007 15:44:08 +0000
Subject: Re: [lm-sensors] f71805f + J7F2;
Message-Id: <20070609174408.170bfb85@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Fri, 08 Jun 2007 22:00:59 +0100, Phil Endecott wrote:
> I have been trying to get fan speed control working on my Jetway J7F2 
> motherboard, which has a Fintek F71805 chip.  Last weekend I posted a 
> couple of messages about the first part of the process, in which I 
> discovered that the chip's PWM outputs aren't actually connected to the 
> board's fan connectors; I fixed that problem with some careful 
> soldering onto one of the chip's PWM outputs and a small circuit based 
> on the example in the Fintek datasheet.  So I was then able to control 
> the fan speed in manual PWM mode.
> 
> Something that I noticed at this point was that the default PWM speed 
> of 187 kHz didn't give very good waveforms because the turn-off slope 
> is quite slow, e.g. with a 50% duty cycle the waveform actually looked 
> like this on the scope:
> 
> ----.   .----.   .---
>       \ |      \ |
>        \|       \|
>         v        v

Interesting. I had observed that high frequencies (including the
default 187 kHz) did not allow proper fan control, but without a scope
I couldn't watch what the signal looked like. See this graph I had been
drawing:
http://khali.linux-fr.org/devel/lm-sensors/pwm_response_curves.png
160 kHz gives almost no control at all.

> I am currently using 40 kHz.  This is still well above audio range, but 
> the waveforms actually look like square waves giving better control.  
> Would this be a better default?  It would depend to some extent on the 
> particular fan.

The default is from the chip, not from the driver. Usually we don't put
arbitrary initializations in the hardware monitoring drivers, unless
a given hardware default is particularly bad. This case might qualify.
Do you think we should initialize the PWM frequency to 40 kHz at driver
load time (if and only if the hardware default value is found)?

Me, I am using 1500 Hz, but I agree that it wouldn't be a good default
as I suppose it could create an audible noise (2000 Hz and 400 Hz do
for me, for example.)

> The next problem was that the fan's tacho output is thoroughly garbled 
> whenever PWM is used: during the off portion of the PWM waveform, the 
> tacho output first goes low and then floats high.  Google found one 
> suggestion to fix this by briefly turn the PWM to 100% before taking a 
> reading, but this doesn't help when you want to use the chip's 
> automatic mode.  I am curious to know if there are any motherboards out 
> there with additional components to fix this problem.  One solution is 
> the "4 pin fan", but they don't seem to be widely available.  I 
> considered various analogue solutions to extract the tacho signal from 
> the PWM garbling, but settled on a digital one: I have a 4013 D-type 
> flip-flop chip (4000-series logic has the benefit of operating at 12 
> volts) which samples the tacho signal on the falling edge of the PWM 
> waveform.  This works fine in all cases except one, which I didn't 
> consider until I tried it out: duty0%, which has no edges!  Any 
> ideas for how to fix this would be welcome.  In manual mode it's not a 
> problem because I can avoid using 100%; 99% gives essentially the same 
> fan speed.  But in tracking mode I don't think there's a way to tell 
> the chip not to go above a certain duty cycle (is there?).

Assuming that what you call "tracking mode" is what the datasheet calls
"fan speed mode", then no, you cannot ensure that it won't attempt to
drive the fan at 100% duty cycle at some point in time. You can only
_hope_ that it won't, if you ask for a fan speed which is low enough.
Anyway, this mode isn't particularly useful so it probably doesn't
really matter.

In manual (software-driven) mode, you can make sure you'll never ask
for a 100% duty cycle, however the current implementation of our
fancontrol script doesn't support defining a maximum PWM value. Nor does
it support defining a minimum PWM value, which would be even more useful
IMHO (you never want your CPU fan to stop, do you?) These features
could be easily added. Want to give it a try? Or I can.

4-wire fans are indeed not widely available. And more importantly, they
only work properly if your motherboard has 4-wire fan headers and they
are wired properly to a hardware monitoring chip which supports them.
But they are certainly the way to go.

Out of curiosity, which PWM output did you wire to which fan? The
F71805F pretty much expects that PWM1 controls fan1, PWM2 controls
fan2, etc.

Given that you're wiring everything yourself, you could also try the DC
control mode. I don't know what effect it has on speed monitoring
though. Could be even worse than PWM.

From the graph I mentioned above, you can see that I am having trouble
monitoring speeds below 1000 RPM, too. But this was never a problem in
practice, I do not want my CPU fan to spin that slowly anyway. It's a
2500 RPM fan and it usually doesn't go below 2000 RPM with my current
settings.

> I had to read the source to work out how to use speed tracking mode, 
> because the documentation file for the f71805f doesn't give the 
> pwm*_enable values for the modes and lists them in the order manual 
> (1), speed (3) and temperature (2).  I can submit a documentation patch 
> for this if you like.

I admit the documentation isn't very clear on this particular point. I
would welcome a patch improving it.

> So the next challenge is temperature tracking.  I understand that this 
> is not currently implemented by the driver (I'm looking at the 2.6.21 
> source; please let me know and accept my apologies if this driver has 
> been updated since then).  I could perhaps add this functionality, but 
> first I'd like to know if there was some problem that prevented the 
> original author from doing so.

This is still not implemented. The reason was a mix of lack of time and
lack of interest. My CPU fan is pretty silent anyway, so I could live
with it at full speed all the time. However, if you want to implement
this feature, this is welcome, and I'll be happy to review and test
your patch. This is probably the last missing feature in this driver
for the F71805F. (For the F71872F, VID support is also missing.)

> Something else that I'm curious about is the "CPU thermal throttling" 
> that is offered by my BIOS.  My guess is that the "OVT" (over 
> tempterature) output signal from the Fintek chip goes off to the CPU 
> clock generator, or something like that.  Does anyone know how this works?

You'd need to ask your motherboard vendor. Your guess makes sense and
could be correct, but it could also be implemented completely
differently.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

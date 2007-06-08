From: "Phil Endecott" <phil_lftzl_endecott@chezphil.org>
Date: Fri, 08 Jun 2007 21:00:59 +0000
Subject: [lm-sensors] f71805f + J7F2; getting fan speed control mode working;
Message-Id: <1181336459064@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear All,

I have been trying to get fan speed control working on my Jetway J7F2 
motherboard, which has a Fintek F71805 chip.  Last weekend I posted a 
couple of messages about the first part of the process, in which I 
discovered that the chip's PWM outputs aren't actually connected to the 
board's fan connectors; I fixed that problem with some careful 
soldering onto one of the chip's PWM outputs and a small circuit based 
on the example in the Fintek datasheet.  So I was then able to control 
the fan speed in manual PWM mode.

Something that I noticed at this point was that the default PWM speed 
of 187 kHz didn't give very good waveforms because the turn-off slope 
is quite slow, e.g. with a 50% duty cycle the waveform actually looked 
like this on the scope:

----.   .----.   .---
      \ |      \ |
       \|       \|
        v        v

I am currently using 40 kHz.  This is still well above audio range, but 
the waveforms actually look like square waves giving better control.  
Would this be a better default?  It would depend to some extent on the 
particular fan.

The next problem was that the fan's tacho output is thoroughly garbled 
whenever PWM is used: during the off portion of the PWM waveform, the 
tacho output first goes low and then floats high.  Google found one 
suggestion to fix this by briefly turn the PWM to 100% before taking a 
reading, but this doesn't help when you want to use the chip's 
automatic mode.  I am curious to know if there are any motherboards out 
there with additional components to fix this problem.  One solution is 
the "4 pin fan", but they don't seem to be widely available.  I 
considered various analogue solutions to extract the tacho signal from 
the PWM garbling, but settled on a digital one: I have a 4013 D-type 
flip-flop chip (4000-series logic has the benefit of operating at 12 
volts) which samples the tacho signal on the falling edge of the PWM 
waveform.  This works fine in all cases except one, which I didn't 
consider until I tried it out: duty0%, which has no edges!  Any 
ideas for how to fix this would be welcome.  In manual mode it's not a 
problem because I can avoid using 100%; 99% gives essentially the same 
fan speed.  But in tracking mode I don't think there's a way to tell 
the chip not to go above a certain duty cycle (is there?).

I had to read the source to work out how to use speed tracking mode, 
because the documentation file for the f71805f doesn't give the 
pwm*_enable values for the modes and lists them in the order manual 
(1), speed (3) and temperature (2).  I can submit a documentation patch 
for this if you like.

So the next challenge is temperature tracking.  I understand that this 
is not currently implemented by the driver (I'm looking at the 2.6.21 
source; please let me know and accept my apologies if this driver has 
been updated since then).  I could perhaps add this functionality, but 
first I'd like to know if there was some problem that prevented the 
original author from doing so.

Something else that I'm curious about is the "CPU thermal throttling" 
that is offered by my BIOS.  My guess is that the "OVT" (over 
tempterature) output signal from the Fintek chip goes off to the CPU 
clock generator, or something like that.  Does anyone know how this works?


Many thanks for your attention,

Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Phil Endecott" <phil_lftzl_endecott@chezphil.org>
Date: Sat, 09 Jun 2007 17:40:06 +0000
Subject: Re: [lm-sensors] f71805f + J7F2;
Message-Id: <1181410806892@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609174408.170bfb85@hyperion.delvare>
In-Reply-To: <20070609174408.170bfb85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 08 Jun 2007 22:00:59 +0100, Phil Endecott wrote:
>> Something that I noticed at this point was that the default PWM speed 
>> of 187 kHz didn't give very good waveforms because the turn-off slope 
>> is quite slow, e.g. with a 50% duty cycle the waveform actually looked 
>> like this on the scope:
>> 
>> ----.   .----.   .---
>>       \ |      \ |
>>        \|       \|
>>         v        v
>
> Interesting. I had observed that high frequencies (including the
> default 187 kHz) did not allow proper fan control, but without a scope
> I couldn't watch what the signal looked like. See this graph I had been
> drawing:
> http://khali.linux-fr.org/devel/lm-sensors/pwm_response_curves.png
> 160 kHz gives almost no control at all.

Yes, that agrees with what I was seeing; though your driver-circuit 
and/or fan seem to have a capacitance at least an order of magnitude 
higher than mine.

>> I am currently using 40 kHz.  This is still well above audio range, but 
>> the waveforms actually look like square waves giving better control.  
>> Would this be a better default?  It would depend to some extent on the 
>> particular fan.
>
> The default is from the chip, not from the driver. Usually we don't put
> arbitrary initializations in the hardware monitoring drivers, unless
> a given hardware default is particularly bad. This case might qualify.
> Do you think we should initialize the PWM frequency to 40 kHz at driver
> load time (if and only if the hardware default value is found)?
>
> Me, I am using 1500 Hz, but I agree that it wouldn't be a good default
> as I suppose it could create an audible noise (2000 Hz and 400 Hz do
> for me, for example.)

My fan makes an audible tone at any frequency within the normal hearing range.

It's clear that the right frequency to choose will depend on the 
particular hardware, but I don't think we'll find anything where 187 
kHz is a good choice.  It could perhaps be considered bizarre to choose 
a default based on what I found worked with my unique home-made 
hardware :-)  Jean, you must have written a script to get the numbers 
in that graph; if you post it, perhaps other people can try it out and 
we can see if there is a consensus?  (The 'other people' don't need to 
be F71805 users since it's mainly measuring the characteristics of the 
fan itself.)

>> The next problem was that the fan's tacho output is thoroughly garbled 
>> whenever PWM is used: during the off portion of the PWM waveform, the 
>> tacho output first goes low and then floats high.  Google found one 
>> suggestion to fix this by briefly turn the PWM to 100% before taking a 
>> reading, but this doesn't help when you want to use the chip's 
>> automatic mode.  I am curious to know if there are any motherboards out 
>> there with additional components to fix this problem.

Jean, I assume that you got the numbers for your graph without any 
hardware mods to make the tacho work.  So presumably there is something 
on your motherboard to 'fix' this problem?

> Out of curiosity, which PWM output did you wire to which fan? The
> F71805F pretty much expects that PWM1 controls fan1, PWM2 controls
> fan2, etc.

Indeed it does.  Currently I'm using the connections for fan 1, which 
is the CPU fan - but it's not physically connected to the CPU.  This is 
a low-power "fanless" motherboard, but I'm putting it in a rather 
airless 1U rackmount case; I plan to monitor the CPU temperature and 
switch on the case fan if it gets too high.

> Given that you're wiring everything yourself, you could also try the DC
> control mode. I don't know what effect it has on speed monitoring
> though. Could be even worse than PWM.

Yes it should help a bit with the tacho problem, but it makes the 
driver-circuit more complex; the example in the Fintek datasheet has 
op-amps and I think the power transistor would need a heatsink.

>> I had to read the source to work out how to use speed tracking mode, 
>> because the documentation file for the f71805f doesn't give the 
>> pwm*_enable values for the modes and lists them in the order manual 
>> (1), speed (3) and temperature (2).  I can submit a documentation patch 
>> for this if you like.
>
> I admit the documentation isn't very clear on this particular point. I
> would welcome a patch improving it.

Here's something...

--- linux-2.6.21/Documentation/hwmon/f71805f.orig	2007-06-09 
18:27:21.000000000 +0100
+++ linux-2.6.21/Documentation/hwmon/f71805f	2007-06-09 
18:32:28.000000000 +0100
@@ -136,16 +136,20 @@
  corresponds to a pwm value of 106 for the driver. The driver doesn't
  enforce this limit though.

-Three different fan control modes are supported:
+Three different fan control modes are supported; the mode number is written
+to the pwm<n>_enable file:

-* Manual mode
-  You ask for a specific PWM duty cycle or DC voltage.
+* 1: Manual mode
+  You ask for a specific PWM duty cycle or DC voltage by writing to the
+  pwm<n> file.

-* Fan speed mode
-  You ask for a specific fan speed. This mode assumes that pwm1
-  corresponds to fan1, pwm2 to fan2 and pwm3 to fan3.
-
-* Temperature mode
+* 2: Temperature mode
    You define 3 temperature/fan speed trip points, and the fan speed is
    adjusted depending on the measured temperature, using interpolation.
    This mode is not yet supported by the driver.
+
+* 3: Fan speed mode
+  You ask for a specific fan speed by writing to the fan<n>_target file.
+  This mode assumes that pwm1  corresponds to fan1, pwm2 to fan2 and pwm3
+  to fan3.
+

>> So the next challenge is temperature tracking.  I understand that this 
>> is not currently implemented by the driver (I'm looking at the 2.6.21 
>> source; please let me know and accept my apologies if this driver has 
>> been updated since then).  I could perhaps add this functionality, but 
>> first I'd like to know if there was some problem that prevented the 
>> original author from doing so.
>
> This is still not implemented. The reason was a mix of lack of time and
> lack of interest. My CPU fan is pretty silent anyway, so I could live
> with it at full speed all the time. However, if you want to implement
> this feature, this is welcome, and I'll be happy to review and test
> your patch. This is probably the last missing feature in this driver
> for the F71805F. (For the F71872F, VID support is also missing.)

OK, I'll have a look at it.


Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

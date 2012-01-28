From: CC <ccomren@gmail.com>
Date: Sat, 28 Jan 2012 15:14:35 +0000
Subject: Re: [lm-sensors] [w83627ehf] Not all fans are shown (#3)
Message-Id: <CAH4eiUjQZP7SxagwSb=vGJ4Xf0zaZBdD_kh4mxgackx1pOKfmA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120127145130.GA29746@ericsson.com>
In-Reply-To: <20120127145130.GA29746@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 28, 2012 at 1:53 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Sat, 28 Jan 2012 13:08:14 +0100, CC wrote:
>> It's bad to provide a writable attribute and documentation if one
>> isn't supposed to ever change it...
>
> With this reasoning we wouldn't make any attribute writable, as ideally
> the BIOS would have set up everything properly in the first place. And
> same would hold for a lot of other sysfs attributes.
>
> I agree the limitations of changing the value of the pwm[1-*]_mode
> attribute could be better documented.
>
>> let me rewrite this after a cold
>> boot, where I didn't change any settings, where I use the exact same
>> fan, and where I employ pwmcontrol:
>
> Using the same fan for 4-pin headers and 3-pin headers makes little
> sense. If you used a 3-pin fan, it wouldn't be controllable when
> connected to a 4-pin header. As your results below contradict this, I
> get that you used a 4-pin fan, which means it was controlled
> differently between 3-pin headers (control on the +12V pin) and 4-pin
> headers (control on the tachometer). Beware that some 3-wire fans are
> happy to be controlled by PWM on +12V, but most 4-wire fans are not, as
> they are really designed for a separate control signal.
>
>> pwm1_mode returns 1. Between "PWM 255" and "PWM 75" the fan speed
>> correlation is very jagged, very non-linear.
>> pwm2_mode returns 1. Between "PWM 210" and "PWM 60" the fan speed
>> correlation is surprisingly close to linear.
>> pwm3_mode returns 1. Between "PWM 255" and "PWM 75" the fan speed
>> correlation is very jagged, very non-linear.
>>
>> So the behavior is different, although pwm*_mode returns the same
>> value. Moreover:
>
> Different behavior is explained by 4-pin vs. 3-pin headers, see above.
>
>>
>> * Three pin connectors have ground, +12V and a tachometer signal.
>> * Four pin connectors have ground, +12V, a tachometer signal and a PWM signal.
>>
>> Therefore, only unusual systems can control an unsual 3-pin fan by
>> PWM.
>
> This is plain wrong, sorry. A lot of motherboards have been using 3-pin
> fan headers and offered fan speed control using PWM between, say 2000
> and 2008. Most monitoring chips did not even support DC mode before
> 2007 (with the notable exception of the W83627THF.) There's nothing
> "unusual" about this.
>
> Some 3-wire fans behave better under PWM, while others prefer DC.
> Unfortunately you usually don't get to chose the method, the
> motherboard maker decides for you, because the value at the output pin
> generally needs to be transformed before it goes to the fan. For PWM,
> the output is a logical 0/1 which is applied to +12V before reaching
> the fan. For DC the output is an analog voltage but most controllers
> can't output +12V, they'll output 2.5V max for example, and an external
> amplifier is needed to actually drive the fan. That's why I said that
> changing the mode generally doesn't work, unless the BIOS got it wrong
> in the first place. Feeding an amplifier with a PWM signal won't get
> you anywhere I'm afraid, just like modulating +12V based on another
> voltage output may result in bad things. [1]
>
> 4-wire headers are a completely different story, as power and control
> are on different pins and the control is really only a signal. I think
> 4-pin fans are always controlled by PWM, but if DC is ever possible on
> such fans, then changing the chip settings would work, because no extra
> circuitry on the board is needed, I think the output pin of the control
> chip is routed directly to the fan.
>
>> As per the standard,
>> http://www.formfactors.org/developer/specs/4_Wire_PWM_Spec.pdf, the
>> correlation between the fan speed and the PWM signal is supposed to be
>> linear between its min and max.
>
> That's my observation as well... for 4-wire fans and assuming proper
> PWM frequency. For example:
> http://khali.linux-fr.org/articles/sts100/STS100C_PWM_response__large.png
>
> For 3-wire fans this is a completely different story, the response is
> generally very non-linear at high frequencies, with 75% top duty cycles
> controlling about nothing and only 20% of the range allowing for
> control. Lower frequencies give better results but are often unpleasant
> to the ears. For example:
> http://khali.linux-fr.org/devel/lm-sensors/pwm_response_curves.png
>
>> I conclude that PWM mode is working
>> correctly for pwm2,
>
> As expected, for a 4-pin header with a 4-pin fan.
>
>> and DC mode (the name is from the docs -- most
>> likely it's linear voltage regulation) is working correctly for pwm1
>> and pwm3.
>
> As far as I know DC stands for "direct current" and indeed means
> voltage regulation.
>
> But I fail to see how you come to this conclusion from the experiment
> above. Your reports about pwm1 and pwm3 do match what I would expect
> from PWM sent to a 3-wire fan (or 4-wire fan on a 3-pin header -
> similar behavior.)
>
>> So: I didn't change any settings, but it seems like the meaning of
>> pwm*_mode does not agree with the documentation.
>
> The only way to demonstrate this would be to measure the values at the
> output pin. At this point I have no reason to believe that the values
> reported by the w83627ehf driver are incorrect.
>
> [1] Disclaimer: I am not an electronics guy, so take what I say with a
> grain of salt. The electronics schematics I read over the years for
> various boards and my experience make me believe I'm correct in what I
> say here, but I could be wrong on specific details.
>
> --
> Jean Delvare

I wasn't aware that mainboard chips can and do modulate +12V by PWM
themself. So there's actually *three* methods/modes to drive a fan:

1) Voltage regulation ("DC")
2) PWM by modulating the +12V line
3) PWM by providing a control signal

In my previous statements, I did assume that "PWM" always means (3).
Maybe we could adapt the documentation to reflect the situation. I
guess it's a valid distinction, and you surely wouldn't want another
smart-ass guy complaining about it.

Best,  CC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

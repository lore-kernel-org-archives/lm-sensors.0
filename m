From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Apr 2007 16:45:33 +0000
Subject: Re: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <20070417184533.1d472b62@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415185853.GA11766@xeron.cc>
In-Reply-To: <20070415185853.GA11766@xeron.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jordan,

On Tue, 17 Apr 2007 11:23:44 -0400, Jordan wrote:
> On Tue, Apr 17, 2007 at 10:33:59AM +0200, Jean Delvare wrote:
> > I don't think that Jordan's CPU fan goes off. My understanding is that
> > what Jordan qualifies as "on/off" is the BIOS option (no way to set
> > temperature limits), not the fan behavior when the option is enabled.
> 
> This is correct, it basically turns on/off the automatic fan speed
> adjustments, it doesn't turn the fan off completely. I just want a way
> to control the fan speed more precisely.
> 
> > I don't understand why the manual mode doesn't work either, but the
> > following things could probably be tried:
> > 
> > * Jordan, you say you tried manual mode when the option was disabled in
> > your BIOS. Can you try again when the option is enabled? If the BIOS
> > does extra initialization when the option is on, it might make a
> > difference.
> 
> I have tried adjusting the PWM values with the bios option on/off and it
> seemed to make no difference.
> 
> > * You could try to dump the registers of the W83627DHG chip with the
> > BIOS option off, and then again with the option on, and see if there
> > are relevant differences. Make sure you do NOT let the w83627ehf driver
> > load, though, as it could overwrite a few settings. Assuming that your
> > chip is at the standard address (0x295) you can dump its contents with:
> > 
> > isadump 0x295 0x295
> > 
> > If it lives at a difference address, adjust the command.
> 
> I will have to try this out tonight when I have some more time. I will
> post the results then. BTW, I tried this command now (albeit with the
> module loaded) and it does return output. Is there any easy way to make
> sure my chip is actually at this address?

Let me correct a typo first:

isadump 0x295 0x296

The actual address is printed by "sensors":

w83627ehf-isa-0290
Adapter: ISA adapter
(...)

Add 5 and 6 to the base I/O address for the isadump parameters.

> > * You could try leaving the option enabled in the BIOS, so the fan is
> > in automatic mode, then check the value of all pwmN_enable files. If
> > one has value >= 2, that should be the PWM output controlling your CPU
> > fan. Then you can check the value of pwmN_target, and maybe change it
> > to adjust the behavior.
> 
> Whether it's enabled or disabled in bios, all the pwmN_enable files are
> set to 1.

That's really strange. The dumps will tell us more though.

> > I seem to remember that the W83627DHG supports more fan control modes
> > than the w83627ehf driver handles.
> 
> Maybe there's still some hope then? I'm supposing it's possible my
> motherboard is using a method which the driver just doesn't support in
> it's current state.

If these modes were in use, pwmN_enable would be 3 or more if I
remember correctly. David knows the code better and should be able to
confirm that. So it really looks like it's not what your system uses.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

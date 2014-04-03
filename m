From: Lubos Lunak <l.lunak@centrum.cz>
Date: Thu, 03 Apr 2014 14:31:15 +0000
Subject: Re: [lm-sensors] [PATCH] fancontrol aborts after suspend/resume
Message-Id: <201404031631.15136.l.lunak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <201404021253.49647.l.lunak@centrum.cz>
In-Reply-To: <201404021253.49647.l.lunak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 03 of April 2014, Jean Delvare wrote:
> Hi Lubos,
>
> On Wed, 2 Apr 2014 12:53:49 +0200, Lubos Lunak wrote:
> >  if system running fancontrol is suspended and resumed, fancontrol will
> > abort, as writing the pwm value will fail because of pwm control being
> > set to automatic control after the resume (google for 'fancontrol
> > suspend' for various discussions about this). The attached patch fixes
> > the problem.
>
> I'm afraid this is fixing the problem in the wrong place. The BIOS is
> responsible for restoring the hardware settings at resume time. Failing
> that, the kernel should do it.
>
> So you should first look for a BIOS update, even though the chances
> that it fixes this specific problem are rather low. Then you should
> tell us which hwmon driver you are using, so that we can add proper
> suspend/resume code to it.

 hwmon_vid

> If fan speed control mode settings are lost, 
> other settings may be lost as well and would need to be saved and
> restored too.
>
> That being said I have to admit that your approach, although not clean,
> has the merit to work around the problem regardless of the BIOS or
> hwmon chip in use. This is certainly attractive. My only worry is that
> it _assumes_ that problem comes from an improperly handled
> suspend/resume cycle, which may or may not be the case.

 It doesn't assume, it handles the possibility. But it doesn't matter. If the 
write fails because of something else, it will presumably fail the second 
time as well.

 I can't see how this could realistically break any reasonable scenario. 
Fancontrol has already set up pwm control that way during start, why 
shouldn't it be allowed to do it again?

> It might as 
> well be the BIOS/ACPI changing the settings at run-time,

 In that case fancontrol would abort at any time this happens. Besides, that's 
rather against the idea of pwm being set to manual control, isn't it?

> or another fan monitoring application running in parallel,

 s/monitoring/controlling/ Well, that's certainly an interesting scenario that 
I expect is broken enough for nobody to be bothered enough to handle it.

> or a driver bug. In which 
> case failing with an error is the right thing to do.

 No. If the driver has a glitch that makes the write fail from time to time, 
it's still better if fancontrol copes with that. That is, again, if this 
scenario is actually worth thinking about.

-- 
 Lubos Lunak

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

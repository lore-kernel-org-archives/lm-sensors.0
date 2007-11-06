From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Nov 2007 21:07:11 +0000
Subject: Re: [lm-sensors] dme1737 error messages
Message-Id: <20071106220711.2abd663b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
In-Reply-To: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 6 Nov 2007 10:31:22 -0800, Juerg Haefliger wrote:
> Hi Bobby,
> 
> On 11/4/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > Hi Juerg,
> >
> > With acpi diabled, both kind of errors are gone (acpi errors, which is to be
> > expected, and dme errors). I have another screenshot for you. However this
> > also disables hyperthreading, and now I have only cpu0, whereas with acpi on
> > I had cpu0 and cpu1.
> 
> You can specify acpi=ht to just enable enough ACPI for hyperthreading.
> 
> 
> > With no hwmonitoring - only acpi errors.
> > With dme1737 module loaded - acpi errors plus dme errors.
> > With acpi off - no errors at all.
> 
> OK, so it's definitely ACPI that interferes with the dme1737 driver.
> Not good. I'm surprised that removing the fan and thermal modules
> didn't get rid of the ACPI errors. But then again I'm not an ACPI
> expert so don't really know how it works and what to expect...
> 
> I recompiled the DSDT that you sent me and it's definitely broken. You
> can try to fix it but again I don't know what you can expect from that
> exercise. I also took a closer look at the DSDT and there's code that
> accesses the dme1737 all over the place. It mocks around with temp
> limits and PWM duty cycles and more. It's definitely *not* safe to use
> the dme1737 driver, it's interfering with ACPI regulating the fans
> based on the measured temps. Now why ACPI is controlling the fans
> instead of letting the dme1737 chip take care of it is beyond me...
> You'd have to ask the smart designers at ASUS :-)

There's nothing fundamentally wrong with this, if the ACPI
implementation is correct. Why require an OS driver if they can do the
same in ACPI and it works on all OSes without user interaction?

Of course this also means that the user has almost no control over
what's going on, which is alright if things work well, but becomes a
problem if they don't. The worst thing is that almost all the time, the
ACPI stuff only exposes a small subset of the hardware monitoring
chip's features, which is very frustrating for computer enthusiasts.

> Bottom line, I think you have 3 options:
> 1) Disable ACPI and use the dme1737 driver. In that case you loose the
> automatic fan control unless you set it up yourself. Dangerous, you're
> interfering with the way the machine is designed to work and might fry
> it.
> 2) Take it to the ACPI mailing list and try to figure out what exactly
> ACPI is doing and what needs to be fixed to get rid of the ACPI errors
> (that still doesn't fix the dme1737/ACPI conflict issue).
> 3) If you're brave, you can keep using the dme1737 driver, ignore all
> the erros and hope and pray it doesn't interfere with ACPI in a way
> that puts the HW at risk.
> 
> Jean: Do you know where the whole ACPI/hwmon conflict issue is at? Do
> we know what the problem is, when it occurs, and how to get around it?

The patch I posted (which will be in the next -mm kernel also) attempts
to detect the conflicts, and the hwmon and i2c (bus) drivers will
cooperate and refuse to load when a conflict is detected. This approach
relies on the fact that ACPI is supposed to declare which ports it may
access at run time. This may yield false negatives (if ACPI doesn't
declare port usage properly) and false positives (if ACPI declares
ports that it doesn't actually use.) So we're waiting to see the effect
of the patch on a large number of systems, if it is acceptable it will
go upstream.

It would be great if Borislav could try either my patch or the next -mm
kernel, and report whether the conflict is detected or not.

What we will do next, I'm not sure. In some cases it might be possible
to synchronize the hwmon driver accesses with the ACPI accesses, then
we can get both to cooperate. In other cases it probably won't be
possible and we'll have blacklist the hwmon driver, I fear. There is
also at least one known case where an "ACPI hwmon driver" can be
written on top of the ACPI code to expose all the features as regular
hwmon drivers do. All in all, the outcome will probably be highly
dependent upon the machine, as every ACPI implementation is different.

I'll keep the list updated when things progress, of course.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

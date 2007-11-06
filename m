From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 06 Nov 2007 18:31:22 +0000
Subject: Re: [lm-sensors] dme1737 error messages
Message-Id: <191fb4ca0711061031j5af15b47r9aedacf674d52b27@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
In-Reply-To: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bobby,

On 11/4/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> Hi Juerg,
>
> With acpi diabled, both kind of errors are gone (acpi errors, which is to=
 be
> expected, and dme errors). I have another screenshot for you. However this
> also disables hyperthreading, and now I have only cpu0, whereas with acpi=
 on
> I had cpu0 and cpu1.

You can specify acpi=3Dht to just enable enough ACPI for hyperthreading.


> With no hwmonitoring - only acpi errors.
> With dme1737 module loaded - acpi errors plus dme errors.
> With acpi off - no errors at all.

OK, so it's definitely ACPI that interferes with the dme1737 driver.
Not good. I'm surprised that removing the fan and thermal modules
didn't get rid of the ACPI errors. But then again I'm not an ACPI
expert so don't really know how it works and what to expect...

I recompiled the DSDT that you sent me and it's definitely broken. You
can try to fix it but again I don't know what you can expect from that
exercise. I also took a closer look at the DSDT and there's code that
accesses the dme1737 all over the place. It mocks around with temp
limits and PWM duty cycles and more. It's definitely *not* safe to use
the dme1737 driver, it's interfering with ACPI regulating the fans
based on the measured temps. Now why ACPI is controlling the fans
instead of letting the dme1737 chip take care of it is beyond me...
You'd have to ask the smart designers at ASUS :-)

Bottom line, I think you have 3 options:
1) Disable ACPI and use the dme1737 driver. In that case you loose the
automatic fan control unless you set it up yourself. Dangerous, you're
interfering with the way the machine is designed to work and might fry
it.
2) Take it to the ACPI mailing list and try to figure out what exactly
ACPI is doing and what needs to be fixed to get rid of the ACPI errors
(that still doesn't fix the dme1737/ACPI conflict issue).
3) If you're brave, you can keep using the dme1737 driver, ignore all
the erros and hope and pray it doesn't interfere with ACPI in a way
that puts the HW at risk.

Jean: Do you know where the whole ACPI/hwmon conflict issue is at? Do
we know what the problem is, when it occurs, and how to get around it?

...juerg




> After yet another round of googling about dsdt, acpi etc. I came upon the
> acpi mailing list archive:
> http://marc.info/?l=3Dlinux-acpi&m=119376980121127&w=3D2
> This is just the last message of a lengthy thread, but the situation they
> are trying to address seems awfully like my own. Or maybe I am mistaken
> again?
> I have also enclosed the output of the grep you wanted but I don't think
> that the pwm is set to automatic.
>
> On 11/4/07, Juerg Haefliger <juergh@gmail.com> wrote:
> > Hi Bobby,
> >
> >
> > On 11/4/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > > Hi,
> > >
> > > It's me again :)
> > > I finally managed to pinpoint the moment the errors occur. Apparently
> this
> > > happens the moment the bios tries to change the pwm of the cpu fan,
> which in
> > > turn is triggered by reaching certain temperature levels. See the
> > > screenshot. CPU fan pwm has a range of 0-255. If CPU temperature is
> below
> > > 65, pwm is 96. The moment CPUt exceeds 65, pwm is increased to 149. If
> CPUt
> > > falls below 60, pwm is restored to 96. However if t continues to rise
> and
> > > reaches 72, pwm is set to max 255. I managed to find out these values=
 by
> > > comparing logs of pwm and CPUt.
> > > I hope this additional info is somehow useful.
> >
> > Can you try to disable ACPi to rule it out? Add 'acpi=3Doff' to the
> > kernel boot options in your grub menu.lst file. Check if you still get
> > the errors. If yes, it's definitely  not ACPI.
> >
> > Also, is your dme1737 set to automatic PWM mode? Please run 'grep ""
> > /sys/class/hwmon/*/device/*' and send me the output. Check the value
> > of pwmX_enable for your CPU fan, if it reads '2' the dme1737 is in
> > automatic mode for this PWM and will control the PWM output
> > automatically depending on the assigned temp input. The BIOS isnot
> > involved at all.
> >
> > ...juerg
> >
> >
> >
> > >
> > > Bobby
> > >
> > >
> > > On 11/3/07, Borislav Davitkov <davitkov@gmail.com > wrote:
> > > > Hi Juerg,
> > > >
> > > > 1. Fan and thermal modules have no bearing to the errors (both acpi
> and
> > > dme). I tried all combinations of them loaded and unloaded.
> > > > 2. acpi_cpufreq is not the module for my processor. The module is
> > > p4-clockmod. Again irrelevant to the errors.
> > > > 3. I have a directory /proc/acpi/thermal_zone but there is nothing =
in
> it.
> > > > 4. I found this:
> > >
> http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems#Diagnosing_a_Buggy_=
DSDT
> > > > Followed the instructions and it really turns out that I have a bug=
gy
> dsdt
> > > (8 errors). However, my errors being quite not so trivial as those in
> the
> > > howto, it is beyond my powers to fix it.
> > > > 5. Tested Jean's patch and it does not help either.
> > > >
> > > > Bobby
> > > >
> > > >
> > > > On 10/23/07, Juerg Haefliger < juergh@gmail.com> wrote:
> > > > > Hi Bobby,
> > > > >
> > > > >
> > >
> ....................................................................
> > > > >
> > > > >
> > > > > So the bottom line is you have a broken BIOS causing the ACPI err=
ors
> > > > > and I believe ACPI and the dme1737 driver collide.
> > > > >
> > > > > Here are a few suggestions of things you can try:
> > > > > 1) unload the fan and thermal modules and check if the dme1737 and
> > > > > ACPI errors go away.
> > > > > 2) load the acpi_cpufreq module (don't know if your HW is support=
ed
> > > > > though) and check if the ACPI errors go away.
> > > > > 3) load the thermal module and do 'grep ""
> > > > > /proc/acpi/thermal_zone/*/*' and send the output to the list.
> > > > > 4) send me the DSDT table (in private): cat /proc/acpi/dsdt >
> dsdt.aml
> > > > > 5) test Jean's patch that detects ACPI and hwmon collisions. Jean:
> > > > > where can he pick it up?
> > > > >
> > > > > > Do you have any news about a replacement bios for my motherboar=
d?
> > > > >
> > > > > Nope, couldn't find anything, sorry.
> > > > >
> > > > > ...juerg
> > > > >
> > > > >
> > > > > >  Bobby
> > > > > >
> > > > > >
> > > > > > On 10/10/07, Juerg Haefliger <juergh@gmail.com > wrote:
> > > > > > > Hi Borislav,
> > > > > > >
> > > > > > >
> > > > > > > On 10/9/07, Borislav Davitkov < davitkov@gmail.com> wrote:
> > > > > > > > Hi Juerg,
> > > > > > > >
> > > > > > > > Here is the output of dmesg.
> > > > > > > >
> > > > > > > > Regarding the acpi errors, I tried to modprobe acpi-cpufreq
> but I
> > > got:
> > > > > > > > FATAL: Error inserting acpi_cpufreq
> > > > > > > >
> > > > > >
> > >
> (/lib/modules/2.6.23-rc7-gda8f153e-5-default/kernel/arch/i386/kernel/cpu/=
cpufreq/acpi-
> > > > > > > > cpufreq.ko): No such device
> > > > > > >
> > > > > > > Try enabling CONFIG_CPU_FREQ_DEBUG and recompile.
> > > > > > >
> > > > > > >
> > > > > > > > Btw, examining the output of dmesg, you will see that the B=
IOS
> is
> > > really
> > > > > > > > inadequate:
> > > > > > > > PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> > > > > > > > PCI: Not using MMCONFIG.
> > > > > > > >
> > > > > > > > PS: The second output is after I have loaded the cpu 100% a=
nd
> the
> > > usual
> > > > > > > > dme1737 errors have showed up.
> > > > > > >
> > > > > > > Can you also enable CONFIG_I2C_DEBUG_* and recompile the i2c
> > > modules?
> > > > > > >
> > > > > > > ...juerg
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > On 10/9/07, Juerg Haefliger < juergh@gmail.com> wrote:
> > > > > > > > > Hi Bobby,
> > > > > > > > >
> > > > > > > > > On 10/9/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > > > > > > > > > Unfortunately, the last bios update hp cared to offer is
> more
> > > than
> > > > > > an
> > > > > > > > year
> > > > > > > > > > old. And as you might expect the bios is made to be
> foolproof
> > > to the
> > > > > > > > point
> > > > > > > > > > where you can't do really anything useful with it. I wi=
ll
> > > never buy
> > > > > > > > another
> > > > > > > > > > preassembled branded pc ever. (It looked like a deal at
> the
> > > time :(
> > > > > > )
> > > > > > > > >
> > > > > > > > > Looks like you run into the same issue as
> > > > > > > > >
> > > http://bugzilla.kernel.org/show_bug.cgi?idf49.
> > > > > > > > > I'm not an ACPI expert, by no means. I would take this to
> the
> > > > > > > > > linux-acpi mailing list.
> > > > > > > > > However, it looks to me like your DSDT has references to
> > > _TZ_.THRM
> > > > > > > > > which is also declared external. So something else needs =
to
> be
> > > loaded
> > > > > > > > > (?) that provides this method. Is it SSDT? I don't know, I
> don't
> > > even
> > > > > > > > > know what SSDT is. I can only suggest to follow what one
> person
> > > > > > > > > suggested in the bugzilla bug report: Try loading the
> cpufreq
> > > driver
> > > > > > > > > and check if the error goes away.
> > > > > > > > >
> > > > > > > > > As for the dme1737 errors. Can you send the output of 'dm=
esg
> > > -s64000'?
> > > > > > > > >
> > > > > > > > > ...juerg
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On 10/7/07, Borislav Davitkov < davitkov@gmail.com> wro=
te:
> > > > > > > > > > > Sorry for the belated reply.
> > > > > > > > > > >
> > > > > > > > > > > Lots of network trouble lately. It has been almost a
> full
> > > week
> > > > > > without
> > > > > > > > > > internet here. I am seriously considering changing my I=
SP.
> > > > > > > > > > > Now to the point. I'm sending you the i2cdump you wan=
ted
> > > along
> > > > > > with
> > > > > > > > the
> > > > > > > > > > system log. It's of a fresh boot just after the bootup
> > > messages. If
> > > > > > you
> > > > > > > > need
> > > > > > > > > > something more verbose, you could tell me what options I
> > > should pass
> > > > > > to
> > > > > > > > the
> > > > > > > > > > module.
> > > > > > > > > > >
> > > > > > > > > > > Btw, could you tell me what are the acpi error messag=
es
> > > about. I
> > > > > > have
> > > > > > > > > > tried to look them up in vain. I get them quite often.
> > > > > > > > > > >
> > > > > > > > > > > About the dme errors, I noticed that they are more
> likely to
> > > > > > happen
> > > > > > > > when
> > > > > > > > > > the system is under heavy load. My primary interest in =
the
> > > hwmon
> > > > > > > > > > capabilities of my
> > > > > > > > > > > motherboard arose because I have a P4 3.4GHz Prescott,
> which
> > > > > > generates
> > > > > > > > a
> > > > > > > > > > lot of heat. It came with a very loud stock cooler and
> soon
> > > > > > afterwards I
> > > > > > > > > > replaced with a Scythe Ninja+. With the help of the new
> module
> > > I was
> > > > > > > > finally
> > > > > > > > > > able to put my new cooler to the test. During these tes=
ts
> I
> > > run two
> > > > > > > > > > instances of cpuburn which bring the cpu load up to 100%
> and
> > > make
> > > > > > the
> > > > > > > > dme
> > > > > > > > > > error messages appear more often. I use kima or ksensors
> to
> > > display
> > > > > > the
> > > > > > > > > > various temperatures. Under such a situation (cpu
> overload),
> > > the
> > > > > > > > reported
> > > > > > > > > > temperatures by kima would be -63 degC (maybe this is
> kima's
> > > way of
> > > > > > > > dealing
> > > > > > > > > > with its receiving no values) while ksensors just flash=
es
> > > signaling
> > > > > > > > error.
> > > > > > > > > > This happens just for a little while until (I guess) a =
new
> > > readout
> > > > > > of
> > > > > > > > the
> > > > > > > > > > sensors is carried out. Then normal values are restored.
> These
> > > > > > moments
> > > > > > > > > > coincide with the timestamps of the dme error messages =
in
> the
> > > logs.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Hope I'm being helpful,
> > > > > > > > > > > Bobby
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > On 10/2/07, Juerg Haefliger < juergh@gmail.com > wrot=
e:
> > > > > > > > > > >
> > > > > > > > > > > > Oh and could you please post the full content of the
> > > system log
> > > > > > > > > > > > (relevant section only). Grepping for dme doesn't
> provide
> > > all
> > > > > > the
> > > > > > > > > > > > information.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks
> > > > > > > > > > > > ...juerg
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > On 9/27/07, Borislav Davitkov < davitkov@gmail.com>
> wrote:
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks for adding support for this chip.
> > > > > > > > > > > > > I have a PTGD1-LA (Puffer) mobo.
> > > > > > > > > > > > >
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > >
> http://h10025.www1.hp.com/ewfrf/wc/genericDocument?cc=3Dus&docname=C00208=
497&lc=3Den#
> > > > > > > > > > > > > It is made by ASUS for HP, so it has the A8000 ch=
ip.
> > > > > > > > > > > > >
> > > > > > > > > > > > > After updating my kernel to 2.6.23-rc7 and
> lm-sensors to
> > > > > > 2.10.4 I
> > > > > > > > > > managed to
> > > > > > > > > > > > > get  it working. However, dmesg  shows these
> messages:
> > > > > > > > > > > > >
> > > > > > > > > > > > > dmesg| grep dme
> > > > > > > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes,
> pwm5=3Dno,
> > > pwm6=3Dno,
> > > > > > > > > > fan3=3Dno,
> > > > > > > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes,
> pwm5=3Dno,
> > > pwm6=3Dno,
> > > > > > > > > > fan3=3Dno,
> > > > > > > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes,
> pwm5=3Dno,
> > > pwm6=3Dno,
> > > > > > > > > > fan3=3Dno,
> > > > > > > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x46 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x47 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x22 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x48 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x49 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x23 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x4a failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x4b failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x24 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x4c failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x4d failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x99 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x9b failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x9c failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x9a failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x9d failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x9e failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x25 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x4e failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x4f failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x1f failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x26 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x50 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x51 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x1d failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x27 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x52 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x53 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x1e failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x84 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x85 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x86 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x87 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x88 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x28 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x29 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x54 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x55 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x90 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x2a failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x2b failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x56 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x57 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x91 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x2e failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x2f failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x5a failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x5b failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x93 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x30 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x5f failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x5c failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x64 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x31 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x60 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x5d failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x65 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x32 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x61 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x5e failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x66 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x62 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x63 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x67 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x6a failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x68 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x6b failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x69 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x6c failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x6d failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x6e failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x41 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x42 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > > dme1737 0-002e: Read from register 0x83 failed!
> Please
> > > report
> > > > > > to
> > > > > > > > the
> > > > > > > > > > driver
> > > > > > > > > > > > > maintainer.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So I am reporting to the driver maintainer. :)
> > > > > > > > > > > > > I will be more that happy if I could help in some
> way.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Regards,
> > > > > > > > > > > > > Borislav
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > >
> > > >
> > > >
> > >
> > >
> > >
> >
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 23 Oct 2007 17:52:52 +0000
Subject: Re: [lm-sensors] dme1737 error messages
Message-Id: <191fb4ca0710231052l60b3bd68qa5dc898a7a3cb291@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
In-Reply-To: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bobby,


On 10/20/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> Just a brief follow-up. I did some further investigation. The errors seem=
 to
> coincide with the acpi errors we discussed. The sequence is: The system is
> under heavy load, cpu starts heating up, i get the acpi error (which is
> somehow connected to TZ (thermal zone ?)), smbus busy, lm-sensors can't g=
et
> a readout, hence the dme error messages.
> I logged the temperatures of my cpu. And compared this log with the system
> log. In a situation like the above the reported temperature is -0.063. Th=
is
> happened e.g. at 23:31:39. However at 23:31:46 and 23:41:48, the acpi err=
or
> is reported last. Sometimes the acpi and dme error happen separately. So
> maybe the dme errors are caused by system overload, while the acpi errors
> are triggered by the rising temperature and probably by the thermal monit=
or
> feature of Prescotts. Which makes me think that it might be a bios bug or=
 a
> kernel bug.
> For me it is hard to tell which is the cause and which is the effect and
> whether these errors are related or not and have two different but related
> causes - heat and high system load. One thing is certain if the system is
> not stressed out, these errors do not occur. It runs for days without a
> trace of them in the system log.

The dme1737 errors are because the SMBus is busy. The SMBus is busy
because ACPI is accessing it (I believe). The ACPI errors are due to a
broken BIOS/DSDT or more precisely due to a missing _TZ_ method. I
read somewhere (I believe on the linux acpi mailing list) that the
method might become available when loading the acpi_cpufreq module.

...juerg


> Bobby
>
>
> On 10/20/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > Hi Juerg,
> >
> > Here is another system log with the relevant debug messages. It gets
> interesting at line 8444, especially 8451, and then 8606...
> > Do you have any news about a replacement bios for my motherboard?
> >
> > Bobby
> >
> >
> >
> > On 10/10/07, Juerg Haefliger < juergh@gmail.com> wrote:
> > > Hi Borislav,
> > >
> > >
> > > On 10/9/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > > > Hi Juerg,
> > > >
> > > > Here is the output of dmesg.
> > > >
> > > > Regarding the acpi errors, I tried to modprobe acpi-cpufreq but I g=
ot:
> > > > FATAL: Error inserting acpi_cpufreq
> > > >
> (/lib/modules/2.6.23-rc7-gda8f153e-5-default/kernel/arch/i386/kernel/cpu/=
cpufreq/acpi-
> > > > cpufreq.ko): No such device
> > >
> > > Try enabling CONFIG_CPU_FREQ_DEBUG and recompile.
> > >
> > >
> > > > Btw, examining the output of dmesg, you will see that the BIOS is
> really
> > > > inadequate:
> > > > PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> > > > PCI: Not using MMCONFIG.
> > > >
> > > > PS: The second output is after I have loaded the cpu 100% and the
> usual
> > > > dme1737 errors have showed up.
> > >
> > > Can you also enable CONFIG_I2C_DEBUG_* and recompile the i2c modules?
> > >
> > > ...juerg
> > >
> > >
> > > >
> > > > On 10/9/07, Juerg Haefliger < juergh@gmail.com> wrote:
> > > > > Hi Bobby,
> > > > >
> > > > > On 10/9/07, Borislav Davitkov < davitkov@gmail.com> wrote:
> > > > > > Unfortunately, the last bios update hp cared to offer is more t=
han
> an
> > > > year
> > > > > > old. And as you might expect the bios is made to be foolproof to
> the
> > > > point
> > > > > > where you can't do really anything useful with it. I will never
> buy
> > > > another
> > > > > > preassembled branded pc ever. (It looked like a deal at the time
> :( )
> > > > >
> > > > > Looks like you run into the same issue as
> > > > > http://bugzilla.kernel.org/show_bug.cgi?idf49.
> > > > > I'm not an ACPI expert, by no means. I would take this to the
> > > > > linux-acpi mailing list.
> > > > > However, it looks to me like your DSDT has references to _TZ_.THRM
> > > > > which is also declared external. So something else needs to be
> loaded
> > > > > (?) that provides this method. Is it SSDT? I don't know, I don't
> even
> > > > > know what SSDT is. I can only suggest to follow what one person
> > > > > suggested in the bugzilla bug report: Try loading the cpufreq dri=
ver
> > > > > and check if the error goes away.
> > > > >
> > > > > As for the dme1737 errors. Can you send the output of 'dmesg
> -s64000'?
> > > > >
> > > > > ...juerg
> > > > >
> > > > >
> > > > > >
> > > > > > On 10/7/07, Borislav Davitkov < davitkov@gmail.com> wrote:
> > > > > > > Sorry for the belated reply.
> > > > > > >
> > > > > > > Lots of network trouble lately. It has been almost a full week
> without
> > > > > > internet here. I am seriously considering changing my ISP.
> > > > > > > Now to the point. I'm sending you the i2cdump you wanted along
> with
> > > > the
> > > > > > system log. It's of a fresh boot just after the bootup messages.
> If you
> > > > need
> > > > > > something more verbose, you could tell me what options I should
> pass to
> > > > the
> > > > > > module.
> > > > > > >
> > > > > > > Btw, could you tell me what are the acpi error messages about=
. I
> have
> > > > > > tried to look them up in vain. I get them quite often.
> > > > > > >
> > > > > > > About the dme errors, I noticed that they are more likely to
> happen
> > > > when
> > > > > > the system is under heavy load. My primary interest in the hwmon
> > > > > > capabilities of my
> > > > > > > motherboard arose because I have a P4 3.4GHz Prescott, which
> generates
> > > > a
> > > > > > lot of heat. It came with a very loud stock cooler and soon
> afterwards I
> > > > > > replaced with a Scythe Ninja+. With the help of the new module I
> was
> > > > finally
> > > > > > able to put my new cooler to the test. During these tests I run
> two
> > > > > > instances of cpuburn which bring the cpu load up to 100% and ma=
ke
> the
> > > > dme
> > > > > > error messages appear more often. I use kima or ksensors to
> display the
> > > > > > various temperatures. Under such a situation (cpu overload), the
> > > > reported
> > > > > > temperatures by kima would be -63 degC (maybe this is kima's way
> of
> > > > dealing
> > > > > > with its receiving no values) while ksensors just flashes
> signaling
> > > > error.
> > > > > > This happens just for a little while until (I guess) a new read=
out
> of
> > > > the
> > > > > > sensors is carried out. Then normal values are restored. These
> moments
> > > > > > coincide with the timestamps of the dme error messages in the
> logs.
> > > > > > >
> > > > > > >
> > > > > > > Hope I'm being helpful,
> > > > > > > Bobby
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 10/2/07, Juerg Haefliger < juergh@gmail.com> wrote:
> > > > > > >
> > > > > > > > Oh and could you please post the full content of the system
> log
> > > > > > > > (relevant section only). Grepping for dme doesn't provide a=
ll
> the
> > > > > > > > information.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > > ...juerg
> > > > > > > >
> > > > > > > >
> > > > > > > > On 9/27/07, Borislav Davitkov < davitkov@gmail.com> wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Thanks for adding support for this chip.
> > > > > > > > > I have a PTGD1-LA (Puffer) mobo.
> > > > > > > > >
> > > > > >
> > > >
> http://h10025.www1.hp.com/ewfrf/wc/genericDocument?cc=3Dus&docname=C00208=
497&lc=3Den#
> > > > > > > > > It is made by ASUS for HP, so it has the A8000 chip.
> > > > > > > > >
> > > > > > > > > After updating my kernel to 2.6.23-rc7 and lm-sensors to
> 2.10.4 I
> > > > > > managed to
> > > > > > > > > get  it working. However, dmesg  shows these messages:
> > > > > > > > >
> > > > > > > > > dmesg| grep dme
> > > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno,
> pwm6=3Dno,
> > > > > > fan3=3Dno,
> > > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno,
> pwm6=3Dno,
> > > > > > fan3=3Dno,
> > > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno,
> pwm6=3Dno,
> > > > > > fan3=3Dno,
> > > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > > dme1737 0-002e: Read from register 0x46 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x47 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x22 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x48 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x49 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x23 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x4a failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x4b failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x24 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x4c failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x4d failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x99 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x9b failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x9c failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x9a failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x9d failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x9e failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x25 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x4e failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x4f failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x1f failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x26 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x50 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x51 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x1d failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x27 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x52 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x53 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x1e failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x84 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x85 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x86 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x87 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x88 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x28 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x29 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x54 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x55 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x90 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x2a failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x2b failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x56 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x57 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x91 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x2e failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x2f failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x5a failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x5b failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x93 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x30 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x5f failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x5c failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x64 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x31 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x60 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x5d failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x65 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x32 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x61 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x5e failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x66 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x62 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x63 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x67 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x6a failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x68 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x6b failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x69 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x6c failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x6d failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x6e failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x41 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x42 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > > dme1737 0-002e: Read from register 0x83 failed! Please
> report to
> > > > the
> > > > > > driver
> > > > > > > > > maintainer.
> > > > > > > > >
> > > > > > > > > So I am reporting to the driver maintainer. :)
> > > > > > > > > I will be more that happy if I could help in some way.
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Borislav
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > >
> > > >
> > > >
> > >
> >
> >
> >
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

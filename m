From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 23 Oct 2007 17:41:01 +0000
Subject: Re: [lm-sensors] dme1737 error messages
Message-Id: <191fb4ca0710231041r5642d50asba81d9e08c8a44a2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
In-Reply-To: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bobby,


On 10/20/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> Hi Juerg,
>
> Here is another system log with the relevant debug messages. It gets
> interesting at line 8444, especially 8451, and then 8606...

Ok, it looks like every time you get the ACPI errors, a subsequent
dme1737 access returns a non-zero status (SMBus busy (02)) which in
turn results in a successful reset. So far so good. The 02 means the
following (from the ICH6 spec):

[... This bit can only be set by termination of a command. INTR is not
dependent on the INTREN bit (offset SMBASE + 02h, bit 0) of the Host
controller register (offset 02h). It is only dependent on the
termination of the command. If the INTREN bit is not set, then the
INTR bit will be set, although the interrupt will not be generated.
Software can poll the INTR bit in this non-interrupt case.
0 =3D Software clears this bit by writing a 1 to it. The ICH6 then
deasserts the interrupt or SMI#.
1 =3D The source of the interrupt or SMI# was the successful completion
of its last command. ...]

Now the problematic case is where you get a 'SMBus busy (01)' status .
The following reset does not succeed which makes sense, since the i810
driver is trying to clear a read-only bit. From the ICH6 spec, status
01 means:

[... HOST_BUSY =97 RO.
0 =3D Cleared by the ICH6 when the current transaction is completed.
1 =3D Indicates that the ICH6 is running a command from the host
interface. No SMB registers should be accessed while this bit is set,
except the BLOCK DATA BYTE Register. The BLOCK DATA BYTE Register can
be accessed when this bit is set only when the SMB_CMD bits in the
Host Control Register are programmed for Block command or I2C Read
command. This is necessary in order to check the DONE_STS bit. ...]

So in this case the SMBus controller is busy doing somebody else's
work! Every access by the dme1737 results in a unsuccessful reset
until the next ACPI error comes along. From that point on the SMBus
controller is not busy anymore and accepts subsequent dme1737
accesses. Smells like a collision between the dme1737 driver and ACPI.

So the bottom line is you have a broken BIOS causing the ACPI errors
and I believe ACPI and the dme1737 driver collide.

Here are a few suggestions of things you can try:
1) unload the fan and thermal modules and check if the dme1737 and
ACPI errors go away.
2) load the acpi_cpufreq module (don't know if your HW is supported
though) and check if the ACPI errors go away.
3) load the thermal module and do 'grep ""
/proc/acpi/thermal_zone/*/*' and send the output to the list.
4) send me the DSDT table (in private): cat /proc/acpi/dsdt > dsdt.aml
5) test Jean's patch that detects ACPI and hwmon collisions. Jean:
where can he pick it up?

> Do you have any news about a replacement bios for my motherboard?

Nope, couldn't find anything, sorry.

...juerg


>  Bobby
>
>
> On 10/10/07, Juerg Haefliger <juergh@gmail.com> wrote:
> > Hi Borislav,
> >
> >
> > On 10/9/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > > Hi Juerg,
> > >
> > > Here is the output of dmesg.
> > >
> > > Regarding the acpi errors, I tried to modprobe acpi-cpufreq but I got:
> > > FATAL: Error inserting acpi_cpufreq
> > >
> (/lib/modules/2.6.23-rc7-gda8f153e-5-default/kernel/arch/i386/kernel/cpu/=
cpufreq/acpi-
> > > cpufreq.ko): No such device
> >
> > Try enabling CONFIG_CPU_FREQ_DEBUG and recompile.
> >
> >
> > > Btw, examining the output of dmesg, you will see that the BIOS is rea=
lly
> > > inadequate:
> > > PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> > > PCI: Not using MMCONFIG.
> > >
> > > PS: The second output is after I have loaded the cpu 100% and the usu=
al
> > > dme1737 errors have showed up.
> >
> > Can you also enable CONFIG_I2C_DEBUG_* and recompile the i2c modules?
> >
> > ...juerg
> >
> >
> > >
> > > On 10/9/07, Juerg Haefliger < juergh@gmail.com> wrote:
> > > > Hi Bobby,
> > > >
> > > > On 10/9/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > > > > Unfortunately, the last bios update hp cared to offer is more than
> an
> > > year
> > > > > old. And as you might expect the bios is made to be foolproof to =
the
> > > point
> > > > > where you can't do really anything useful with it. I will never b=
uy
> > > another
> > > > > preassembled branded pc ever. (It looked like a deal at the time =
:(
> )
> > > >
> > > > Looks like you run into the same issue as
> > > > http://bugzilla.kernel.org/show_bug.cgi?idf49.
> > > > I'm not an ACPI expert, by no means. I would take this to the
> > > > linux-acpi mailing list.
> > > > However, it looks to me like your DSDT has references to _TZ_.THRM
> > > > which is also declared external. So something else needs to be load=
ed
> > > > (?) that provides this method. Is it SSDT? I don't know, I don't ev=
en
> > > > know what SSDT is. I can only suggest to follow what one person
> > > > suggested in the bugzilla bug report: Try loading the cpufreq driver
> > > > and check if the error goes away.
> > > >
> > > > As for the dme1737 errors. Can you send the output of 'dmesg -s6400=
0'?
> > > >
> > > > ...juerg
> > > >
> > > >
> > > > >
> > > > > On 10/7/07, Borislav Davitkov <davitkov@gmail.com> wrote:
> > > > > > Sorry for the belated reply.
> > > > > >
> > > > > > Lots of network trouble lately. It has been almost a full week
> without
> > > > > internet here. I am seriously considering changing my ISP.
> > > > > > Now to the point. I'm sending you the i2cdump you wanted along
> with
> > > the
> > > > > system log. It's of a fresh boot just after the bootup messages. =
If
> you
> > > need
> > > > > something more verbose, you could tell me what options I should p=
ass
> to
> > > the
> > > > > module.
> > > > > >
> > > > > > Btw, could you tell me what are the acpi error messages about. I
> have
> > > > > tried to look them up in vain. I get them quite often.
> > > > > >
> > > > > > About the dme errors, I noticed that they are more likely to
> happen
> > > when
> > > > > the system is under heavy load. My primary interest in the hwmon
> > > > > capabilities of my
> > > > > > motherboard arose because I have a P4 3.4GHz Prescott, which
> generates
> > > a
> > > > > lot of heat. It came with a very loud stock cooler and soon
> afterwards I
> > > > > replaced with a Scythe Ninja+. With the help of the new module I =
was
> > > finally
> > > > > able to put my new cooler to the test. During these tests I run t=
wo
> > > > > instances of cpuburn which bring the cpu load up to 100% and make
> the
> > > dme
> > > > > error messages appear more often. I use kima or ksensors to displ=
ay
> the
> > > > > various temperatures. Under such a situation (cpu overload), the
> > > reported
> > > > > temperatures by kima would be -63 degC (maybe this is kima's way =
of
> > > dealing
> > > > > with its receiving no values) while ksensors just flashes signali=
ng
> > > error.
> > > > > This happens just for a little while until (I guess) a new readout
> of
> > > the
> > > > > sensors is carried out. Then normal values are restored. These
> moments
> > > > > coincide with the timestamps of the dme error messages in the log=
s.
> > > > > >
> > > > > >
> > > > > > Hope I'm being helpful,
> > > > > > Bobby
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 10/2/07, Juerg Haefliger < juergh@gmail.com> wrote:
> > > > > >
> > > > > > > Oh and could you please post the full content of the system l=
og
> > > > > > > (relevant section only). Grepping for dme doesn't provide all
> the
> > > > > > > information.
> > > > > > >
> > > > > > > Thanks
> > > > > > > ...juerg
> > > > > > >
> > > > > > >
> > > > > > > On 9/27/07, Borislav Davitkov < davitkov@gmail.com> wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Thanks for adding support for this chip.
> > > > > > > > I have a PTGD1-LA (Puffer) mobo.
> > > > > > > >
> > > > >
> > >
> http://h10025.www1.hp.com/ewfrf/wc/genericDocument?cc=3Dus&docname=C00208=
497&lc=3Den#
> > > > > > > > It is made by ASUS for HP, so it has the A8000 chip.
> > > > > > > >
> > > > > > > > After updating my kernel to 2.6.23-rc7 and lm-sensors to
> 2.10.4 I
> > > > > managed to
> > > > > > > > get  it working. However, dmesg  shows these messages:
> > > > > > > >
> > > > > > > > dmesg| grep dme
> > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno, p=
wm6=3Dno,
> > > > > fan3=3Dno,
> > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno, p=
wm6=3Dno,
> > > > > fan3=3Dno,
> > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > dme1737 0-002e: Optional features: pwm3=3Dyes, pwm5=3Dno, p=
wm6=3Dno,
> > > > > fan3=3Dno,
> > > > > > > > fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > > > > > > dme1737 0-002e: Read from register 0x46 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x47 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x22 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x48 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x49 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x23 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x4a failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x4b failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x24 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x4c failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x4d failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x99 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x9b failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x9c failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x9a failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x9d failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x9e failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x25 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x4e failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x4f failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x1f failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x26 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x50 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x51 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x1d failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x27 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x52 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x53 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x1e failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x84 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x85 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x86 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x87 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x88 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x28 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x29 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x54 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x55 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x90 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x2a failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x2b failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x56 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x57 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x91 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x2e failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x2f failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x5a failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x5b failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x93 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x30 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x5f failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x5c failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x64 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x31 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x60 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x5d failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x65 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x32 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x61 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x5e failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x66 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x62 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x63 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x67 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x6a failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x68 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x6b failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x69 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x6c failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x6d failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x6e failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x41 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x42 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > > dme1737 0-002e: Read from register 0x83 failed! Please repo=
rt
> to
> > > the
> > > > > driver
> > > > > > > > maintainer.
> > > > > > > >
> > > > > > > > So I am reporting to the driver maintainer. :)
> > > > > > > > I will be more that happy if I could help in some way.
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Borislav
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > > >
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

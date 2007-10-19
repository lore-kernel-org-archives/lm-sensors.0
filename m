From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Fri, 19 Oct 2007 19:00:46 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <4dfa50520710191200u6120869crf0f9df889618db64@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi James,

Hans is right. And he's the one I was thinking knew about the uguru.
There *is* linux support. It's pretty good. So I'd guess that the
w83627dhg is being used for its other LPC features (floppy controller,
RTC, I can't remember then all). The sensor part of that chip is not
wired at all, or may be wired up only a little. The uguru will have
most (probably all) of the sensors stuff you're looking for.

Unfortunately, I'm only experienced with the w83627dhg. Hans can help
you though.

David

On 10/19/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> James,
>
> Didn't you get my mail? I really believe you are on a dead trail here and=
 that
> your efforts will be in vane. Repeating myself:
>
> Abit usually does not use the sensors of the super io chip (which the w83=
627dhg
> is), instead they use their own solution called uguru. There is a driver =
for
> this, but the uguru isn't detected by sensors-detect.
>
> Try modprobe abituguru3, and then try running sensors again.
>
> The abituguru3 driver is only available in kernel 2.6.23 and higher, to i=
nstall
> this kernel for F-7 do:
> yum update --enable-repo=3Dupdates-testing kernel
>
> After rebooting into the new kernel do
> modprobe abituguru3
> sensors
>
>
> Regards,
>
> Hans (the author of the abituguru and abituguru3 drivers)
>
>
>
>
> JAMES SCOTT wrote:
> > See inline comments
> >
> > ----- Original Message ----
> > From: David Hubbard <david.c.hubbard@gmail.com>
> > To: James Scott Jr <skoona@verizon.net>; lm-sensors@lm-sensors.org
> > Sent: Friday, October 19, 2007 2:34:54 PM
> > Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'se=
nsors'
> >
> > Hi James,
> >
> >>  I have a system with an Intel Q6600 quad core on a ABit IP35 Pro main=
board,
> >> using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7.  The output from sens=
ors is
> >> wrong.  Is there a preformatted config file for these mainboard somewh=
ere
> >> that I can find?  Or can you give me a hit on what I need to know in o=
rder
> >> to create/adjust one?
> >
> > I think you'll need to create one. I haven't seen any emails on the
> > lm-sensors list about your motherboard.
> >
> > Creating a new config file isn't too hard. Look at the man page for
> > sensors.conf: http://www.lm-sensors.org/wiki/man/sensors.conf
> >
> > You should also have one already (maybe in /etc/sensors.conf) and
> > reading it is very helpful.
> >
> > yes, I have a /etc/sensors.conf with an entry for w83627dhg-isa-*, but =
not coretemp-isa-*
> >
> >>  The cpu cores are really in the high 30's, cpu  & case fans are not
> >> present, ....
> >
> > I'm looking at the IP32 pro manual, page 11, and I see six fans
> > (CPUfan1, SYSfan1, AUXfan1-4). The w83627dhg only reads the RPM from 5
> > fans, which makes me wonder if your southbridge (possibly an Intel
> > ICH9) is controlling one fan. Do you have zero fans connected? Or just
> > one (a CPU fan?). Page 22 of the manual mentions "abit's exclusive
> > Guru Panel." Do you have a uguru on the motherboard? (I'm not really
> > familiar with abit's uguru, but there are some other people here on
> > lm-sensors who know a lot more about it.)
> >
> > I have a cpu fan, and case fan in their labeled position.   I will be a=
dding a memory cooler fan later in the aux1 fan position.  all other positi=
ons are empty.  No uguru as uguru is  a windows app.
> >
> > The sensors.conf file we figure out here, for the sake of all IP32 pro
> > users, should probably not disable the fan input readings and alarms.
> > But if you want, you can set "ignore" statements for all the fans, so
> > they don't show up in the sensors output, since you don't have fans
> > connected to the motherboard.
> >
> >>  [jscott@vserv ~]$ sensors
> >>  w83627dhg-isa-0290
> >>  Adapter: ISA adapter
> >
> > OK, the above lines are fine.
> >
> >>  VCore:     +1.46 V  (min =3D  +1.03 V, max =3D  +1.74 V)
> >>  in1:       +8.76 V  (min =3D +11.30 V, max =3D  +2.80 V) ALARM
> >>  AVCC:      +3.20 V  (min =3D  +2.06 V, max =3D  +0.88 V) ALARM
> >>  3VCC:      +3.20 V  (min =3D  +1.87 V, max =3D  +0.58 V) ALARM
> >>  in4:       +1.48 V  (min =3D  +0.34 V, max =3D  +1.20 V) ALARM
> >>  in5:       +1.34 V  (min =3D  +1.03 V, max =3D  +1.03 V) ALARM
> >>  in6:       +4.28 V  (min =3D  +5.99 V, max =3D  +3.30 V) ALARM
> >>  VSB:       +3.10 V  (min =3D  +3.47 V, max =3D  +2.02 V) ALARM
> >>  VBAT:      +0.51 V  (min =3D  +0.99 V, max =3D  +2.06 V) ALARM
> >
> > It would be really helpful to match these voltages against voltages in
> > your BIOS. Also, try to find information on what the min and max for
> > each should be. The most important ones, of course, are VCore, 3VCC,
> > VBAT, and 12V (which I don't see there).
> >
> > I will get those data points later tonight when I get home.  I remember=
 VCore being 1.33V though.
> >
> > This means that the voltages are not being calculated correctly. This
> > isn't a surprise. The w83627dhg chip reads voltages, but each
> > motherboard is wired differently, so the voltage arriving at the 'dhg
> > pins is never the same.
> >
> >>  Case Fan:    0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
> >>  CPU Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
> >>  Aux Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
> >>  fan4:        0 RPM  (min =3D  439 RPM, div =3D 128) ALARM
> >>  fan5:        0 RPM  (min =3D   81 RPM, div =3D 128) ALARM
> >
> > So it looks like nothing's connected to your fans. We'll just leave
> > them there for now.
> >
> > CPU fan is a 100mm and case fan is a 80mm fan.
> >
> >>  Sys Temp:    +21=B0C  (high =3D   +58=B0C, hyst =3D   +78=B0C)
> >>  CPU Temp:  +30.0=B0C  (high =3D -126.0=B0C, hyst =3D +75.5=B0C)
> >>  AUX Temp:  -23.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> >
> > The temps don't look right. I think coretemp is reporting the right
> > temperature, and sensors.conf will need to scale the temps it gets
> > (which are just voltages) to match coretemp.
> >
> >>  coretemp-isa-0000
> >>  Adapter: ISA adapter
> >>  Core 0:      +54=B0C  (high =3D  +100=B0C)
> >>
> >>  coretemp-isa-0001
> >>  Adapter: ISA adapter
> >>  Core 1:      +51=B0C  (high =3D  +100=B0C)
> >>
> >>  coretemp-isa-0002
> >>  Adapter: ISA adapter
> >>  Core 2:      +49=B0C  (high =3D  +100=B0C)
> >>
> >>  coretemp-isa-0003
> >>  Adapter: ISA adapter
> >>  Core 3:      +52=B0C  (high =3D  +100=B0C)
> >>
> >>  [jscott@vserv ~]$
> >>
> >>
> >>
> >>  [jscott@vserv ~]$ cat /etc/sysconfig/lm_sensors
> >>  ...
> >>  #
> >>  # Generated by sensors-detect on Fri Oct 19 00:26:53 2007
> >>  MODULE_0=3Dw83627ehf
> >>  MODULE_1=3Dcoretemp
> >>  [jscott@vserv ~]$
> >
> > Well, that's a start. Please reply with information about what chips
> > you have (you can run 'lspci -n' for that) and look at your BIOS setup
> > screen for voltages and temperatures. The numbers reported by BIOS
> > will be the most accurate. We'll try to match those numbers in
> > sensors.
> >
> > HTH,
> > David
> >
> > Ok, thanks.
> >
> > I will post the bios temps, speeds, and voltage values, along with my s=
ensors.conf file.  I should mention I am planning to use gkrellm; but I nee=
d sensors to read right before adjusting it.  Question: As I think about th=
e list of ports 'in1, in2, etc' that are contained in the sensors.conf file=
.  How do I determine all the ports available as a starting template - is t=
heir a tool that can enum what's available from the chip? before I verify t=
hat the correct labels and computes are applied?
> >
> > James,
> >
> >
> >
> >
> >
> >
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 19 Oct 2007 18:54:16 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <4718FD58.6070905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

James,

Didn't you get my mail? I really believe you are on a dead trail here and t=
hat=20
your efforts will be in vane. Repeating myself:

Abit usually does not use the sensors of the super io chip (which the w8362=
7dhg=20
is), instead they use their own solution called uguru. There is a driver fo=
r=20
this, but the uguru isn't detected by sensors-detect.

Try modprobe abituguru3, and then try running sensors again.

The abituguru3 driver is only available in kernel 2.6.23 and higher, to ins=
tall=20
this kernel for F-7 do:
yum update --enable-repo=3Dupdates-testing kernel

After rebooting into the new kernel do
modprobe abituguru3
sensors


Regards,

Hans (the author of the abituguru and abituguru3 drivers)




JAMES SCOTT wrote:
> See inline comments
>=20
> ----- Original Message ----
> From: David Hubbard <david.c.hubbard@gmail.com>
> To: James Scott Jr <skoona@verizon.net>; lm-sensors@lm-sensors.org
> Sent: Friday, October 19, 2007 2:34:54 PM
> Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sens=
ors'
>=20
> Hi James,
>=20
>>  I have a system with an Intel Q6600 quad core on a ABit IP35 Pro mainbo=
ard,
>> using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7.  The output from sensor=
s is
>> wrong.  Is there a preformatted config file for these mainboard somewhere
>> that I can find?  Or can you give me a hit on what I need to know in ord=
er
>> to create/adjust one?
>=20
> I think you'll need to create one. I haven't seen any emails on the
> lm-sensors list about your motherboard.
>=20
> Creating a new config file isn't too hard. Look at the man page for
> sensors.conf: http://www.lm-sensors.org/wiki/man/sensors.conf
>=20
> You should also have one already (maybe in /etc/sensors.conf) and
> reading it is very helpful.
>=20
> yes, I have a /etc/sensors.conf with an entry for w83627dhg-isa-*, but no=
t coretemp-isa-*
>=20
>>  The cpu cores are really in the high 30's, cpu  & case fans are not
>> present, ....
>=20
> I'm looking at the IP32 pro manual, page 11, and I see six fans
> (CPUfan1, SYSfan1, AUXfan1-4). The w83627dhg only reads the RPM from 5
> fans, which makes me wonder if your southbridge (possibly an Intel
> ICH9) is controlling one fan. Do you have zero fans connected? Or just
> one (a CPU fan?). Page 22 of the manual mentions "abit's exclusive
> Guru Panel." Do you have a uguru on the motherboard? (I'm not really
> familiar with abit's uguru, but there are some other people here on
> lm-sensors who know a lot more about it.)
>=20
> I have a cpu fan, and case fan in their labeled position.   I will be add=
ing a memory cooler fan later in the aux1 fan position.  all other position=
s are empty.  No uguru as uguru is  a windows app.
>=20
> The sensors.conf file we figure out here, for the sake of all IP32 pro
> users, should probably not disable the fan input readings and alarms.
> But if you want, you can set "ignore" statements for all the fans, so
> they don't show up in the sensors output, since you don't have fans
> connected to the motherboard.
>=20
>>  [jscott@vserv ~]$ sensors
>>  w83627dhg-isa-0290
>>  Adapter: ISA adapter
>=20
> OK, the above lines are fine.
>=20
>>  VCore:     +1.46 V  (min =3D  +1.03 V, max =3D  +1.74 V)
>>  in1:       +8.76 V  (min =3D +11.30 V, max =3D  +2.80 V) ALARM
>>  AVCC:      +3.20 V  (min =3D  +2.06 V, max =3D  +0.88 V) ALARM
>>  3VCC:      +3.20 V  (min =3D  +1.87 V, max =3D  +0.58 V) ALARM
>>  in4:       +1.48 V  (min =3D  +0.34 V, max =3D  +1.20 V) ALARM
>>  in5:       +1.34 V  (min =3D  +1.03 V, max =3D  +1.03 V) ALARM
>>  in6:       +4.28 V  (min =3D  +5.99 V, max =3D  +3.30 V) ALARM
>>  VSB:       +3.10 V  (min =3D  +3.47 V, max =3D  +2.02 V) ALARM
>>  VBAT:      +0.51 V  (min =3D  +0.99 V, max =3D  +2.06 V) ALARM
>=20
> It would be really helpful to match these voltages against voltages in
> your BIOS. Also, try to find information on what the min and max for
> each should be. The most important ones, of course, are VCore, 3VCC,
> VBAT, and 12V (which I don't see there).
>=20
> I will get those data points later tonight when I get home.  I remember V=
Core being 1.33V though.
>=20
> This means that the voltages are not being calculated correctly. This
> isn't a surprise. The w83627dhg chip reads voltages, but each
> motherboard is wired differently, so the voltage arriving at the 'dhg
> pins is never the same.
>=20
>>  Case Fan:    0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
>>  CPU Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
>>  Aux Fan:     0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
>>  fan4:        0 RPM  (min =3D  439 RPM, div =3D 128) ALARM
>>  fan5:        0 RPM  (min =3D   81 RPM, div =3D 128) ALARM
>=20
> So it looks like nothing's connected to your fans. We'll just leave
> them there for now.
>=20
> CPU fan is a 100mm and case fan is a 80mm fan.
>=20
>>  Sys Temp:    +21=B0C  (high =3D   +58=B0C, hyst =3D   +78=B0C)
>>  CPU Temp:  +30.0=B0C  (high =3D -126.0=B0C, hyst =3D +75.5=B0C)
>>  AUX Temp:  -23.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>=20
> The temps don't look right. I think coretemp is reporting the right
> temperature, and sensors.conf will need to scale the temps it gets
> (which are just voltages) to match coretemp.
>=20
>>  coretemp-isa-0000
>>  Adapter: ISA adapter
>>  Core 0:      +54=B0C  (high =3D  +100=B0C)
>>
>>  coretemp-isa-0001
>>  Adapter: ISA adapter
>>  Core 1:      +51=B0C  (high =3D  +100=B0C)
>>
>>  coretemp-isa-0002
>>  Adapter: ISA adapter
>>  Core 2:      +49=B0C  (high =3D  +100=B0C)
>>
>>  coretemp-isa-0003
>>  Adapter: ISA adapter
>>  Core 3:      +52=B0C  (high =3D  +100=B0C)
>>
>>  [jscott@vserv ~]$
>>
>>
>>
>>  [jscott@vserv ~]$ cat /etc/sysconfig/lm_sensors
>>  ...
>>  #
>>  # Generated by sensors-detect on Fri Oct 19 00:26:53 2007
>>  MODULE_0=3Dw83627ehf
>>  MODULE_1=3Dcoretemp
>>  [jscott@vserv ~]$
>=20
> Well, that's a start. Please reply with information about what chips
> you have (you can run 'lspci -n' for that) and look at your BIOS setup
> screen for voltages and temperatures. The numbers reported by BIOS
> will be the most accurate. We'll try to match those numbers in
> sensors.
>=20
> HTH,
> David
>=20
> Ok, thanks.
>=20
> I will post the bios temps, speeds, and voltage values, along with my sen=
sors.conf file.  I should mention I am planning to use gkrellm; but I need =
sensors to read right before adjusting it.  Question: As I think about the =
list of ports 'in1, in2, etc' that are contained in the sensors.conf file. =
 How do I determine all the ports available as a starting template - is the=
ir a tool that can enum what's available from the chip? before I verify tha=
t the correct labels and computes are applied? =20
>=20
> James,
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>
Date: Mon, 10 Jun 2013 09:00:07 +0000
Subject: Re: [lm-sensors] k10temp-pci-00c3 goes from 11 to 0 degrees
Message-Id: <CABp=A6NFHC8mEOZfKm5iNfOe+3vOwDo=G479NnAJgdeYOAM9DQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8007868923294183910=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABp=A6OdWf_q8vcc65R532xJswsYQBnNgX9ZyyaLDy6hx4qWGA@mail.gmail.com>
In-Reply-To: <CABp=A6OdWf_q8vcc65R532xJswsYQBnNgX9ZyyaLDy6hx4qWGA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8007868923294183910==
Content-Type: multipart/alternative; boundary=bcaec5171987dae6e904dec901af

--bcaec5171987dae6e904dec901af
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

to verify the chip i used hmonitor trial version and came up with this log:

Windows 7 x64 Version 6.1.7601 Service Pack 1
Manufacturer: MSI
Board model: FM2-A75MA-E35 (MS-7721)
Version: 1.0
BIOS vendor: American Megatrends Inc.
BIOS version: V2.0, Release date: 04/25/2013
Chipset: 14101022
Vendor ID: 77211462
SouthBridge: 00000000
SMB port used: 0000
CPU:AMD A4-5300 APU with Radeon(tm) HD Graphics
CPUId:0-F-0-1
Cores:2
Internal Freq=3D3400,0 MHz
External Freq=3D188,89 MHz
Multiplier=3D18,0
SystemBus Freq=3D377,8 MHz DDR
Memory Freq=3D1511,1 MHz DDR2


Monitored data values:
Mainboard=3D30,0=B0C (0,Diode,0,0=B0C)
CPU1=3D28,0=B0C (1,Diode,0,0=B0C)
CPU2=3D30,0=B0C (0,Diode,0,0=B0C)
PSU=3Dxx.x=B0C (0,Auto,0,0=B0C)
Chassis=3D1460 rpm
CPU1=3D783 rpm

main sensor:F71868AD

So if verified this is the same finteck sensor!
any chance we can combine the 2 mailing list?

it seems like were working next to eachother on the same problem.

ill send a mail to fintek or/and msi and let know if i got a response!,
greetings,
and thanks for the explanation,

Steven vdb


On Mon, Jun 10, 2013 at 9:40 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Steven,
>
> Please keep the list in Cc.
>
> On Mon, 10 Jun 2013 00:25:45 +0200, Steven Vanden Branden wrote:
> > Op zondag 9 juni 2013 20:45:33 schreef u:
> > > So you have an unsupported Super-I/O. Would be great if you could try
> > > to find out what it is. Another user reported a Fintek F71868AD with
> > > that device ID. We don't support it yet, and without a datasheet we
> > > can't support it, but maybe your Windows monitoring tool has support
> > > and the good temperature reading you were seeing is from that chip an=
d
> > > not the AMD CPU integrated sensors.
> >
> > I suppose that its the same i/o chip , and i also suppose the other use=
r
> asked
> > fintek for a datasheet?
>
> You shouldn't suppose, and I don't know.
>
> > The windows monitor is the msi control center. It shows 2 temperatures,
> one
> > from the apu and 1 from inside the casing. I do not know if those 2 are
> > controlled by that same chip.
>
> If the tool doesn't say, it's difficult to guess.
>
> > How does the reading of the temperature works for apu's? We probebly
> need that
> > finteck chip to read the apu temperature also?
>
> Well normally all recent CPU have an embedded digital thermal sensor,
> but apparently it isn't returning proper values in your case.
>
> Note though that these integrated digital sensors are documented by
> both Intel and AMD as having very bad accuracy at low temperatures. As
> the sensor is can't return negative values, the "0" you get may simply
> mean that your CPU is very well cooled.
>
> But it is also possible that your CPU digital sensor is defective, I
> don't know. There have been many such cases reported in the past, for
> specific CPU lines.
>
> Either way, most boards also have a monitoring chip, which can monitor
> several temperatures, and often one of the temperature inputs is
> connected to an analog temperature inside or underneath the CPU. This
> may be what you're seeing in the BIOS / Windows.
>
> > Im very sure the sensor works nice because windows and bios work fine
> too!
> > Also the fan can be controlled via windows or the BIOS. So i suppose
> that i
> > also uses that same chip?
>
> Yes, it is likely that the Super-I/O is responsible for both
> temperature monitoring and fan control.
>
> > Please let me know if i have to send a mail to MSI or Finteck for that
> > datasheet? You know where i can find a datasheet of the motherboard so =
i
> can
> > verify the same chip is there?
>
> Best is to open the case and read the chip marking.
>
> Your motherboard's manual doesn't mention the Super-I/O chip name,
> unfortunately.
>
> Asking MSI and/or Fintek for a datasheet is always a good idea. But
> first you have to ensure this is a Fintek chip, and find the exact chip
> name.
>
> --
> Jean Delvare
>

--bcaec5171987dae6e904dec901af
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">to verify the chip i used hmonitor trial version and came =
up with this log:<br><div><div><br>Windows 7 x64 Version 6.1.7601 Service P=
ack 1<br>Manufacturer: MSI<br>Board model: FM2-A75MA-E35 (MS-7721)<br>Versi=
on: 1.0<br>
BIOS vendor: American Megatrends Inc.<br>BIOS version: V2.0, Release date: =
04/25/2013<br>Chipset: 14101022<br>Vendor ID: 77211462<br>SouthBridge: 0000=
0000<br>SMB port used: 0000<br>CPU:AMD A4-5300 APU with Radeon(tm) HD Graph=
ics<br>
CPUId:0-F-0-1<br>Cores:2<br>Internal Freq=3D3400,0 MHz<br>External Freq=3D1=
88,89 MHz<br>Multiplier=3D18,0<br>SystemBus Freq=3D377,8 MHz DDR<br>Memory =
Freq=3D1511,1 MHz DDR2<br><br><br>Monitored data values:<br>Mainboard=3D30,=
0=B0C (0,Diode,0,0=B0C)<br>
CPU1=3D28,0=B0C (1,Diode,0,0=B0C)<br>CPU2=3D30,0=B0C (0,Diode,0,0=B0C)<br>P=
SU=3Dxx.x=B0C (0,Auto,0,0=B0C)<br>Chassis=3D1460 rpm<br>CPU1=3D783 rpm<br><=
br>main sensor:F71868AD<br><br></div><div>So if verified this is the same f=
inteck sensor!<br>
</div><div>any chance we can combine the 2 mailing list?<br><br></div><div>=
it seems like were working next to eachother on the same problem.<br><br></=
div><div>ill send a mail to fintek or/and msi and let know if i got a respo=
nse!,<br>
</div><div>greetings,<br></div><div>and thanks for the explanation,<br><br>=
Steven vdb<br></div></div></div><div class=3D"gmail_extra"><br><br><div cla=
ss=3D"gmail_quote">On Mon, Jun 10, 2013 at 9:40 AM, Jean Delvare <span dir=
=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D"_blank">khali@=
linux-fr.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Steven,<br>
<br>
Please keep the list in Cc.<br>
<div class=3D"im"><br>
On Mon, 10 Jun 2013 00:25:45 +0200, Steven Vanden Branden wrote:<br>
&gt; Op zondag 9 juni 2013 20:45:33 schreef u:<br>
</div><div class=3D"im">&gt; &gt; So you have an unsupported Super-I/O. Wou=
ld be great if you could try<br>
&gt; &gt; to find out what it is. Another user reported a Fintek F71868AD w=
ith<br>
&gt; &gt; that device ID. We don&#39;t support it yet, and without a datash=
eet we<br>
&gt; &gt; can&#39;t support it, but maybe your Windows monitoring tool has =
support<br>
&gt; &gt; and the good temperature reading you were seeing is from that chi=
p and<br>
&gt; &gt; not the AMD CPU integrated sensors.<br>
&gt;<br>
&gt; I suppose that its the same i/o chip , and i also suppose the other us=
er asked<br>
&gt; fintek for a datasheet?<br>
<br>
</div>You shouldn&#39;t suppose, and I don&#39;t know.<br>
<div class=3D"im"><br>
&gt; The windows monitor is the msi control center. It shows 2 temperatures=
, one<br>
&gt; from the apu and 1 from inside the casing. I do not know if those 2 ar=
e<br>
&gt; controlled by that same chip.<br>
<br>
</div>If the tool doesn&#39;t say, it&#39;s difficult to guess.<br>
<div class=3D"im"><br>
&gt; How does the reading of the temperature works for apu&#39;s? We probeb=
ly need that<br>
&gt; finteck chip to read the apu temperature also?<br>
<br>
</div>Well normally all recent CPU have an embedded digital thermal sensor,=
<br>
but apparently it isn&#39;t returning proper values in your case.<br>
<br>
Note though that these integrated digital sensors are documented by<br>
both Intel and AMD as having very bad accuracy at low temperatures. As<br>
the sensor is can&#39;t return negative values, the &quot;0&quot; you get m=
ay simply<br>
mean that your CPU is very well cooled.<br>
<br>
But it is also possible that your CPU digital sensor is defective, I<br>
don&#39;t know. There have been many such cases reported in the past, for<b=
r>
specific CPU lines.<br>
<br>
Either way, most boards also have a monitoring chip, which can monitor<br>
several temperatures, and often one of the temperature inputs is<br>
connected to an analog temperature inside or underneath the CPU. This<br>
may be what you&#39;re seeing in the BIOS / Windows.<br>
<div class=3D"im"><br>
&gt; Im very sure the sensor works nice because windows and bios work fine =
too!<br>
&gt; Also the fan can be controlled via windows or the BIOS. So i suppose t=
hat i<br>
&gt; also uses that same chip?<br>
<br>
</div>Yes, it is likely that the Super-I/O is responsible for both<br>
temperature monitoring and fan control.<br>
<div class=3D"im"><br>
&gt; Please let me know if i have to send a mail to MSI or Finteck for that=
<br>
&gt; datasheet? You know where i can find a datasheet of the motherboard so=
 i can<br>
&gt; verify the same chip is there?<br>
<br>
</div>Best is to open the case and read the chip marking.<br>
<br>
Your motherboard&#39;s manual doesn&#39;t mention the Super-I/O chip name,<=
br>
unfortunately.<br>
<br>
Asking MSI and/or Fintek for a datasheet is always a good idea. But<br>
first you have to ensure this is a Fintek chip, and find the exact chip<br>
name.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div>

--bcaec5171987dae6e904dec901af--


--===============8007868923294183910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8007868923294183910==--

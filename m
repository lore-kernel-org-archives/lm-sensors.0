From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Wed, 14 Aug 2013 02:41:22 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzSDoz_9yrvNQsvLccbCzUuSG-w_2g-MeepEhb5YzRzSJQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001a11c28efa09e20504e3df4b02"
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--001a11c28efa09e20504e3df4b02
Content-Type: multipart/alternative; boundary=001a11c28efa09e20104e3df4b00

--001a11c28efa09e20104e3df4b00
Content-Type: text/plain; charset=ISO-8859-1

Thanks again Guenter!



On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil wrote:
> > Thanks for the response Guenter!
> >
> > I put the system on load and I noticed their value hardly changes. To my
> > surprise, I ran a benchmark for 3 minutes and none of temp*  values
> changed
> > during execution. The highest reported temperature is always 48C.
> >
> > I was expecting that the internal temperature would have "sensor =
> thermal
> > diode" or "sensor = core" as a keyword. I thought "sensor=thermistor"
> means
> > the corresponding sensor is on the motherboard and not the internal
> > die-sensor.
> >
> Sure, but who knows if they put a sensor below the CPU for some reason ...
>
> I am not familiar with the A10 CPUs. Are those similar to K10 ?
> If so, maybe the k10temp driver works or could be extended to support it.
> Can you give it a try ?
>
> If it does not work out of the box, can you send me the output of "lspci
> -nn" ?
>
>
Kapil: I believe K10 corresponds to A8 seried, and A10 has Bulldozer
architecture (http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html). I
am not sure how different they are though. I tried K10, but it did not work
out of the box. I am looking into k10temp.c driver now. Also,I am attaching
the output of "lspci -nn" command herewith; you might have to open it using
wordpad for proper formatting..

> Also, I noticed something that even though I installed and inserted the
> > driver for f71882fg, when I run "sensor-detect", it still says that
> "Note:
> > there is no driver for Fintek F71869FG SUper IO Sensors yet". I thought
> the
> > driver name for F71869FG chip is f71882fg (as per
>
> The most recent version of sensors-detect should support it.
>
>
Kapil: When I used another sensors-detect (probably a newer one) script, I
no longer see the above warning. It recommended me the following at the end
of sensors-detect: "copy prog/init/lm_sensors.init to
/etc/init.d/lm_sensors". I couldn't find the prog/init directory, but I
copied /etc/sysconfig/lmsensors file in to /etc/init.d directory. But, I
still have to insert the f71882fg.ko driver every time I restart the
computer. I couldn't run "make install successfully, as suggested here:
http://khali.linux-fr.org/devel/lm-sensors/drivers/INSTALL .

[ Side note: Please don't top-post. ]
>
> Guenter
>
> > http://lm-sensors.org/wiki/Devices). I installed this driver from here:
> > http://khali.linux-fr.org/devel/lm-sensors/drivers/f71882fg/ .
> >
> > I am not worried about the fan-rpm because I intentionally replaced the
> fan
> > with a custom heat sink. I mentioned that just so that you ignore those
> > lines;-).
> >
> >
> > Thanks,
> > Kapil
> >
> > On Tue, Aug 13, 2013 at 4:27 PM, Guenter Roeck <linux@roeck-us.net>
> wrote:
> >
> > > On Tue, Aug 13, 2013 at 03:05:58PM -0400, Dev, Kapil wrote:
> > > > Hi,
> > > >
> > > > I just changed the motherboard and the processor while the hard-disk
> is
> > > the
> > > > same. I am trying to read the on-die temperature of the AMD A10 5700
> > > > processor. Based on the output of "sensors-detect" command, I
> > > > installed f71882fg
> > > > driver, but the "sensors" command doesn't seem to give me the value
> of
> > > > core-temperature. IN particular, I am getting following output from
> > > sensors
> > > > command:
> > > >
> > > >
> > >
> ----------------------------------------------------------------------------------------------------
> > > > f71869-isa-0e80
> > > > Adapter: ISA adapter
> > > > in0:         +1.68 V
> > > > in1:         +1.05 V
> > > > in2:         +1.21 V
> > > > in3:         +1.22 V
> > > > in4:         +1.54 V
> > > > in5:         +1.19 V
> > > > in6:         +1.19 V
> > > > in7:         +1.73 V
> > > > in8:         +1.65 V
> > > > fan1:          0 RPM  ALARM
> > > > fan2:          0 RPM  ALARM
> > > > fan3:          0 RPM  ALARM
> > > > temp1:       +31.0 C  (high = +85.0 C, hyst = +81.0 C)
> > > >                       (crit = +100.0 C, hyst = +96.0 C)  sensor =
> > > thermistor
> > > > temp2:       +30.0 C  (high = +85.0 C, hyst = +81.0 C)
> > > >                       (crit = +100.0 C, hyst = +96.0 C)  sensor =
> > > thermistor
> > > > temp3:       +48.0 C  (high = +70.0 C, hyst = +68.0 C)
> > > >                       (crit = +85.0 C, hyst = +83.0 C)  sensor =
> > > thermistor
> > >
> > > One of those three is probably from the CPU (wild guess would be
> temp3).
> > > You might be able to find a correlation by putting the system under
> load
> > > and observing temperature rises.
> > >
> > > >
> > >
> ----------------------------------------------------------------------------------------------------
> > > >
> > > > I am wondering if I have to install lm_sensors package all over
> again.
> > > > Also, I am wondering if "sensors-detect" is up-to-date to detect all
> > > > devices/drivers. I guess the fans' rpm readings are 0 because I am
> using
> > > a
> > > > custom liquid-based cooling system  instead of regular fan.
> > > >
> > > If nothing turns it can't measure rpm ...
> > >
> > > Guenter
> > >
>

--001a11c28efa09e20104e3df4b00
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks again Guenter!<div><br></div><div><br><br><div class=3D"gmail_quote"=
>On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&g=
t;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Tue, Aug 13, 2013 at 05=
:11:31PM -0400, Dev, Kapil wrote:<br>
&gt; Thanks for the response Guenter!<br>
&gt;<br>
&gt; I put the system on load and I noticed their value hardly changes. To =
my<br>
&gt; surprise, I ran a benchmark for 3 minutes and none of temp* =A0values =
changed<br>
&gt; during execution. The highest reported temperature is always 48C.<br>
&gt;<br>
&gt; I was expecting that the internal temperature would have &quot;sensor =
=3D thermal<br>
&gt; diode&quot; or &quot;sensor =3D core&quot; as a keyword. I thought &qu=
ot;sensor=3Dthermistor&quot; means<br>
&gt; the corresponding sensor is on the motherboard and not the internal<br=
>
&gt; die-sensor.<br>
&gt;<br>
</div>Sure, but who knows if they put a sensor below the CPU for some reaso=
n ...<br>
<br>
I am not familiar with the A10 CPUs. Are those similar to K10 ?<br>
If so, maybe the k10temp driver works or could be extended to support it.<b=
r>
Can you give it a try ?<br>
<br>
If it does not work out of the box, can you send me the output of &quot;lsp=
ci -nn&quot; ?<br>
<div class=3D"im"><br></div></blockquote><div><br></div><div>Kapil: I belie=
ve K10 corresponds to A8 seried, and A10 has Bulldozer architecture (<a hre=
f=3D"http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html">http://w=
ww.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html</a>).=A0I am not sure =
how different they are though. I tried K10, but it did not work out of the =
box. I am looking into k10temp.c driver now. Also,I am attaching the output=
 of &quot;lspci -nn&quot; command herewith; you might have to open it using=
 wordpad for proper formatting..=A0</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
&gt; Also, I noticed something that even though I installed and inserted th=
e<br>
&gt; driver for f71882fg, when I run &quot;sensor-detect&quot;, it still sa=
ys that &quot;Note:<br>
&gt; there is no driver for Fintek F71869FG SUper IO Sensors yet&quot;. I t=
hought the<br>
&gt; driver name for F71869FG chip is f71882fg (as per<br>
<br>
</div>The most recent version of sensors-detect should support it.<br>
<br></blockquote><div><br></div><div>Kapil: When I used another sensors-det=
ect (probably a newer one) script, I no longer see the above warning. It re=
commended me the following at the end of sensors-detect: &quot;copy prog/in=
it/lm_sensors.init to /etc/init.d/lm_sensors&quot;. I couldn&#39;t find the=
 prog/init directory, but I copied /etc/sysconfig/lmsensors file in to /etc=
/init.d directory. But, I still have to insert the f71882fg.ko driver every=
 time I restart the computer. I couldn&#39;t run &quot;make install success=
fully, as suggested here:=A0<a href=3D"http://khali.linux-fr.org/devel/lm-s=
ensors/drivers/INSTALL">http://khali.linux-fr.org/devel/lm-sensors/drivers/=
INSTALL</a>=A0.=A0</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
[ Side note: Please don&#39;t top-post. ]<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; <a href=3D"http://lm-sensors.org/wiki/Devices" target=3D"_blank">http:=
//lm-sensors.org/wiki/Devices</a>). I installed this driver from here:<br>
&gt; <a href=3D"http://khali.linux-fr.org/devel/lm-sensors/drivers/f71882fg=
/" target=3D"_blank">http://khali.linux-fr.org/devel/lm-sensors/drivers/f71=
882fg/</a> .<br>
&gt;<br>
&gt; I am not worried about the fan-rpm because I intentionally replaced th=
e fan<br>
&gt; with a custom heat sink. I mentioned that just so that you ignore thos=
e<br>
&gt; lines;-).<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Kapil<br>
&gt;<br>
&gt; On Tue, Aug 13, 2013 at 4:27 PM, Guenter Roeck &lt;<a href=3D"mailto:l=
inux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Tue, Aug 13, 2013 at 03:05:58PM -0400, Dev, Kapil wrote:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I just changed the motherboard and the processor while the h=
ard-disk is<br>
&gt; &gt; the<br>
&gt; &gt; &gt; same. I am trying to read the on-die temperature of the AMD =
A10 5700<br>
&gt; &gt; &gt; processor. Based on the output of &quot;sensors-detect&quot;=
 command, I<br>
&gt; &gt; &gt; installed f71882fg<br>
&gt; &gt; &gt; driver, but the &quot;sensors&quot; command doesn&#39;t seem=
 to give me the value of<br>
&gt; &gt; &gt; core-temperature. IN particular, I am getting following outp=
ut from<br>
&gt; &gt; sensors<br>
&gt; &gt; &gt; command:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; -----------------------------------------------------------------=
-----------------------------------<br>
&gt; &gt; &gt; f71869-isa-0e80<br>
&gt; &gt; &gt; Adapter: ISA adapter<br>
&gt; &gt; &gt; in0: =A0 =A0 =A0 =A0 +1.68 V<br>
&gt; &gt; &gt; in1: =A0 =A0 =A0 =A0 +1.05 V<br>
&gt; &gt; &gt; in2: =A0 =A0 =A0 =A0 +1.21 V<br>
&gt; &gt; &gt; in3: =A0 =A0 =A0 =A0 +1.22 V<br>
&gt; &gt; &gt; in4: =A0 =A0 =A0 =A0 +1.54 V<br>
&gt; &gt; &gt; in5: =A0 =A0 =A0 =A0 +1.19 V<br>
&gt; &gt; &gt; in6: =A0 =A0 =A0 =A0 +1.19 V<br>
&gt; &gt; &gt; in7: =A0 =A0 =A0 =A0 +1.73 V<br>
&gt; &gt; &gt; in8: =A0 =A0 =A0 =A0 +1.65 V<br>
&gt; &gt; &gt; fan1: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; &gt; &gt; fan2: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; &gt; &gt; fan3: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; &gt; &gt; temp1: =A0 =A0 =A0 +31.0 C =A0(high =3D +85.0 C, hyst =3D +8=
1.0 C)<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0=
 C, hyst =3D +96.0 C) =A0sensor =3D<br>
&gt; &gt; thermistor<br>
&gt; &gt; &gt; temp2: =A0 =A0 =A0 +30.0 C =A0(high =3D +85.0 C, hyst =3D +8=
1.0 C)<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0=
 C, hyst =3D +96.0 C) =A0sensor =3D<br>
&gt; &gt; thermistor<br>
&gt; &gt; &gt; temp3: =A0 =A0 =A0 +48.0 C =A0(high =3D +70.0 C, hyst =3D +6=
8.0 C)<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +85.0 =
C, hyst =3D +83.0 C) =A0sensor =3D<br>
&gt; &gt; thermistor<br>
&gt; &gt;<br>
&gt; &gt; One of those three is probably from the CPU (wild guess would be =
temp3).<br>
&gt; &gt; You might be able to find a correlation by putting the system und=
er load<br>
&gt; &gt; and observing temperature rises.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; -----------------------------------------------------------------=
-----------------------------------<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am wondering if I have to install lm_sensors package all o=
ver again.<br>
&gt; &gt; &gt; Also, I am wondering if &quot;sensors-detect&quot; is up-to-=
date to detect all<br>
&gt; &gt; &gt; devices/drivers. I guess the fans&#39; rpm readings are 0 be=
cause I am using<br>
&gt; &gt; a<br>
&gt; &gt; &gt; custom liquid-based cooling system =A0instead of regular fan=
.<br>
&gt; &gt; &gt;<br>
&gt; &gt; If nothing turns it can&#39;t measure rpm ...<br>
&gt; &gt;<br>
&gt; &gt; Guenter<br>
&gt; &gt;<br>
</div></div></blockquote></div><br></div>

--001a11c28efa09e20104e3df4b00--

--001a11c28efa09e20504e3df4b02
Content-Type: text/plain; charset=US-ASCII; name="lspci_output.txt"
Content-Disposition: attachment; filename="lspci_output.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkbxh4d80

MDA6MDAuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMgW0FNRF0g
RGV2aWNlIFsxMDIyOjE0MTBdCjAwOjAwLjIgR2VuZXJpYyBzeXN0ZW0gcGVyaXBoZXJhbCBbMDgw
Nl06IEFkdmFuY2VkIE1pY3JvIERldmljZXMgW0FNRF0gRGV2aWNlIFsxMDIyOjE0MTldCjAwOjAx
LjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlciBbMDMwMF06IEFUSSBUZWNobm9sb2dpZXMgSW5j
IERldmljZSBbMTAwMjo5OTAxXQowMDowMS4xIEF1ZGlvIGRldmljZSBbMDQwM106IEFUSSBUZWNo
bm9sb2dpZXMgSW5jIERldmljZSBbMTAwMjo5OTAyXQowMDoxMC4wIFVTQiBDb250cm9sbGVyIFsw
YzAzXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcyBbQU1EXSBEZXZpY2UgWzEwMjI6NzgxMl0gKHJl
diAwMykKMDA6MTAuMSBVU0IgQ29udHJvbGxlciBbMGMwM106IEFkdmFuY2VkIE1pY3JvIERldmlj
ZXMgW0FNRF0gRGV2aWNlIFsxMDIyOjc4MTJdIChyZXYgMDMpCjAwOjExLjAgU0FUQSBjb250cm9s
bGVyIFswMTA2XTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcyBbQU1EXSBEZXZpY2UgWzEwMjI6Nzgw
MF0gKHJldiA0MCkKMDA6MTIuMCBVU0IgQ29udHJvbGxlciBbMGMwM106IEFkdmFuY2VkIE1pY3Jv
IERldmljZXMgW0FNRF0gRGV2aWNlIFsxMDIyOjc4MDddIChyZXYgMTEpCjAwOjEyLjIgVVNCIENv
bnRyb2xsZXIgWzBjMDNdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzIFtBTURdIERldmljZSBbMTAy
Mjo3ODA4XSAocmV2IDExKQowMDoxMy4wIFVTQiBDb250cm9sbGVyIFswYzAzXTogQWR2YW5jZWQg
TWljcm8gRGV2aWNlcyBbQU1EXSBEZXZpY2UgWzEwMjI6NzgwN10gKHJldiAxMSkKMDA6MTMuMiBV
U0IgQ29udHJvbGxlciBbMGMwM106IEFkdmFuY2VkIE1pY3JvIERldmljZXMgW0FNRF0gRGV2aWNl
IFsxMDIyOjc4MDhdIChyZXYgMTEpCjAwOjE0LjAgU01CdXMgWzBjMDVdOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzIFtBTURdIERldmljZSBbMTAyMjo3ODBiXSAocmV2IDE0KQowMDoxNC4xIElERSBp
bnRlcmZhY2UgWzAxMDFdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzIFtBTURdIERldmljZSBbMTAy
Mjo3ODBjXQowMDoxNC4yIEF1ZGlvIGRldmljZSBbMDQwM106IEFkdmFuY2VkIE1pY3JvIERldmlj
ZXMgW0FNRF0gRGV2aWNlIFsxMDIyOjc4MGRdIChyZXYgMDEpCjAwOjE0LjMgSVNBIGJyaWRnZSBb
MDYwMV06IEFkdmFuY2VkIE1pY3JvIERldmljZXMgW0FNRF0gRGV2aWNlIFsxMDIyOjc4MGVdIChy
ZXYgMTEpCjAwOjE0LjQgUENJIGJyaWRnZSBbMDYwNF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMg
W0FNRF0gRGV2aWNlIFsxMDIyOjc4MGZdIChyZXYgNDApCjAwOjE0LjUgVVNCIENvbnRyb2xsZXIg
WzBjMDNdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzIFtBTURdIERldmljZSBbMTAyMjo3ODA5XSAo
cmV2IDExKQowMDoxNS4wIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2Vz
IFtBTURdIERldmljZSBbMTAyMjo0M2EwXQowMDoxNS4xIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZh
bmNlZCBNaWNybyBEZXZpY2VzIFtBTURdIERldmljZSBbMTAyMjo0M2ExXQowMDoxOC4wIEhvc3Qg
YnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcyBbQU1EXSBEZXZpY2UgWzEwMjI6
MTQwMF0KMDA6MTguMSBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMg
W0FNRF0gRGV2aWNlIFsxMDIyOjE0MDFdCjAwOjE4LjIgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZh
bmNlZCBNaWNybyBEZXZpY2VzIFtBTURdIERldmljZSBbMTAyMjoxNDAyXQowMDoxOC4zIEhvc3Qg
YnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcyBbQU1EXSBEZXZpY2UgWzEwMjI6
MTQwM10KMDA6MTguNCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMg
W0FNRF0gRGV2aWNlIFsxMDIyOjE0MDRdCjAwOjE4LjUgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZh
bmNlZCBNaWNybyBEZXZpY2VzIFtBTURdIERldmljZSBbMTAyMjoxNDA1XQowMzowMC4wIEV0aGVy
bmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQuIFJU
TDgxMTEvODE2OEIgUENJIEV4cHJlc3MgR2lnYWJpdCBFdGhlcm5ldCBjb250cm9sbGVyIFsxMGVj
OjgxNjhdIChyZXYgMDYpCg==
--001a11c28efa09e20504e3df4b02
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--001a11c28efa09e20504e3df4b02--

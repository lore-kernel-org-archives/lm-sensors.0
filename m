From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Tue, 13 Aug 2013 21:11:31 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzR50y5+1f9WY7+a=TaMAQ2fPZeVsd5GbGESWsc0RnYX5Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3947840250273226518=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3947840250273226518==
Content-Type: multipart/alternative; boundary=047d7b66fc0f5f2fe604e3daaf8f

--047d7b66fc0f5f2fe604e3daaf8f
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the response Guenter!

I put the system on load and I noticed their value hardly changes. To my
surprise, I ran a benchmark for 3 minutes and none of temp*  values changed
during execution. The highest reported temperature is always 48C.

I was expecting that the internal temperature would have "sensor = thermal
diode" or "sensor = core" as a keyword. I thought "sensor=thermistor" means
the corresponding sensor is on the motherboard and not the internal
die-sensor.

Also, I noticed something that even though I installed and inserted the
driver for f71882fg, when I run "sensor-detect", it still says that "Note:
there is no driver for Fintek F71869FG SUper IO Sensors yet". I thought the
driver name for F71869FG chip is f71882fg (as per
http://lm-sensors.org/wiki/Devices). I installed this driver from here:
http://khali.linux-fr.org/devel/lm-sensors/drivers/f71882fg/ .

I am not worried about the fan-rpm because I intentionally replaced the fan
with a custom heat sink. I mentioned that just so that you ignore those
lines;-).


Thanks,
Kapil

On Tue, Aug 13, 2013 at 4:27 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Aug 13, 2013 at 03:05:58PM -0400, Dev, Kapil wrote:
> > Hi,
> >
> > I just changed the motherboard and the processor while the hard-disk is
> the
> > same. I am trying to read the on-die temperature of the AMD A10 5700
> > processor. Based on the output of "sensors-detect" command, I
> > installed f71882fg
> > driver, but the "sensors" command doesn't seem to give me the value of
> > core-temperature. IN particular, I am getting following output from
> sensors
> > command:
> >
> >
> ----------------------------------------------------------------------------------------------------
> > f71869-isa-0e80
> > Adapter: ISA adapter
> > in0:         +1.68 V
> > in1:         +1.05 V
> > in2:         +1.21 V
> > in3:         +1.22 V
> > in4:         +1.54 V
> > in5:         +1.19 V
> > in6:         +1.19 V
> > in7:         +1.73 V
> > in8:         +1.65 V
> > fan1:          0 RPM  ALARM
> > fan2:          0 RPM  ALARM
> > fan3:          0 RPM  ALARM
> > temp1:       +31.0 C  (high = +85.0 C, hyst = +81.0 C)
> >                       (crit = +100.0 C, hyst = +96.0 C)  sensor =
> thermistor
> > temp2:       +30.0 C  (high = +85.0 C, hyst = +81.0 C)
> >                       (crit = +100.0 C, hyst = +96.0 C)  sensor =
> thermistor
> > temp3:       +48.0 C  (high = +70.0 C, hyst = +68.0 C)
> >                       (crit = +85.0 C, hyst = +83.0 C)  sensor =
> thermistor
>
> One of those three is probably from the CPU (wild guess would be temp3).
> You might be able to find a correlation by putting the system under load
> and observing temperature rises.
>
> >
> ----------------------------------------------------------------------------------------------------
> >
> > I am wondering if I have to install lm_sensors package all over again.
> > Also, I am wondering if "sensors-detect" is up-to-date to detect all
> > devices/drivers. I guess the fans' rpm readings are 0 because I am using
> a
> > custom liquid-based cooling system  instead of regular fan.
> >
> If nothing turns it can't measure rpm ...
>
> Guenter
>

--047d7b66fc0f5f2fe604e3daaf8f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the response Guenter!<div><br></div><div>I put the system on loa=
d and I noticed their value hardly changes. To my surprise, I ran a benchma=
rk for 3 minutes and none of temp* =A0values changed during execution. The =
highest reported temperature is always 48C.=A0<div>
<br></div><div>I was expecting that the internal temperature would have &qu=
ot;sensor =3D thermal diode&quot; or &quot;sensor =3D core&quot; as a keywo=
rd. I thought &quot;sensor=3Dthermistor&quot; means the corresponding senso=
r is on the motherboard and not the internal die-sensor.<div>
<br></div><div>Also, I noticed something that even though I installed and i=
nserted the driver for f71882fg, when I run &quot;sensor-detect&quot;, it s=
till says that &quot;Note: there is no driver for Fintek F71869FG SUper IO =
Sensors yet&quot;. I thought the driver name for F71869FG chip is f71882fg =
(as per=A0<a href=3D"http://lm-sensors.org/wiki/Devices">http://lm-sensors.=
org/wiki/Devices</a>). I installed this driver from here:=A0<a href=3D"http=
://khali.linux-fr.org/devel/lm-sensors/drivers/f71882fg/">http://khali.linu=
x-fr.org/devel/lm-sensors/drivers/f71882fg/</a>=A0.</div>
<div><br></div><div>I am not worried about the fan-rpm because I intentiona=
lly replaced the fan with a custom heat sink. I mentioned that just so that=
 you ignore those lines;-).</div><div><br></div><div><br></div><div>Thanks,=
</div>
<div>Kapil<br><div><br><div class=3D"gmail_quote">On Tue, Aug 13, 2013 at 4=
:27 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-u=
s.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Tue, Aug 13, 2013 at 03:05:58PM =
-0400, Dev, Kapil wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I just changed the motherboard and the processor while the hard-disk i=
s the<br>
&gt; same. I am trying to read the on-die temperature of the AMD A10 5700<b=
r>
&gt; processor. Based on the output of &quot;sensors-detect&quot; command, =
I<br>
&gt; installed f71882fg<br>
&gt; driver, but the &quot;sensors&quot; command doesn&#39;t seem to give m=
e the value of<br>
&gt; core-temperature. IN particular, I am getting following output from se=
nsors<br>
&gt; command:<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
------------------------------<br>
&gt; f71869-isa-0e80<br>
&gt; Adapter: ISA adapter<br>
&gt; in0: =A0 =A0 =A0 =A0 +1.68 V<br>
&gt; in1: =A0 =A0 =A0 =A0 +1.05 V<br>
&gt; in2: =A0 =A0 =A0 =A0 +1.21 V<br>
&gt; in3: =A0 =A0 =A0 =A0 +1.22 V<br>
&gt; in4: =A0 =A0 =A0 =A0 +1.54 V<br>
&gt; in5: =A0 =A0 =A0 =A0 +1.19 V<br>
&gt; in6: =A0 =A0 =A0 =A0 +1.19 V<br>
&gt; in7: =A0 =A0 =A0 =A0 +1.73 V<br>
&gt; in8: =A0 =A0 =A0 =A0 +1.65 V<br>
&gt; fan1: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; fan2: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; fan3: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM<br>
&gt; temp1: =A0 =A0 =A0 +31.0 C =A0(high =3D +85.0 C, hyst =3D +81.0 C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =
=3D +96.0 C) =A0sensor =3D thermistor<br>
&gt; temp2: =A0 =A0 =A0 +30.0 C =A0(high =3D +85.0 C, hyst =3D +81.0 C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =
=3D +96.0 C) =A0sensor =3D thermistor<br>
&gt; temp3: =A0 =A0 =A0 +48.0 C =A0(high =3D +70.0 C, hyst =3D +68.0 C)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +85.0 C, hyst =
=3D +83.0 C) =A0sensor =3D thermistor<br>
<br>
</div></div>One of those three is probably from the CPU (wild guess would b=
e temp3).<br>
You might be able to find a correlation by putting the system under load<br=
>
and observing temperature rises.<br>
<div class=3D"im"><br>
&gt; ----------------------------------------------------------------------=
------------------------------<br>
&gt;<br>
&gt; I am wondering if I have to install lm_sensors package all over again.=
<br>
&gt; Also, I am wondering if &quot;sensors-detect&quot; is up-to-date to de=
tect all<br>
&gt; devices/drivers. I guess the fans&#39; rpm readings are 0 because I am=
 using a<br>
&gt; custom liquid-based cooling system =A0instead of regular fan.<br>
&gt;<br>
</div>If nothing turns it can&#39;t measure rpm ...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div></div></div></div>

--047d7b66fc0f5f2fe604e3daaf8f--


--===============3947840250273226518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3947840250273226518==--

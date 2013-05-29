From: Robert Coulson <rob.coulson@gmail.com>
Date: Wed, 29 May 2013 23:09:46 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (ds1621): Update ds1621 device information
Message-Id: <CAEZKy8LxLZNrAMuV6FoC1A4Qt_ecSw6AgRa775EHOp8UEovLbA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4887989520358651120=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1369785362-19133-3-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1369785362-19133-3-git-send-email-rob.coulson@gmail.com>
To: lm-sensors@vger.kernel.org

--===============4887989520358651120==
Content-Type: multipart/alternative; boundary=089e013a1dac5b65c504dde37a30

--089e013a1dac5b65c504dde37a30
Content-Type: text/plain; charset=ISO-8859-1

On Tue, May 28, 2013 at 8:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, May 28, 2013 at 04:56:02PM -0700, Robert Coulson wrote:
> > Replace some written information with tables to improve the readability
> and
> > for adding newer devices in the future.
> >
> > Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
> > ---
> >  Documentation/hwmon/ds1621 |   82
> ++++++++++++++++++++++++--------------------
> >  1 file changed, 44 insertions(+), 38 deletions(-)
> >
> > diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
> > index 64ee39f..e70a575 100644
> > --- a/Documentation/hwmon/ds1621
> > +++ b/Documentation/hwmon/ds1621
> > @@ -73,13 +73,6 @@ any of the limits have ever been met or exceeded
> since last power-up or
> >  reset. Be aware: When testing, it showed that the status of Tout can
> change
> >  with neither of the alarms set.
> >
> > -Temperature conversion of the DS1621 takes up to 1000ms; internal
> access to
> > -non-volatile registers may last for 10ms or below.
> > -
> > -The DS1625 is pin compatible and functionally equivalent with the
> DS1621,
> > -but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are
> also
> > -pin compatible with the DS1621, but provide multi-resolution support.
> > -
> >  Since there is no version or vendor identification register, there is
> >  no unique identification for these devices. Therefore, explicit device
> >  instantiation is required for correct device identification and
> functionality.
> > @@ -88,37 +81,50 @@ And, for correct identification and operation, each
> device must be
> >  explicitly instantiated, one device per address, in this address
> >  range: 0x48..0x4f.
> >
> > -The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
> > -degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
> > -default setting of 75 and 80 degrees respectifully, and a maximum
> conversion
> > -time of 750ms.
> > -
> > -In addition, the DS1721 supports four resolution settings from 9 to 12
> bits
> > -(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625,
> respectifully),
> > -that are set at device power on to the highest resolution: 12-bits.
> > -
> > -One additional note about the ds1721 is that although the data sheet
> says
> > -the temperature flags (THF and TLF) are used internally, these flags do
> > -get set and cleared as the actual temperature crosses the min or max
> settings.
> > -
> > -The DS1631 and DS1731 are pin compatible with the DS1621 and feature
> compatible
> > -with the DS1721, however, the DS1631 accuracy is +/- 0.5 degree Celius
> over
> > -the 0 to +70 degrees, while the DS1731 accuracy is +/-1 degree Celius
> over the
> > --10 to +85 degree range.
> > -
> > -Changing the DS1631, DS1721, or DS1731 resolution mode affects the
> conversion
> > -time and can be done from userspace, via the device 'update_interval'
> sysfs
> > -attribute. This attribute will normalize range of input values to the
> device
> > -maximum resolution values defined in the datasheet as such:
> > -
> > -Resolution    Conversion Time    Input Range
> > - (C/LSB)       (msec)             (msec)
> > ---------------------------------------------
> > -0.5             93.75              0....94
> > -0.25            187.5              95...187
> > -0.125           375                188..375
> > -0.0625          750                376..infinity
> > ---------------------------------------
> > +The DS1625 is pin compatible and functionally equivalent with the
> DS1621,
> > +but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are
> > +also pin compatible with the DS1621, but provide multi-resolution
> support.
> > +
> > +Additionally, the DS1721 data sheet says the temperature flags (THF and
> TLF)
> > +are used internally, however, these flags do get set and cleared as the
> actual
>
>         ... internally. However ...
>

agreed.


>
> > +temperature crosses the min or max settings (which by default are set
> to 75
> > +and 80 degrees respectifully).
> > +
>
> s/respectifully/respectively/ (I believe, as it means "separately or
> individually
> and in the order already mentioned" vs. "Showing or marked by proper
> respect"
> for respectfully.
>

agreed.

As you can see, my technical writing skills need improving. (-;

>
> > +Temperature Conversion:
> > +-----------------------
> > +DS1621 - 750ms (older devices may take upto 1000ms)
>
> s/upto/up to/
>
> > +DS1625 - 500ms
> > +DS1631 - 93ms..750ms for 9..12 bits resolution, respectifully.
> > +DS1721 - 93ms..750ms for 9..12 bits resolution, respectifully.
> > +DS1731 - 93ms..750ms for 9..12 bits resolution, respectifully.
> > +
>
>         respectively ?
>

yes.


>
> > +Note:
> > +On the DS1621, internal access to non-volatile registers may last for
> 10ms
> > +or below (unverified on the other devices).
> > +
>
> or less ?
>

agreed.


>
> > +Temperature Accuracy:
> > +----------------------
> > +DS1621: +/- 0.5 degree Celius over 0 to +70 degree range
> > +DS1625: +/- 0.5 degree Celius over 0 to +70 degree range
> > +DS1631: +/- 0.5 degree Celius over 0 to +70 degree range
> > +DS1721: +/- 1.0 degree Celius over -10 to +85 degree range
> > +DS1731: +/- 1.0 degree Celius over -10 to +85 degree range
> > +
> > +Note:
> > +Please refer to the device datasheet for accuracy over other ranges.
> > +
>         datasheet -> datasheets
>

agreed...Also, s/over/within


>
> > +Temperature Resolution:
> > +-----------------------
> > +As mentioned above, the DS1631, DS1721, & DS1731 provide
> multi-resolution
> > +support, which is achieved via the R0 and R1 config register bits,
> where:
> > +
> > +R0..R1
> > +------
> > + 0  0 => 9 bits, 0.5 degrees Celcius
> > + 1  0 => 10 bits, 0.25 degrees Celcius
> > + 0  1 => 11 bits, 0.125 degrees Celcius
> > + 1  1 => 12 bits, 0.0625 degrees Celcius
> > +{At device power, the default resolution is set to 12-bits}
> >
> device poweron ?
>

agreed.


>
> I would write "At device poweron, the default resolution is set to
> 12-bits."
> with an empty line after 1 / 1.
>

agreed. good catch on the missed extra line.


>
> >  The following examples show how the 'update_interval' attribute can be
> >  used to change the conversion time:
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
>

--089e013a1dac5b65c504dde37a30
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, May 28, 2013 at 8:02 PM, Guenter Roeck <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a=
>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, May 28, 2013 at 04:56:02PM -0700, Robert Coulson wrote:<br>
&gt; Replace some written information with tables to improve the readabilit=
y and<br>
&gt; for adding newer devices in the future.<br>
&gt;<br>
&gt; Signed-off-by: Robert Coulson &lt;<a href=3D"mailto:rob.coulson@gmail.=
com">rob.coulson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0Documentation/hwmon/ds1621 | =A0 82 ++++++++++++++++++++++++-------=
-------------<br>
&gt; =A01 file changed, 44 insertions(+), 38 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621<b=
r>
&gt; index 64ee39f..e70a575 100644<br>
&gt; --- a/Documentation/hwmon/ds1621<br>
&gt; +++ b/Documentation/hwmon/ds1621<br>
&gt; @@ -73,13 +73,6 @@ any of the limits have ever been met or exceeded si=
nce last power-up or<br>
&gt; =A0reset. Be aware: When testing, it showed that the status of Tout ca=
n change<br>
&gt; =A0with neither of the alarms set.<br>
&gt;<br>
&gt; -Temperature conversion of the DS1621 takes up to 1000ms; internal acc=
ess to<br>
&gt; -non-volatile registers may last for 10ms or below.<br>
&gt; -<br>
&gt; -The DS1625 is pin compatible and functionally equivalent with the DS1=
621,<br>
&gt; -but the DS1621 is meant to replace it. The DS1631, DS1721, &amp; DS17=
31 are also<br>
&gt; -pin compatible with the DS1621, but provide multi-resolution support.=
<br>
&gt; -<br>
&gt; =A0Since there is no version or vendor identification register, there =
is<br>
&gt; =A0no unique identification for these devices. Therefore, explicit dev=
ice<br>
&gt; =A0instantiation is required for correct device identification and fun=
ctionality.<br>
&gt; @@ -88,37 +81,50 @@ And, for correct identification and operation, eac=
h device must be<br>
&gt; =A0explicitly instantiated, one device per address, in this address<br=
>
&gt; =A0range: 0x48..0x4f.<br>
&gt;<br>
&gt; -The DS1721 is pin compatible with the DS1621, has an accuracy of +/- =
1.0<br>
&gt; -degree Celius over a -10 to +85 degree range, a minimum/maximum alarm=
<br>
&gt; -default setting of 75 and 80 degrees respectifully, and a maximum con=
version<br>
&gt; -time of 750ms.<br>
&gt; -<br>
&gt; -In addition, the DS1721 supports four resolution settings from 9 to 1=
2 bits<br>
&gt; -(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respecti=
fully),<br>
&gt; -that are set at device power on to the highest resolution: 12-bits.<b=
r>
&gt; -<br>
&gt; -One additional note about the ds1721 is that although the data sheet =
says<br>
&gt; -the temperature flags (THF and TLF) are used internally, these flags =
do<br>
&gt; -get set and cleared as the actual temperature crosses the min or max =
settings.<br>
&gt; -<br>
&gt; -The DS1631 and DS1731 are pin compatible with the DS1621 and feature =
compatible<br>
&gt; -with the DS1721, however, the DS1631 accuracy is +/- 0.5 degree Celiu=
s over<br>
&gt; -the 0 to +70 degrees, while the DS1731 accuracy is +/-1 degree Celius=
 over the<br>
&gt; --10 to +85 degree range.<br>
&gt; -<br>
&gt; -Changing the DS1631, DS1721, or DS1731 resolution mode affects the co=
nversion<br>
&gt; -time and can be done from userspace, via the device &#39;update_inter=
val&#39; sysfs<br>
&gt; -attribute. This attribute will normalize range of input values to the=
 device<br>
&gt; -maximum resolution values defined in the datasheet as such:<br>
&gt; -<br>
&gt; -Resolution =A0 =A0Conversion Time =A0 =A0Input Range<br>
&gt; - (C/LSB) =A0 =A0 =A0 (msec) =A0 =A0 =A0 =A0 =A0 =A0 (msec)<br>
&gt; ---------------------------------------------<br>
&gt; -0.5 =A0 =A0 =A0 =A0 =A0 =A0 93.75 =A0 =A0 =A0 =A0 =A0 =A0 =A00....94<=
br>
&gt; -0.25 =A0 =A0 =A0 =A0 =A0 =A0187.5 =A0 =A0 =A0 =A0 =A0 =A0 =A095...187=
<br>
&gt; -0.125 =A0 =A0 =A0 =A0 =A0 375 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0188..375=
<br>
&gt; -0.0625 =A0 =A0 =A0 =A0 =A0750 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0376..inf=
inity<br>
&gt; ---------------------------------------<br>
&gt; +The DS1625 is pin compatible and functionally equivalent with the DS1=
621,<br>
&gt; +but the DS1621 is meant to replace it. The DS1631, DS1721, &amp; DS17=
31 are<br>
&gt; +also pin compatible with the DS1621, but provide multi-resolution sup=
port.<br>
&gt; +<br>
&gt; +Additionally, the DS1721 data sheet says the temperature flags (THF a=
nd TLF)<br>
&gt; +are used internally, however, these flags do get set and cleared as t=
he actual<br>
<br>
</div></div>=A0 =A0 =A0 =A0 ... internally. However ...<br></blockquote><di=
v><br></div><div style>agreed.</div><div style>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

<div class=3D"im"><br>
&gt; +temperature crosses the min or max settings (which by default are set=
 to 75<br>
&gt; +and 80 degrees respectifully).<br>
&gt; +<br>
<br>
</div>s/respectifully/respectively/ (I believe, as it means &quot;separatel=
y or individually<br>
and in the order already mentioned&quot; vs. &quot;Showing or marked by pro=
per respect&quot;<br>
for respectfully.<br></blockquote><div><br></div><div style>agreed.</div><d=
iv style><br></div><div style>As you can see, my technical writing skills n=
eed improving. (-;</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im"><br>
&gt; +Temperature Conversion:<br>
&gt; +-----------------------<br>
&gt; +DS1621 - 750ms (older devices may take upto 1000ms)<br>
<br>
</div>s/upto/up to/<br>
<div class=3D"im"><br>
&gt; +DS1625 - 500ms<br>
&gt; +DS1631 - 93ms..750ms for 9..12 bits resolution, respectifully.<br>
&gt; +DS1721 - 93ms..750ms for 9..12 bits resolution, respectifully.<br>
&gt; +DS1731 - 93ms..750ms for 9..12 bits resolution, respectifully.<br>
&gt; +<br>
<br>
</div>=A0 =A0 =A0 =A0 respectively ?<br></blockquote><div><br></div><div st=
yle>yes.</div><div style>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><br>
&gt; +Note:<br>
&gt; +On the DS1621, internal access to non-volatile registers may last for=
 10ms<br>
&gt; +or below (unverified on the other devices).<br>
&gt; +<br>
<br>
</div>or less ?<br></blockquote><div><br></div><div style>agreed.</div><div=
 style>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><br>
&gt; +Temperature Accuracy:<br>
&gt; +----------------------<br>
&gt; +DS1621: +/- 0.5 degree Celius over 0 to +70 degree range<br>
&gt; +DS1625: +/- 0.5 degree Celius over 0 to +70 degree range<br>
&gt; +DS1631: +/- 0.5 degree Celius over 0 to +70 degree range<br>
&gt; +DS1721: +/- 1.0 degree Celius over -10 to +85 degree range<br>
&gt; +DS1731: +/- 1.0 degree Celius over -10 to +85 degree range<br>
&gt; +<br>
&gt; +Note:<br>
&gt; +Please refer to the device datasheet for accuracy over other ranges.<=
br>
&gt; +<br>
</div>=A0 =A0 =A0 =A0 datasheet -&gt; datasheets<br></blockquote><div><br><=
/div><div style>agreed...Also, s/over/within</div><div style>=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">

<div class=3D"im"><br>
&gt; +Temperature Resolution:<br>
&gt; +-----------------------<br>
&gt; +As mentioned above, the DS1631, DS1721, &amp; DS1731 provide multi-re=
solution<br>
&gt; +support, which is achieved via the R0 and R1 config register bits, wh=
ere:<br>
&gt; +<br>
&gt; +R0..R1<br>
&gt; +------<br>
&gt; + 0 =A00 =3D&gt; 9 bits, 0.5 degrees Celcius<br>
&gt; + 1 =A00 =3D&gt; 10 bits, 0.25 degrees Celcius<br>
&gt; + 0 =A01 =3D&gt; 11 bits, 0.125 degrees Celcius<br>
&gt; + 1 =A01 =3D&gt; 12 bits, 0.0625 degrees Celcius<br>
&gt; +{At device power, the default resolution is set to 12-bits}<br>
&gt;<br>
</div>device poweron ?<br></blockquote><div><br></div><div style>agreed.</d=
iv><div style>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
I would write &quot;At device poweron, the default resolution is set to 12-=
bits.&quot;<br>
with an empty line after 1 / 1.<br></blockquote><div><br></div><div style>a=
greed. good catch on the missed extra line.</div><div style>=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; =A0The following examples show how the &#39;update_interval&#39; attri=
bute can be<br>
&gt; =A0used to change the conversion time:<br>
&gt; --<br>
&gt; 1.7.9.5<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lm-sensors mailing list<br>
&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org=
</a><br>
&gt; <a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" ta=
rget=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a>=
<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--089e013a1dac5b65c504dde37a30--


--===============4887989520358651120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4887989520358651120==--

From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Mon, 16 Jul 2007 22:19:04 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C8320A5@orca.penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7C7F7.5181AC1C"
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============9088171502961478393==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C7F7.5181AC1C"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7C7F7.5181AC1C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The values 0x81 and 0x7f are *signed* 8 bit quantities.  0x81 whould be =
considered -127

:v)

--=20
Philip Pokorny, RHCE
Director of Field Engineering=20
Penguin Computing  http://www.penguincomputing.com

 -----Original Message-----
From: 	Darrick J. Wong [mailto:djwong@us.ibm.com]
Sent:	Monday, July 16, 2007 01:21 PM Pacific Standard Time
To:	Vadim Zeitlin
Cc:	lm-sensors@lm-sensors.org
Subject:	Re: [lm-sensors] [PATCH] First cut of a adt7470 driver

On Sat, Jul 14, 2007 at 04:23:16PM +0200, Vadim Zeitlin wrote:
>  The first thing I noticed is that accessing any of them takes almost =
3
> seconds:
>=20
> # time cat fan1_input
> 2001
> cat fan1_input  0.00s user 0.00s system 0% cpu 2.760 total

Hm.... I see this with the v3 patch:
root@elm3a181:/usr/local/src/lm_sensors-2.10.3/prog# time cat
/sys/class/hwmon/hwmon0/device/temp1_input=20
47000

real    0m1.701s
user    0m0.000s
sys     0m0.000s

Not sure why it takes 700ms to read the sensors after the 1s sleep,
perhaps that could just be the cost of reading the registers?  (I'd hope
not...)

> I wonder if this is normal? I see a 1 sec sleep in =
adt7470_update_device()
> but the delay happens not only for the temperatures and it's also much
> bigger than 1 second.
>=20
>  Next, the fan speed detection seems to work as expected, i.e. the =
number
> it gives (like 2000 above) seem to be RPM. But reading the temperature
> files produces strange results:
>=20
> # grep . temp?_input
> temp1_input:0
> temp2_input:228000
> temp3_input:59000
> temp4_input:54000
> temp5_input:226000
> temp6_input:228000
> temp7_input:58000
> temp8_input:54000
> temp9_input:49000
>=20
> Again, I see the factor of 1000 in adt7470.c and, accounting for it, =
all

Documentation/hwmon/sysfs-interface says that the units for temperatures
are millidegrees C, hence the 1000 factor both here and for the pwm
controls below.

> numbers except 227000 may be correct -- but what about those latter =
ones?
> To confuse the matters (or at least me) further, temp_min files =
contain
> 129000 while temp_max files have 127000 (no typo) so something seems =
wrong

Mine are programmed like that too.  I suppose it's possible that the
datasheet could be wrong?  Page 14 of the adt7470 datasheet says that
the default temp low limit is 0x81 and the default temp high limit is
0x7F.  Weird...unless I'm misinterpreting the data sheet?

> here... At the very least, the factor of 1000 seems to be unnecessary:
>=20
> # grep . pwm1*
> pwm1:0
> pwm1_auto_channels_temp:1023
> pwm1_auto_point1_pwm:128
> pwm1_auto_point1_temp:90000
> pwm1_auto_point2_pwm:255
> pwm1_auto_point2_temp:110000
> pwm1_enable:2
>=20
> The values here clearly should be 90 and 110 degrees, shouldn't they?

(See above)

--D

------_=_NextPart_001_01C7C7F7.5181AC1C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<TITLE>Re: [lm-sensors] [PATCH] First cut of a adt7470 driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>The values 0x81 and 0x7f are *signed* 8 bit =
quantities.&nbsp; 0x81 whould be considered -127<BR>
<BR>
:v)<BR>
<BR>
--<BR>
Philip Pokorny, RHCE<BR>
Director of Field Engineering<BR>
Penguin Computing&nbsp; <A =
HREF=3D"http://www.penguincomputing.com">http://www.penguincomputing.com<=
/A><BR>
<BR>
&nbsp;-----Original Message-----<BR>
From: &nbsp; Darrick J. Wong [<A =
HREF=3D"mailto:djwong@us.ibm.com">mailto:djwong@us.ibm.com</A>]<BR>
Sent:&nbsp;&nbsp; Monday, July 16, 2007 01:21 PM Pacific Standard =
Time<BR>
To:&nbsp;&nbsp;&nbsp;&nbsp; Vadim Zeitlin<BR>
Cc:&nbsp;&nbsp;&nbsp;&nbsp; lm-sensors@lm-sensors.org<BR>
Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Re: [lm-sensors] =
[PATCH] First cut of a adt7470 driver<BR>
<BR>
On Sat, Jul 14, 2007 at 04:23:16PM +0200, Vadim Zeitlin wrote:<BR>
&gt;&nbsp; The first thing I noticed is that accessing any of them takes =
almost 3<BR>
&gt; seconds:<BR>
&gt;<BR>
&gt; # time cat fan1_input<BR>
&gt; 2001<BR>
&gt; cat fan1_input&nbsp; 0.00s user 0.00s system 0% cpu 2.760 total<BR>
<BR>
Hm.... I see this with the v3 patch:<BR>
root@elm3a181:/usr/local/src/lm_sensors-2.10.3/prog# time cat<BR>
/sys/class/hwmon/hwmon0/device/temp1_input<BR>
47000<BR>
<BR>
real&nbsp;&nbsp;&nbsp; 0m1.701s<BR>
user&nbsp;&nbsp;&nbsp; 0m0.000s<BR>
sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.000s<BR>
<BR>
Not sure why it takes 700ms to read the sensors after the 1s sleep,<BR>
perhaps that could just be the cost of reading the registers?&nbsp; (I'd =
hope<BR>
not...)<BR>
<BR>
&gt; I wonder if this is normal? I see a 1 sec sleep in =
adt7470_update_device()<BR>
&gt; but the delay happens not only for the temperatures and it's also =
much<BR>
&gt; bigger than 1 second.<BR>
&gt;<BR>
&gt;&nbsp; Next, the fan speed detection seems to work as expected, i.e. =
the number<BR>
&gt; it gives (like 2000 above) seem to be RPM. But reading the =
temperature<BR>
&gt; files produces strange results:<BR>
&gt;<BR>
&gt; # grep . temp?_input<BR>
&gt; temp1_input:0<BR>
&gt; temp2_input:228000<BR>
&gt; temp3_input:59000<BR>
&gt; temp4_input:54000<BR>
&gt; temp5_input:226000<BR>
&gt; temp6_input:228000<BR>
&gt; temp7_input:58000<BR>
&gt; temp8_input:54000<BR>
&gt; temp9_input:49000<BR>
&gt;<BR>
&gt; Again, I see the factor of 1000 in adt7470.c and, accounting for =
it, all<BR>
<BR>
Documentation/hwmon/sysfs-interface says that the units for =
temperatures<BR>
are millidegrees C, hence the 1000 factor both here and for the pwm<BR>
controls below.<BR>
<BR>
&gt; numbers except 227000 may be correct -- but what about those latter =
ones?<BR>
&gt; To confuse the matters (or at least me) further, temp_min files =
contain<BR>
&gt; 129000 while temp_max files have 127000 (no typo) so something =
seems wrong<BR>
<BR>
Mine are programmed like that too.&nbsp; I suppose it's possible that =
the<BR>
datasheet could be wrong?&nbsp; Page 14 of the adt7470 datasheet says =
that<BR>
the default temp low limit is 0x81 and the default temp high limit =
is<BR>
0x7F.&nbsp; Weird...unless I'm misinterpreting the data sheet?<BR>
<BR>
&gt; here... At the very least, the factor of 1000 seems to be =
unnecessary:<BR>
&gt;<BR>
&gt; # grep . pwm1*<BR>
&gt; pwm1:0<BR>
&gt; pwm1_auto_channels_temp:1023<BR>
&gt; pwm1_auto_point1_pwm:128<BR>
&gt; pwm1_auto_point1_temp:90000<BR>
&gt; pwm1_auto_point2_pwm:255<BR>
&gt; pwm1_auto_point2_temp:110000<BR>
&gt; pwm1_enable:2<BR>
&gt;<BR>
&gt; The values here clearly should be 90 and 110 degrees, shouldn't =
they?<BR>
<BR>
(See above)<BR>
<BR>
--D<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7C7F7.5181AC1C--


--===============9088171502961478393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9088171502961478393==--

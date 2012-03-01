From: Vivek Bardia <bardia.vivek@gmail.com>
Date: Thu, 01 Mar 2012 04:55:35 +0000
Subject: Re: [lm-sensors] dual output buck controller pmbus based
Message-Id: <CANSBHnPZtwZJhECCe07phT1zzeAk-bsRzd1cq8fW7VbVQZgv5A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5839211078724712472=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
In-Reply-To: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5839211078724712472==
Content-Type: multipart/alternative; boundary=e89a8f23533df6d46204ba273ac8

--e89a8f23533df6d46204ba273ac8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

I still do not have any evaluation hardware.

By the way, my usage for TPS40400/TPS40422 is just output voltage control.
Have no sensors being used in my scenario.

Will you be able to comment on my below steps and its validity:

1. To get the current output I do a READ_VOUT and then convert it to
microvolts format, for e.g. finally i get 942734uV

2. To set a output voltage to say 902234 based on some requirement,
My nominal voltage being 1.1V
hence trim_offset =3D 902234 - 1100000
therefor I do: PMBUS_VOUT_TRIM with a value ffa7

Is the above logic right? my VOUT_SCALE_LOOP is
600mV/1100mV x (2^9) =3D 279.27 =3D> 100010111 =3D> *b917*

Regards,
Vivek

On 22 February 2012 09:45, Guenter Roeck <guenter.roeck@ericsson.com> wrote=
:

> On Fri, Feb 10, 2012 at 01:20:25AM -0500, Vivek Bardia wrote:
> > Hello,
> >
> > I want to know whether does the current pmbus driver support dual outpu=
t
> buck
> > controller based PMIC?
> >
> > Basically for this particular PMIC: http://goo.gl/BFwcu
> >
> > How do I test the driver for it?
> >
> Hi,
>
> I got the evaluation board for TPS40422. Here is the output from the
> sensors command
> after instantiating it as "pmbus".
>
> pmbus-i2c-0-1b
> Adapter: i2c-diolan-u2c:002
> vout1:        +1.20 V
> vout2:        +3.30 V
> temp1:        +26.0=B0C  (high =3D +100.0=B0C, crit =3D +125.0=B0C)
> iout1:        +0.31 A  (max =3D +25.00 A, crit max =3D +30.00 A)
> iout2:        +0.31 A  (max =3D +20.00 A, crit max =3D +25.00 A)
>
> Similar, for TPS40400:
>
> pmbus-i2c-0-1c
> Adapter: i2c-diolan-u2c:002
> vin:         +11.59 V
> vout1:        +1.16 V  (crit min =3D  +1.14 V, crit max =3D  +1.26 V)
> iout1:        +0.50 A  (max =3D +29.00 A, crit max =3D +30.00 A)
>
> Overall pretty good for generic detection. Only problem (or, rather,
> limitation)
> with TPS40422 is that the auto-detection code does not support paged
> temperature
> registers, and thus only a single temperature is reported.
>
> Did you have a chance to test it yourself ?
>
> Thanks,
> Guenter
>

--e89a8f23533df6d46204ba273ac8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi=A0Guenter,<div><br></div><div>I still do not have any evaluation hardwar=
e.</div><div><br></div><div>By the way, my usage for TPS40400/TPS40422 is j=
ust output voltage control. Have no sensors being used in my scenario.</div=
>
<div><br></div><div>Will you be able to comment on my below steps and its v=
alidity:</div><div><br></div><div>1. To get the current output I do a READ_=
VOUT and then convert it to microvolts format, for e.g. finally i get=A0942=
734uV</div>
<div><br></div><div>2. To set a output voltage to say 902234 based on some =
requirement,=A0</div><div>My nominal voltage being 1.1V</div><div>hence tri=
m_offset =3D 902234 - 1100000</div><div>therefor I do:=A0PMBUS_VOUT_TRIM wi=
th a value ffa7</div>
<div><br></div><div>Is the above logic right? my VOUT_SCALE_LOOP is=A0</div=
><div>600mV/1100mV x (2^9) =3D 279.27 =3D&gt; 100010111 =3D&gt; <b>b917</b>=
</div><div><br></div><div>Regards,<br>Vivek<br><br><div class=3D"gmail_quot=
e">On 22 February 2012 09:45, Guenter Roeck <span dir=3D"ltr">&lt;<a href=
=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, Feb 10, 2012 at 01=
:20:25AM -0500, Vivek Bardia wrote:<br>
</div><div><div class=3D"h5">&gt; Hello,<br>
&gt;<br>
&gt; I want to know whether does the current pmbus driver support dual outp=
ut buck<br>
&gt; controller based PMIC?<br>
&gt;<br>
&gt; Basically for this particular PMIC: <a href=3D"http://goo.gl/BFwcu" ta=
rget=3D"_blank">http://goo.gl/BFwcu</a><br>
&gt;<br>
&gt; How do I test the driver for it?<br>
&gt;<br>
</div></div>Hi,<br>
<br>
I got the evaluation board for TPS40422. Here is the output from the sensor=
s command<br>
after instantiating it as &quot;pmbus&quot;.<br>
<br>
pmbus-i2c-0-1b<br>
Adapter: i2c-diolan-u2c:002<br>
vout1: =A0 =A0 =A0 =A0+1.20 V<br>
vout2: =A0 =A0 =A0 =A0+3.30 V<br>
temp1: =A0 =A0 =A0 =A0+26.0=B0C =A0(high =3D +100.0=B0C, crit =3D +125.0=B0=
C)<br>
iout1: =A0 =A0 =A0 =A0+0.31 A =A0(max =3D +25.00 A, crit max =3D +30.00 A)<=
br>
iout2: =A0 =A0 =A0 =A0+0.31 A =A0(max =3D +20.00 A, crit max =3D +25.00 A)<=
br>
<br>
Similar, for TPS40400:<br>
<br>
pmbus-i2c-0-1c<br>
Adapter: i2c-diolan-u2c:002<br>
vin: =A0 =A0 =A0 =A0 +11.59 V<br>
vout1: =A0 =A0 =A0 =A0+1.16 V =A0(crit min =3D =A0+1.14 V, crit max =3D =A0=
+1.26 V)<br>
iout1: =A0 =A0 =A0 =A0+0.50 A =A0(max =3D +29.00 A, crit max =3D +30.00 A)<=
br>
<br>
Overall pretty good for generic detection. Only problem (or, rather, limita=
tion)<br>
with TPS40422 is that the auto-detection code does not support paged temper=
ature<br>
registers, and thus only a single temperature is reported.<br>
<br>
Did you have a chance to test it yourself ?<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br></div>

--e89a8f23533df6d46204ba273ac8--


--===============5839211078724712472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5839211078724712472==--

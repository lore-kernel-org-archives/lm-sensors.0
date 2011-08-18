From: =?ISO-8859-1?Q?Amaury_Decr=EAme?= <amaury.decreme@gmail.com>
Date: Thu, 18 Aug 2011 08:46:55 +0000
Subject: Re: [lm-sensors] I2C Sis964 implementation
Message-Id: <CAPXEm7071uiwYQKjXvStWvCwchjvuEvZ99n-6K2Uk7ph+Uj8+w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3331879204952677304=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPXEm70awrC7bbBqS05RaGOb9RvgYbhuec65FAJz2u9Y5Rcbcg@mail.gmail.com>
In-Reply-To: <CAPXEm70awrC7bbBqS05RaGOb9RvgYbhuec65FAJz2u9Y5Rcbcg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3331879204952677304==
Content-Type: multipart/alternative; boundary=0022152d61050c1dbe04aac3aaf4

--0022152d61050c1dbe04aac3aaf4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2011 at 4:51 PM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Wed, 2011-08-10 at 23:38 -0400, Amaury Decr=EAme wrote:
> > Hello,
> >
> > I'm new to lm_sensors.
> > I've modified the original i2c Sis630 implementation by Alexander
> > Malysh to support Sis964 southbridge smbus and created a second file.
> >
> >
> > I can get the following result (with a dme1737):
> >
> > dme1737-i2c-3-2e
> > Adapter: SMBus SIS964 adapter at 10e0
> > 5VSB:         +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > Vcore:        +3.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > +3.3V:        +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > +5V:          +4.96 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > +12V:        +11.83 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > 3VSB:         +3.39 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Vbat:         +3.16 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > fan1:        1810 RPM  (min =3D    0 RPM)
> > fan2:         899 RPM  (min =3D    0 RPM)
> > fan4:           0 RPM  (min =3D    0 RPM)
> > temp1:        +40.8=B0C  (low  =3D -127.0=B0C, high =3D +59.0=B0C)
> > SIO Temp:     +43.8=B0C  (low  =3D -127.0=B0C, high =3D +59.0=B0C)
> > temp3:         +0.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> > cpu0_vid:    +1.550 V
> >
> > pwm is also working.
> >
> >
> > Please find attached my patch.
> >
> >
> > Best regards.
>
> Hi,
>
> please have a look into Documentation/hwmon/submitting-patches.
>
> Thanks,
> Guenter
>
>
>
Hi,

Thank you. I tried to follow what was written and submitted my patch to
linux-i2c
I hope everything's ok.

Thanks.
Amaury

--0022152d61050c1dbe04aac3aaf4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Aug 11, 2011 at 4:51 PM, Guenter=
 Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">=
guenter.roeck@ericsson.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex;">

<div><div></div><div class=3D"h5">On Wed, 2011-08-10 at 23:38 -0400, Amaury=
 Decr=EAme wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;m new to lm_sensors.<br>
&gt; I&#39;ve modified the original i2c Sis630 implementation by Alexander<=
br>
&gt; Malysh to support Sis964 southbridge smbus and created a second file.<=
br>
&gt;<br>
&gt;<br>
&gt; I can get the following result (with a dme1737):<br>
&gt;<br>
&gt; dme1737-i2c-3-2e<br>
&gt; Adapter: SMBus SIS964 adapter at 10e0<br>
&gt; 5VSB: =A0 =A0 =A0 =A0 +0.00 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.64=
 V)<br>
&gt; Vcore: =A0 =A0 =A0 =A0+3.00 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.99=
 V)<br>
&gt; +3.3V: =A0 =A0 =A0 =A0+3.32 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.38=
 V)<br>
&gt; +5V: =A0 =A0 =A0 =A0 =A0+4.96 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.=
64 V)<br>
&gt; +12V: =A0 =A0 =A0 =A0+11.83 V =A0(min =3D =A0+0.00 V, max =3D +15.94 V=
)<br>
&gt; 3VSB: =A0 =A0 =A0 =A0 +3.39 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.38=
 V)<br>
&gt; Vbat: =A0 =A0 =A0 =A0 +3.16 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.38=
 V)<br>
&gt; fan1: =A0 =A0 =A0 =A01810 RPM =A0(min =3D =A0 =A00 RPM)<br>
&gt; fan2: =A0 =A0 =A0 =A0 899 RPM =A0(min =3D =A0 =A00 RPM)<br>
&gt; fan4: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0 =A00 RPM)<br>
&gt; temp1: =A0 =A0 =A0 =A0+40.8=B0C =A0(low =A0=3D -127.0=B0C, high =3D +5=
9.0=B0C)<br>
&gt; SIO Temp: =A0 =A0 +43.8=B0C =A0(low =A0=3D -127.0=B0C, high =3D +59.0=
=B0C)<br>
&gt; temp3: =A0 =A0 =A0 =A0 +0.0=B0C =A0(low =A0=3D -127.0=B0C, high =3D +1=
27.0=B0C)<br>
&gt; cpu0_vid: =A0 =A0+1.550 V<br>
&gt;<br>
&gt; pwm is also working.<br>
&gt;<br>
&gt;<br>
&gt; Please find attached my patch.<br>
&gt;<br>
&gt;<br>
&gt; Best regards.<br>
<br>
</div></div>Hi,<br>
<br>
please have a look into Documentation/hwmon/submitting-patches.<br>
<br>
Thanks,<br>
<font color=3D"#888888">Guenter<br>
<br>
<br>
</font></blockquote></div><br>Hi,<br><br>Thank you. I tried to follow what =
was written and submitted my patch to linux-i2c<br>I hope everything&#39;s =
ok.<br><br>Thanks.<br>Amaury<br><br><br>

--0022152d61050c1dbe04aac3aaf4--


--===============3331879204952677304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3331879204952677304==--

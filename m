From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 03 Jan 2012 22:01:24 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/lm80.c: fixed checkpatch
Message-Id: <CACW_hTZWronustjBEF9tCrKLzy+gPj1tyNu8XPHSpj1CNbuqrg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5887847409708544179=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325602931-10126-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325602931-10126-1-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============5887847409708544179==
Content-Type: multipart/alternative; boundary=f46d042fd88a1508f204b5a6d779

--f46d042fd88a1508f204b5a6d779
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter

Thanks for the feedback.
I'll give it another stab tomorrow or so.

On kstrtol:

2012/1/3 Guenter Roeck <guenter.roeck@ericsson.com>

>
>
> >  { \
> >         int nr = to_sensor_dev_attr(attr)->index; \
> >         struct i2c_client *client = to_i2c_client(dev); \
> >         struct lm80_data *data = i2c_get_clientdata(client); \
> > -       long val = simple_strtol(buf, NULL, 10); \
> > - \
> > +       long val = kstrtol(buf, NULL, 10); \
> > +\
>
> Does this compile w/o error or warning ?
> Parameters change from simple_strtol() to kstrtol(), so this won't work,
> and I would think it should result at least in a compile warning.
>

Hm. Don't recall seeing a warning, guess I overlooked it.

Anyway, the mistake I made was that just before I fixed the lm75 file, but
there the call was to strict_strtoul. Coming here I overlooked things and
mixed up strict_strtol and simple_strtol.
Apologies for the inconvenience.

I'll change (but probably will make it a separate patch then).

Best regards, Frans

--f46d042fd88a1508f204b5a6d779
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guenter <br>
<br>
Thanks for the feedback. <br>
I&#39;ll give it another stab tomorrow or so.<br><br>On kstrtol:<br><br><di=
v class=3D"gmail_quote">2012/1/3 Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:guenter.roeck@ericsson.com" target=3D"_blank">guenter.roeck@eri=
csson.com</a>&gt;</span><br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
<div><br>
&gt; =A0{ \<br>
&gt; =A0 =A0 =A0 =A0 int nr =3D to_sensor_dev_attr(attr)-&gt;index; \<br>
&gt; =A0 =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev); \<br=
>
&gt; =A0 =A0 =A0 =A0 struct lm80_data *data =3D i2c_get_clientdata(client);=
 \<br>
&gt; - =A0 =A0 =A0 long val =3D simple_strtol(buf, NULL, 10); \<br>
&gt; - \<br>
&gt; + =A0 =A0 =A0 long val =3D kstrtol(buf, NULL, 10); \<br>
&gt; +\<br>
<br>
</div>Does this compile w/o error or warning ?<br>
Parameters change from simple_strtol() to kstrtol(), so this won&#39;t work=
,<br>
and I would think it should result at least in a compile warning.<br></bloc=
kquote></div><br>Hm. Don&#39;t recall seeing a warning, guess I overlooked =
it.<br><br>Anyway, the mistake I made was that just before I fixed the lm75=
 file, but there the call was to strict_strtoul. Coming here I overlooked t=
hings and mixed up strict_strtol and simple_strtol.<br>
Apologies for the inconvenience.<br><br>I&#39;ll change (but probably will =
make it a separate patch then).<br><br>Best regards, Frans<br><br>
<br><br>

--f46d042fd88a1508f204b5a6d779--


--===============5887847409708544179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5887847409708544179==--

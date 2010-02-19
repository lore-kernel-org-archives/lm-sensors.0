From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Date: Fri, 19 Feb 2010 18:52:42 +0000
Subject: Re: [lm-sensors] Status of Andigilog asc7621 driver submitted by
Message-Id: <3f9a31f41002191050m54d8905bn1f137d3c50ff89fa@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
In-Reply-To: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello George,

On Fri, Feb 19, 2010 at 11:24 PM, Jaswinder Singh Rajput
<jaswinderlinux@gmail.com> wrote:
>
> asc7621a-i2c-0-2e
> Adapter: SMBus I801 adapter at 2000
> in0: =A0 =A0 =A0 =A0 +1.08 V =A0(min =3D =A0+0.00 V, max =3D =A0+3.31 V)
> in1: =A0 =A0 =A0 =A0 +0.92 V =A0(min =3D =A0+0.00 V, max =3D =A0+2.99 V)
> in2: =A0 =A0 =A0 =A0 +3.19 V =A0(min =3D =A0+0.00 V, max =3D =A0+4.36 V)
> in3: =A0 =A0 =A0 =A0 +4.99 V =A0(min =3D =A0+0.00 V, max =3D =A0+6.61 V)
> in4: =A0 =A0 =A0 =A0+12.00 V =A0(min =3D =A0+0.00 V, max =3D +15.94 V)
> fan1: =A0 =A0 =A0 =A0947 RPM =A0(min =3D =A0 =A00 RPM)
> fan2: =A0 =A0 =A0 2425 RPM =A0(min =3D =A0 =A00 RPM)
> fan3: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM)
> fan4: =A0 =A0 =A0 =A0625 RPM =A0(min =3D =A0 =A00 RPM)
> temp1: =A0 =A0 =A0 -57.8=B0C =A0(low =A0=3D -127.0=B0C, high =3D =A0+0.0=
=B0C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D -17.0=B0C)
> temp2: =A0 =A0 =A0 +35.5=B0C =A0(low =A0=3D -127.0=B0C, high =3D +127.0=
=B0C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +65.0=B0C)
> temp3: =A0 =A0 =A0 +42.0=B0C =A0(low =A0=3D -127.0=B0C, high =3D +127.0=
=B0C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +65.0=B0C)
> temp4: =A0 =A0 =A0 +52.0=B0C =A0(low =A0=3D -127.0=B0C, high =3D +127.0=
=B0C)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(crit =3D +103.0=B0C)
> temp5: =A0 =A0 =A0 -58.0=B0C
> temp6: =A0 =A0 =A0 -84.5=B0C
> temp7: =A0 =A0 =A0 +96.2=B0C
> temp8: =A0 =A0 =A0+118.5=B0C
>

I did further investigations and noticed that in my case : temp1 temp5 and =
temp6, temp7 and temp8 are false readings which never
changes :

temp1:       -33.0=B0C  (low  =3D -127.0=B0C, high =3D  +0.0=B0C)
                      (crit =3D -17.0=B0C)
temp2:       +38.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                      (crit =3D +65.0=B0C)
temp3:       +51.8=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                      (crit =3D +65.0=B0C)
temp4:       +55.5=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                      (crit =3D +103.0=B0C)
temp5:       -33.0=B0C
temp6:       -84.5=B0C
temp7:       +96.2=B0C
temp8:      +118.5=B0C

Can you give me some hint why temp6, temp7 and temp8 are showing wrong
value for Intel WX58BP with Core i7.

Can you share your temp6, temp7 and temp8 readings.

Thanks,
--
Jaswinder Singh.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

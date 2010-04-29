From: Dmitry Gromov <gromovd@gmail.com>
Date: Thu, 29 Apr 2010 05:54:32 +0000
Subject: Re: [lm-sensors] Intel Atom thermal sensors
Message-Id: <s2se21d97a51004282254y55b6e80ao8d5447ec8c317376@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
In-Reply-To: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi!

I was able to answer most of my questions reading lm85 document,
source and .adt7468 specifications document.

And Atom thermal sensors should be available in Ubuntu 10.04, which is
coming out hopefully today...

Now the last (for now) question I have is about fan speed...
I see it sometimes reported as 675000 RPM
I found this closed ticket: http://www.lm-sensors.org/ticket/2179 and
also read fan-divisors document, but it is still not clear to me what
I need to do to get correct speed reading... I guess, I need to
increase fan divisor?

Thanks,
Dmitry

On Tue, Apr 27, 2010 at 15:47, Dmitry Gromov <gromovd@gmail.com> wrote:
> Hello.
>
> Thank you for such great tool as lm_sensors package!
>
> I'm a bit new to it and recently bought MSI Wind Nettop PC - small barebo=
ne
> on intel Atom N330.
> I'm using it with Ubuntu server 9.10 64 bit, trying to make a small home
> NAS.
>
> When I first installed lm_sensors package it was version 3.0.2 - it had
> problem loading lm85 module despite correctly identifying adt7468 chip. T=
his
> was fixed quickly after I searched list archives.
> At the same time I've learned that recent versions of lm_sensors are able=
 to
> detect Intel Atom thermal sensors.
> I installed version 3.1.2 - now sensors-detect correctly identifies Atom
> CPU, but I still do not see probes in sensors output.
>
> Question - is this because Atom CPU support in coretemp is only in kernel
> 2.6.32 and my Ubunty is only=A0 2.6.31?
>
> Next, I'll try to create configuration for this motherboard, but I might
> need some help here as well.
> For example, I see output like this:
> temp1:=A0=A0=A0=A0=A0=A0 +46.8=B0C=A0 (low=A0 =3D=A0 +1.0=B0C, high =3D=
=A0 -1.0=B0C)=A0 ALARM
> temp2:=A0=A0=A0=A0=A0=A0 +45.5=B0C=A0 (low=A0 =3D=A0 +1.0=B0C, high =3D=
=A0 -1.0=B0C)=A0 ALARM
> Which shows wrong min/max values, but browsing /sys/devices I found some
> additional ranges in those files:
> temp1_auto_temp_crit =3D 80000
> temp1_auto_temp_max =3D 52000
> temp1_auto_temp_min =3D 50000
> temp1_auto_temp_off =3D 46000
> What are those values (I understand that its Celsius * 1000)?=A0 My guess
> would be the values for fan control?
> Also, temp1_max, temp1_min and temp1_fault are all "bad" - is this because
> adt7468 does not report those values?
> Is there detailed documentation on files in /sys/devices? Or reading
> lib/sysfs.c is my best bet?
>
> Thank you very much for your help!
>
> --
> DG
> NJ
>
>



--=20
DG
NJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

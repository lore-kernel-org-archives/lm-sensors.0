From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 17:47:06 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <20070902194706.3d9f321e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 02 Sep 2007 14:57:32 +0200, Juergen Bausa wrote:
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 4c00
> V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> Vccp:      +1.10 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:      +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V5:        +4.94 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:      +11.80 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:  +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Int Temp:    +34=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> CPU Temp:    +29=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> CPU_Fan:     0 RPM  (min =3D    0 RPM)
> ERROR: Can't get fan3 data!
> ERROR: Can't get fan5 data!
> ERROR: Can't get fan6 data!
> CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> ERROR: Can't get pwm5 data!
> ERROR: Can't get pwm6 data!
> cpu0_vid: +1.550 V  (VRM Version 2.4)

Juerg, sensors shouldn't be displaying these errors for optional fans
and pwms. Can you please provide a patch fixing this? It should be
pretty easy.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

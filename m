From: atr_temp@mail.ru
Date: Wed, 06 Apr 2011 20:17:22 +0000
Subject: [lm-sensors] ITE IT8721F, IT8758E it87 standalone driver report
Message-Id: <2610648201.20110407001722@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello, Lm-sensors.

Sending  report  about using standalone driver for IT8721F, IT8758E at
Ubuntu 9.10 with kernel 2.6.31.12 with motherboard Foxconn D42S.

I  was  unable  to build just driver from sources, so i put it into my
kernel sources: replace original drivers/hwmon/it87.c with new one.
Next i compile and install kernel and found a problem:
> # modprobe it87
> FATAL: Error inserting it87 (/lib/modules/***/drivers/hwmon/it87.ko): Dev=
ice or resource busy
But found a solution:
> Basically, you need to add a new kernel line in your menu.lst to fix
> this behavior.
> acpi_enforce_resources=3Dlax
And it was good for me.
Now the sensors give me correct output, but without names (temp1, fan1
and  so  on), so i had to edit /etc/sensors.conf and now the output is
correct for me (temp and fans)
> # sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1: +55.0=B0C (crit =3D +85.0=B0C)
>
> it8721-isa-0a10
> Adapter: ISA adapter
> in0: +2.76 V (min =3D +1.38 V, max =3D +2.05 V) ALARM
> in1: +2.80 V (min =3D +1.30 V, max =3D +3.05 V)
> in2: +2.06 V (min =3D +0.66 V, max =3D +2.98 V)
> +3.3V: +3.41 V (min =3D +5.66 V, max =3D +1.87 V) ALARM
> in4: +1.87 V (min =3D +2.82 V, max =3D +2.60 V) ALARM
> in5: +1.04 V (min =3D +1.68 V, max =3D +1.02 V) ALARM
> in6: +2.23 V (min =3D +1.43 V, max =3D +1.48 V) ALARM
> 3VSB: +3.24 V (min =3D +4.37 V, max =3D +0.72 V) ALARM
> Vbat: +3.05 V
> CPU Fan: 903 RPM (min =3D 14 RPM)
> Sys Fan: 0 RPM (min =3D 12 RPM) ALARM
> CPU Temp: +54.0=B0C (low =3D -107.0=B0C, high =3D +80.0=B0C) sensor =3D t=
hermal diode
> temp2: -56.0=B0C (low =3D -10.0=B0C, high =3D +127.0=B0C) sensor =3D ther=
mal diode
> M/B   Temp:   +35.0=B0C   (low  =3D  -61.0=B0C,  high =3D +127.0=B0C) sen=
sor =3Dthermal diode

For more information look at my blog post
http://www.aleksandr.ru/blog/ubuntu_9_10___lm_sensors___ite_it8721f_it8758e=
.html
(in Russian language)


--=20
 Rebel                          mailto:atr_temp@mail.ru


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

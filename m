From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Dec 2008 08:50:00 +0000
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <20081211095000.334e3b83@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081203182216.5be504cf@hyperion.delvare>
In-Reply-To: <20081203182216.5be504cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ludovic,

On Wed, 10 Dec 2008 23:24:05 +0100, Ludovic Leb=E8gue wrote:
> Hi Jean,
>=20
> Here is the result of my latest tests with f8000 on a 2.6.27 kernel.
>=20
> - Compilation OK :
> - insmod OK : kernel trace
>     Dec 10 23:16:57 xxx kernel: [88516.594275] f8000: Found F8000 chip at=
 0xa00
>     Dec 10 23:16:57 xxx kernel: [88516.595009] f8000 f8000.2560: Fan
> monitoring is enabled
>     Dec 10 23:16:57 xxx kernel: [88516.595667] f8000 f8000.2560:
> Temperature and voltage monitoring is enabled
> - "sensors" output
>     f8000-isa-0a00
>     Adapter: ISA adapter
>     in0:         +3.36 V
>     in1:         +3.34 V
>     in2:         +3.28 V
>     fan1:       1466 RPM
>     fan2:        909 RPM
>     fan3:          0 RPM
>     fan4:          0 RPM
>     temp1:       +46.0=B0C  (high =3D +60.0=B0C, crit =3D +70.0=B0C)
>     temp2:       +41.0=B0C  (high =3D +85.0=B0C, crit =3D +100.0=B0C)
>     temp3:       +40.0=B0C  (high =3D +85.0=B0C, crit =3D +100.0=B0C)
>=20
> It all seems OK to me.

Looks indeed alright to me. You can add the following
to /etc/sensors3.conf to get labels for the voltage inputs:

# Asus/Fintek F8000
chip "f8000-*"

   # All 3 voltages are internal, so scaling is done by the driver and
   # labels are always correct
   label  in0  "+3.3V"
   label  in1  "3VSB"
   label  in2  "Vbat"

I've just added this to the default configuration file.

Please note that, after discussion with Hans de Goede (Cc'd), we
decided that it was better to add support for the F8000 to an existing
driver (f71882fg) than writing a new driver as I did, because there
would be a lot of duplicated code otherwise. So Hans will probably ask
you to do more testing once he is done with the code.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

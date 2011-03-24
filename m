From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Mar 2011 17:53:14 +0000
Subject: Re: [lm-sensors] Bad readouts on ASUS M2V VIA VT8237A
Message-Id: <20110324185314.4773ee27@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <459C1D31.4010903@intercarve.net>
In-Reply-To: <459C1D31.4010903@intercarve.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Drew,

On Wed, 03 Jan 2007 15:16:33 -0600, Drew Vogel wrote:
> it8712-isa-0d00
> Adapter: ISA adapter
> VCore 1:   +1.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:   +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> +3.3V:     +3.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:       +4.89 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> +12V:     +11.90 V  (min =3D  +0.00 V, max =3D +16.32 V)
> -12V:      +3.93 V  (min =3D -27.36 V, max =3D  +3.93 V)   ALARM
> -5V:       +4.03 V  (min =3D -13.64 V, max =3D  +4.03 V)   ALARM
> Stdby:     +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
> VBat:      +3.31 V
> fan1:     35526 RPM  (min =3D    0 RPM, div =3D 2)
> fan2:        0 RPM  (min =3D    0 RPM, div =3D 2)
> fan3:        0 RPM  (min =3D    0 RPM, div =3D 2)
> M/B Temp:    +36=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =
=3D thermistor
> CPU Temp:    +42=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =
=3D thermistor
> Temp3:      +128=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =
=3D disabled

Do you still have this Asus M2V board? Would you be able to tell me the
revision of the IT8712F chip being used on it? The it87 driver writes
it in the kernel log when loaded. Alternatively, the output of the
following command will do:
# isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

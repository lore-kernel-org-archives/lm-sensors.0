From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 Aug 2007 08:56:12 +0000
Subject: Re: [lm-sensors] VCoreB aceptable values ? Negative temperature
Message-Id: <20070824105612.2506974a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C8203E.6050207@wanadoo.fr>
In-Reply-To: <46C8203E.6050207@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi S=E9bastien,

On Sun, 19 Aug 2007 12:49:34 +0200, S=E9bastien CRAMATTE wrote:
> I've got a PDSMI+ motherboard with intel core duo 2.
> I'm running Linux Debian with 2.6.22.1 kernel
>=20
> Lm-sensors return me this values :
>=20
> w83793-i2c-0-2f
> VCoreA:    +1.32 V  (min =3D  +0.92 V, max =3D  +1.49 V)  =20
> VCoreB:    +1.53 V  (min =3D  +0.92 V, max =3D  +1.49 V)   ALARM
> Vtt:       +1.21 V  (min =3D  +1.08 V, max =3D  +1.33 V)  =20
> in3:       +0.51 V  (min =3D  +0.38 V, max =3D  +0.69 V)  =20
> in4:       +1.82 V  (min =3D  +1.62 V, max =3D  +1.98 V)  =20
> +3.3V:     +3.38 V  (min =3D  +2.96 V, max =3D  +3.63 V)  =20
> +12V:     +11.81 V  (min =3D +10.75 V, max =3D +13.25 V)  =20
> +5V:       +5.00 V  (min =3D  +4.64 V, max =3D  +5.65 V)  =20
> 5VSB:      +5.07 V  (min =3D  +4.64 V, max =3D  +5.65 V)  =20
> VBAT:      +3.23 V  (min =3D  +2.99 V, max =3D  +3.66 V)  =20
> fan1:     11637 RPM  (min =3D  712 RPM)                  =20
> fan2:     11250 RPM  (min =3D  712 RPM)                  =20
> CPU1 Temp: +37.2 C  (high =3D +60.0 C, hyst =3D +55.0 C)  =20
> CPU2 Temp:-115.5 C  (high =3D +60.0 C, hyst =3D +55.0 C)  =20
> temp3:    -128.0 C  (high =3D +60.0 C, hyst =3D +55.0 C)  =20
> temp4:    -128.0 C  (high =3D +60.0 C, hyst =3D +55.0 C)  =20
> temp5:       +39 C  (high =3D   +80 C, hyst =3D   +75 C) =20
>=20
> Could you tell me what should the values rangee for  VCoreB (min/max) ?

First you need to find out what this channel is monitoring. The default
usage is for a second Vcore, but if this is a single CPU system,
there's no second Vcore. 1.53V could be the AGP voltage. Check out what
your BIOS says for voltages, this might give you a hint. Or ask the
motherboard manufacturer - but usually they don't answer this kind of
highly technical questions.

If this is really the AGP voltage then you can change your
configuration file that way:

   label  in1  "Vagp"
   set in1_min  1.5 * 0.95
   set in1_min  1.5 * 1.05

> What about temp4 and temp5  ? I would like to know what this temp captor
> return me  negative values ...

-128 isn't a real temperature ;) It simply means that these channels
aren't used and you can ignore them:

   ignore temp3
   ignore temp4

I'm more surprised by temp2, but as it seems that you have good
temperature measurements on temp1 and temp5, I guess that you can also
ignore temp2.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

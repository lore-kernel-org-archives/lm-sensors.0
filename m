From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Oct 2008 13:30:33 +0000
Subject: Re: [lm-sensors] High temperatures on Intel DG31PR
Message-Id: <20081002153033.7c48a72f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200809101453.36339.raju@linux-delhi.org>
In-Reply-To: <200809101453.36339.raju@linux-delhi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 2 Oct 2008 18:12:35 +0530, Raj Mathur wrote:
> [Forwarding again as the first time around the message seems to have got =

> missed]
>=20
> Hi,
>=20
> I have a new Intel DG31PR motherboard with an Intel 7200 Core 2 Duo=20
> processor reporting what look like very high temperatures.  Running=20
> Debian GNU/Linux Testing.
>=20
> Software:
>=20
> Kernel:		Linux XXX 2.6.26-1-686 #1 SMP Thu Aug 28 12:00:54 UTC 2008 i686 =

> GNU/Linux
> libsensors3                           1:2.10.7-1                         =
 =20
> libsensors4                           1:3.0.2-1+b2                       =
 =20
> lm-sensors                            1:3.0.2-1+b2                       =
 =20
>=20
> sensors-detect seems to find the sensors fine (transcript at bottom). =20
> However now I find that some of the temperatures seem to be=20
> unreasonably high.  Please see Sys Temp (76.0C) and Aux Temp (127.0C)=20
> in the sensors output under.

127 degrees C typically means that no thermal sensor is connected to
that input. So you can ignore this input.

76 degrees C is admittedly very high, but then again it depends what it
is measuring. Don't trust the default labels which may or may not apply
to your motherboard. You should compare with what the BIOS says. Also
look at the motherboard documentation, in my experience Intel board
have a good description of where the thermal sensors are located.

If the temp1 value never changes, you may try changing the sensor type
and see if you get better values. But the BIOS should have set the
proper type for you already.

>=20
> Is this normal/expected?  If not, any solution for this issue?  I'd be=20
> glad to provide any other information required.
>=20
> Regards,
>=20
> -- Raju
>=20
> *** sensors output
> -------------------------------
> w83627dhg-isa-0290
> Adapter: ISA adapter
> VCore:       +1.05 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:        +10.61 V  (min =3D  +2.53 V, max =3D  +4.75 V)   ALARM
> AVCC:        +3.33 V  (min =3D  +3.66 V, max =3D  +2.99 V)   ALARM
> 3VCC:        +3.31 V  (min =3D  +2.26 V, max =3D  +3.17 V)   ALARM
> in4:         +1.82 V  (min =3D  +0.78 V, max =3D  +1.58 V)   ALARM
> in5:         +1.26 V  (min =3D  +1.11 V, max =3D  +1.17 V)   ALARM
> in6:         +0.31 V  (min =3D  +1.48 V, max =3D  +1.23 V)   ALARM
> VSB:         +3.30 V  (min =3D  +1.28 V, max =3D  +2.34 V)   ALARM
> VBAT:        +3.18 V  (min =3D  +3.58 V, max =3D  +3.10 V)   ALARM
> Case Fan:    803 RPM  (min =3D 1163 RPM, div =3D 8)  ALARM
> CPU Fan:     917 RPM  (min =3D 2280 RPM, div =3D 8)  ALARM
> Aux Fan:       0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> fan4:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> Sys Temp:    +76.0=B0C  (high =3D  +1.0=B0C, hyst =3D +43.0=B0C)  ALARM  =
sensor =3D=20
> diode
> CPU Temp:    +35.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> AUX Temp:   +127.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor =3D=20
> thermistor
> cpu0_vid:   +2.050 V
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +53.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +51.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)

According to coretemp your CPU isn't too hot, so you really don't have
to worry for the CPU.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

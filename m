From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Jun 2011 19:25:43 +0000
Subject: Re: [lm-sensors] Atom D525 (on GA-D525TUD)
Message-Id: <20110617212543.6f9100e6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 18 Nov 2010 09:31:36 +0200, Thanasis wrote:
> ~ # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> ERROR: Can't get value of subfeature temp1_input: Can't read
> Core 0:       +0.0=B0C  (crit =3D +100.0=B0C)                =20
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> ERROR: Can't get value of subfeature temp1_input: Can't read
> Core 1:       +0.0=B0C  (crit =3D +100.0=B0C)                =20
> (...)
>  ~ #
>=20
> Is the above ERROR normal?

No, it is not. A more recent version of lm-sensors would display N/A as
the temperature instead of the error message, but the problem remains.

> Is there something I can/should do/configure about it?

This is a hardware or driver issue, not sure yet. We had similar
reports for other Atom CPUs, I don't know if this means these CPUs just
don't have working sensors, or if there's any workaround the driver
could apply to get them to work. Nothing you can do as a user anyway.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

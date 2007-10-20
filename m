From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Oct 2007 20:49:01 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <20071020224901.579239d7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 19 Oct 2007 22:53:09 -0400, James Scott Jr wrote:
> Thank you, sensor's output is now correct - coretemp's is wacked.  I
> will look into whats happening with coretemp, later.
>=20
> [jscott@vserv ~]$ sensors
> (...)
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +54=B0C  (high =3D  +100=B0C)                  =20
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +51=B0C  (high =3D  +100=B0C)                  =20
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +52=B0C  (high =3D  +100=B0C)                  =20
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +50=B0C  (high =3D  +100=B0C)                  =20
>=20

The coretemp values actually look alright to me.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

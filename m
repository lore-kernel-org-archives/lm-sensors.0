From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Jul 2007 16:04:12 +0000
Subject: Re: [lm-sensors] Status update generic chipset support
Message-Id: <20070702180412.490d03f0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061205235059.24a657b4@ws01.atreidis.nl.eu.org>
In-Reply-To: <20061205235059.24a657b4@ws01.atreidis.nl.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 7 Dec 2006 08:51:54 -0500, Mark M. Hoffman wrote:
> * Bob Schl=E4rmann <bob2@dsv.nl> [2006-12-05 23:50:59 +0100]:
> > - The following chips have a special feature that indicates the type of
> > temp. sensor used, (w83781d, it87, f71805f). None of these have
> > specifified the main temp. feature as their mapping in lib/chips.c. This
> > means the function can't easily find out to which temp. it belongs.
> >=20
> > It would be easier when there was a mapping.
>=20
> Don't be afraid to patch this also. ;)

This is fixed now.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

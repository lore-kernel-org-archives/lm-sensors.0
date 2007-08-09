From: Joerg Sommrey <jo@sommrey.de>
Date: Thu, 09 Aug 2007 07:09:15 +0000
Subject: Re: [lm-sensors] bad temperature values from w83781d in 2.6.22
Message-Id: <20070809070915.GA24252@sommrey.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070805183219.0d54802b.akpm@linux-foundation.org> <20070808010316.GB3584@jupiter.solarsys.private> <20070808151716.GA6053@sommrey.de> <20070809035642.GE3584@jupiter.solarsys.private>
In-Reply-To: <20070809035642.GE3584@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Mark,

On Wed, Aug 08, 2007 at 11:56:42PM -0400, Mark M. Hoffman wrote:
> Hi Joerg:
>=20
> * Joerg Sommrey <jo@sommrey.de> [2007-08-08 17:17:16 +0200]:
> > Hi Mark,
> >=20
> > just to eliminate as many impacts as possible, I did:
> > - reinstall the unmodified sensors.conf from Tyan's support page
> > - power off before rebooting
> >=20
> > A call to "sensors -s" is done without errors in all cases.
> > The module parameters I use currently with both kernels:
> >=20
> > options w83781d force_w83782d=3D0,0x2d force_subclients=3D0,0x2d,0x48,0=
x49
> > options w83627hf force_addr=3D0x0c00
> >=20
> > When I first realized the problem, I didn't use w83627hf yet.  Results
> > are the same when w83781d is used as driver for w83627hf.
> > Parameters in that case just from Tyan:
> >=20
> > options w83781d force_w83782d=3D0,0x2d force_subclients=3D0,0x2d,0x48,0=
x49 force_w83627hf=3D0,0x2c force_subclients=3D0,0x2c,0x4a,0x4b init=3D0
> >=20
> > "My" i2cdump doesn't accept an -y option, maybe a Debianism.  Results
> > see below.
>=20
> Newer i2cdump skips the 5-second warning when given -y, that's all.
>=20
> > ### 2.6.21 ###############################
> > Script started on Wed Aug  8 16:53:10 2007
> > bear:~/hwmon# i2cdump 0 0x2d b 0 0x4e
>=20
> (snip tons of results)
>=20
> Thanks for sending all that.  I see one bug clearly, and I'm pretty close=
 to
> seeing the other one.  But for tonight, I need sleep.
>=20
> In the meantime, please try this command as root, against the newer kerne=
l,
> *after* you've done 'sensors -s':
>=20
> 	# i2cset -f 0 0x2d 0x5d 0x0e b
>=20
> Wait > 2 seconds for the hardware to update itself, then run 'sensors' ag=
ain.
> I'm pretty sure you'll see the correct temps.
The displayed temperatures changed to 67.5=B0C / 66.0=B0C.  Still, this see=
ms to
be too high.  The power supply's fan runs too slow for such CPU
temperatures. In older kernels it becomes noisy above 50=B0C.

Under load the temperatures shown are around 95=B0C, way too high.

-jo

--=20
-rw-r--r-- 1 jo users 62 2007-08-08 21:06 /home/jo/.signature

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

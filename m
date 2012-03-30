From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 30 Mar 2012 20:03:58 +0000
Subject: [lm-sensors] [PATCH v2 00/15] mark const init data with __initconst instead of __initdata
Message-Id: <20120330200358.GV15647@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120329211131.GA31250@pengutronix.de>
In-Reply-To: <20120329211131.GA31250@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Christoph Lameter <cl@linux-foundation.org>, linux-mips@linux-mips.org, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Matt Porter <mporter@kernel.crashing.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, ibm-acpi-devel@lists.sourceforge.net, Randy Dunlap <rdunlap@xenotime.net>, linux-mtd@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Daniel Walker <dwalker@fifo99.com>, lm-sensors@lm-sensors.org, Klaus Kudielka <klaus.kudielka@ieee.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Kevin Hilman <khilman@ti.com>, linux-ia64@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.c>

Hello,

On Thu, Mar 29, 2012 at 11:11:31PM +0200, Uwe Kleine-K=F6nig wrote:
> this series fixes a common error to use __initdata to mark const
> variables. Most of the time this works well enough to go unnoticed
> (though I wonder why the linker doesn't warn about that).
> Just try adding something like
>=20
> 	int something __initdata;
>=20
> to one of the patched files and compile to see the error.
>=20
> While touching these annotations I also corrected the position where it
> was wrong to go between the variable name and the =3D.
>=20
> Note this series is not compile tested.
I now dropped the wrong annotations. So two patches became obsolete
(mtd and percpu). Note that I also dropped fixing the position of
__initdata if changing it to __initconst was wrong. (I think if
__initdata is placed before the variable name it doesn't have any
effect.)

I didn't promote the Acks I got because all acked changes changed in v2.

For the details changed in each patch see the changelogs in the
respective patch mails that I follow up to this mail.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

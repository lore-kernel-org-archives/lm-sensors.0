From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Thu, 29 Mar 2012 21:11:31 +0000
Subject: [lm-sensors] [PATCH 00/17] mark const init data with __initconst instead of __initdata
Message-Id: <20120329211131.GA31250@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Christoph Lameter <cl@linux-foundation.org>, linux-mips@linux-mips.org, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Matt Porter <mporter@kernel.crashing.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, ibm-acpi-devel@lists.sourceforge.net, Randy Dunlap <rdunlap@xenotime.net>, linux-mtd@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Daniel Walker <dwalker@fifo99.com>, lm-sensors@lm-sensors.org, Klaus Kudielka <klaus.kudielka@ieee.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Kevin Hilman <khilman@ti.com>, linux-ia64@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.c>

Hello,

this series fixes a common error to use __initdata to mark const
variables. Most of the time this works well enough to go unnoticed
(though I wonder why the linker doesn't warn about that).
Just try adding something like

	int something __initdata;

to one of the patched files and compile to see the error.

While touching these annotations I also corrected the position where it
was wrong to go between the variable name and the =3D.

Note this series is not compile tested.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

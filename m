From: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Fri, 29 Jul 2011 04:56:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (zl6100) Add new chip support
Message-Id: <3C06C26914DACA4BB3A368F78CA0B3A70A7E0D@039-SN1MPN1-004.039d.mgd.msft.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308707361-15558-1-git-send-email-b29983@freescale.com>
In-Reply-To: <1308707361-15558-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I got this from Intersil Support.
It is a zl6100 chip Errata and can't be found in zl6100 later chip.
So, this chip maybe can't work on PMbus framework.

Good luck!

Regards,
Yuantian


> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: 2011=C4=EA7=D4=C229=C8=D5 12:35
> To: Tang Yuantian-B29983
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [PATCH] hwmon: (zl6100) Add new chip support
>=20
> On Wed, Jun 22, 2011 at 09:49:21AM +0800, b29983@freescale.com wrote:
> > From: Tang Yuantian <B29983@freescale.com>
> >
> > 	The ZL6100 is a digital power controller with Power Monitoring
> support.
> > 	It provides an I2C/SMBus digital interface that enables the user to
> > 	configure all aspects of the device operation as well as monitor
> the
> > 	input and output parameters. It accepts most standard PMBus
> commands.
> > 	Four parameters are output here which are Output Current, Output
> Voltage,
> > 	Local Temperature and Remote Temperature.
> >
> > 	This chip is currently used on some PowerPC platform.
> >
> > Signed-off-by: Tang Yuantian <b29983@freescale.com>
>=20
> Hi,
>=20
> I finally got an eval board for the ZL6100 and was able to do some
> testing.
>=20
> The key problem with the chip and the generic PMBus driver is reflected
> by the
> 	msleep(2);
> in your driver. Problem here is that this adds a delay of up to 20ms to
> each and every I2C read command, which is really not desirable. I found
> that udelay(500) does the trick as well, but is not much better. I'll
> need to think about this a bit.
>=20
> Where do you have the 2ms value from ? I don't seem to be able to find it
> in the datasheet.
> Also, the ZL6105 does not seem to have the timing problem.
>=20
> Thanks,
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

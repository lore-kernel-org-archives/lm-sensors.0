From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2007 12:08:49 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071023140849.7b8010f0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Mon, 22 Oct 2007 09:02:37 -0700, Juerg Haefliger wrote:
> From the ACPI spec:
> Indicates that the transaction failed because the SMBus host
> reports that the SMBus is presently busy with some other
> transaction. For example, the Smart Battery might be
> sending charging information to the Smart Battery Charger.

Hmm, OK, that's really "bus busy" then. It may be related to this chip
at address 0x0d. Can't say more without detailed hardware
specifications of the system.

> > Depends on what kernel Juergen is running. Oleg Ryjkov has submitted
> > interesting patches that clean up this part of the i2c-nforce2 driver:
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;hA53549734cbdba24e9cf5eb200b70b7b1572e15
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=D49584c4a37c7228e7778bcb60f79e7a08472fa8
> > These are already in Linus' tree for 2.6.24.
>=20
> Hmm... These patches add abort functionality in case the controller is
> locked. I don't think this is our problem here. In Juergen's case, any
> subsequent transaction after one that fails succeeds so it's a
> transient problem and not a hard lock.

The second patch if completely unrelated, agreed. But the first patch
changes how the driver polls for transaction status. While it is not
related to Juergen's problem, the timing change involved could affect
the code you want to add to retry the transaction when the bus is busy.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

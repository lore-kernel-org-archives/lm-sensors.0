From: Sebastian Siewior <bigeasy@linutronix.de>
Date: Thu, 18 Sep 2008 08:12:31 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: add support for MAX1618 in MAX1619
Message-Id: <48D20D6F.9000705@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080916133542.GA2072@www.tglx.de>
In-Reply-To: <20080916133542.GA2072@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Sebastian,
>=20
> Your patch is way too big for what it is doing. All you really need
> to do to have MAX1618 support is prevent the driver from creating the
> temp1* files in sysfs for this chip. This can be done very easily by
> having two attribute groups, one for temp1 and one for temp2.

Thanks for the review. I try address your issues but it may take some time.

Sebastian
--=20
Firmensitz: 88690 Uhldingen, Auf dem Berg 3
Registergericht: Amtsgericht Freiburg i. Br., HRB 700 806;
StNr. 87007/07777; Ust-Id Nr.: DE252739476
Gesch=E4ftsf=FChrer: Heinz Egger, Thomas Gleixner

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

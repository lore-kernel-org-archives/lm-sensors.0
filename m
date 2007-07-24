From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jul 2007 12:00:00 +0000
Subject: Re: [lm-sensors] drivers/hwmon/lm93.c: array overruns
Message-Id: <20070724140000.73840fcf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070723005453.GS26212@stusta.de>
	<200707230936.58135.hjk@linutronix.de>
	<20070724101020.0f1bf458@hyperion.delvare>
	<200707241026.46814.hjk@linutronix.de>
In-Reply-To: <200707241026.46814.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?B?SGFucy1K/HJnZW4=?= Koch <hjk@linutronix.de>
Cc: Adrian Bunk <bunk@stusta.de>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Hans,

On Tue, 24 Jul 2007 10:26:46 +0200, Hans-J=FCrgen Koch wrote:
> Am Dienstag 24 Juli 2007 10:10 schrieb Jean Delvare:
> > However, I see that temp4 (which isn't a real temperature channel) is
> > not exposed in sysfs. Reading and storing register values you never use
> > doesn't seem particularly interesting, so something needs to be done
> > here: either drop support for temp4 entirely, or expose the temp4
> > values in sysfs.
>=20
> I've got that on my TODO list. I'll soon work on that driver again. I'm s=
till
> waiting for that #=A7$?& NDA-covered datasheet of the LM94. As soon as I'=
ve got
> that, I need to review all these values anyway because there might be sub=
tle
> differences between LM93 and LM94.
> For the moment, I'd like to postpone the decision about what to do with t=
emp4.

Sure, no problem.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

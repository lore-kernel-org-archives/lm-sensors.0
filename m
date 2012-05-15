From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Tue, 15 May 2012 18:49:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Drop uart6 condition for vin5&vin6 for IT8783F
Message-Id: <271EF141-35A9-48E9-88A2-05EA43073BBC@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
In-Reply-To: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> What about FAN3_TAC? As I read the datasheet, it is also "freed" if
> UART6 is moved to pins 100-106. So I suspect we don't want to check for
> uart6 at all for the IT8783F.
>=20
Yes you're right, following the same logic FAN_TAC3 should get freed likewi=
se.

> This all would better be done directly in Guenter's patch, BTW, as it
> isn't upstream yet.
>=20
agreed from my side   ;-)

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

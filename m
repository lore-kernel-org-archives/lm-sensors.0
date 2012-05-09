From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Wed, 09 May 2012 16:01:19 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (it87) Make temp3 attribute conditional for IT8782F and IT8783F
Message-Id: <FB79959D-3976-4D05-9548-E5ADE9EF996F@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

Am 09.05.2012 um 04:31 schrieb Guenter Roeck:
> On IT8782F and IT8783F, temp3 is only supported if UART6 is disabled.
>=20
The IT8783F allows UART6 and temp3 both to be used at the same time. This i=
s achieved by wiring UART6 to the original parallel port output. Therefore,=
 when using UART6 and temp3 at the same time, the parallel port can not be =
used in turn.
Technically: when JP4/Pin 1 ("MOVE UART6") is set to 0, then UART6 moves to=
 pin 100~106.

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

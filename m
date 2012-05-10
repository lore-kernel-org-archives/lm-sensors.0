From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Thu, 10 May 2012 19:41:04 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (it87) Make temp3 attribute conditional for IT8782F and IT8783F
Message-Id: <742011AD-D794-4ECD-A3A2-9559B588A39A@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

Am 09.05.2012 um 19:43 schrieb Guenter Roeck:
> Hi Bjoern,
>=20
> Looking through the data sheet, it seems that there is no way to read
> the setting of JP4/Pin 1 in SW. This means I can not really detect if
> UART6 pin 6 overlaps with temp3 or not. Is this correct ?

Discussed that with my hw folks. Yes, that's correct: sadly there is no way=
 to read out this setting.

> If yes, I
> think we have to drop this patch.
>=20
ok, agreed.

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

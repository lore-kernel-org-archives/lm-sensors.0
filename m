From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Wed, 02 Sep 2009 08:45:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments
Message-Id: <4A9E308E.60505@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
In-Reply-To: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: tomaz.mertelj@guest.arnes.si
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

tomaz.mertelj@guest.arnes.si a =E9crit :
> I have crafted a hwmon driver for Texas Instruments amc6821 SMB-bus 2-
> channel temperature sensor, pwm controller. This is my first linux projec=
t=20
> so some corrections will be necessary.
>=20
> T. Mertelj

Hello

I have some warnings

  CC      drivers/hwmon/amc6821.o
drivers/hwmon/amc6821.c: In function `set_temp1_auto_point_temp':
drivers/hwmon/amc6821.c:390: warning: comparison is always true due to limi=
ted range of data type
drivers/hwmon/amc6821.c: In function `set_temp2_auto_point_temp':
drivers/hwmon/amc6821.c:391: warning: comparison is always true due to limi=
ted range of data type
drivers/hwmon/amc6821.c: In function `set_pwm1_auto_point_pwm':
drivers/hwmon/amc6821.c:408: warning: comparison is always true due to limi=
ted range of data type
drivers/hwmon/amc6821.c:419: warning: comparison is always true due to limi=
ted range of data type

you use tmp as a unsigned 8 bit so it is always >=3D 0 (it can't be below 0)
Prefer use:
s8 tmp;


Cordially

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

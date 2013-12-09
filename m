From: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Date: Mon, 09 Dec 2013 11:42:13 +0000
Subject: [lm-sensors] Problem with a hih6130 sensor in a OMAP I2C bus
Message-Id: <52A5AC95.3050803@inov.pt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

Hi,

While testing an HIH6130 humidity and temperature sensor with I2C=20
interface in a BeagleBone board I've found that I was unable to read it=20
because the driver always returned EINVAL. With some debugging I've=20
found that the error was due to a test on omap_i2c_xfer_msg() in OMAP=20
I2C driver that invalidates zero length writes. The hwmon hih6130 driver=20
issues such kind of request in hih6130_update_measurements() to issue a=20
measurement request to the sensor.

I was able to get measurements from the sensor by hacking the hih6130=20
driver replacing the following line in hih6130_update_measurements();

         ret =3D i2c_master_send(client, tmp, 0);

by

         tmp[0] =3D 0;
         ret =3D i2c_master_send(client, tmp, 1);

Is this the correct way to fix this issue, or should the fix be in the=20
I2C OMAP driver to accept zero length transfers?

Best regards,
Jos=E9 Gon=E7alves

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

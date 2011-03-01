From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Mar 2011 18:36:05 +0000
Subject: Re: [lm-sensors] f75375s detected but no temp output
Message-Id: <20110301193605.1e1bd8c4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
In-Reply-To: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 1 Mar 2011 19:19:02 +0100, Pali Roh=E1r wrote:
> I commented code ..if ( port =3D 2 ).. there is only
>=20
> pI2cAdapter->class =3D I2C_CLASS_HWMON
>=20
> so it is called for every port. But sensors still not working :( Any
> other hints?

Please provide the output of the following command:

$ grep . /sys/class/hwmon/hwmon*/{,device/}name

Please also try the following (as root) and see it it helps (assuming
i2c-4 always corresponds to the I2C bus where sensors-detect finds the
F75375S/SP chip):

# echo f75375 0x2e > /sys/bus/i2c/devices/i2c-4/new_device

This should instantiate the device regardless of the detection code of
the f75375s driver.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

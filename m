From: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Date: Wed, 11 Dec 2013 19:51:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: HIH-6130: Support I2C bus drivers without I2C_FUNC_SMBUS_QUICK
Message-Id: <52A8C25A.6000403@inov.pt>
List-Id: <lm-sensors.vger.kernel.org>
References: <1386760273-7703-1-git-send-email-jose.goncalves@inov.pt> <20131211192954.GA21751@roeck-us.net>
In-Reply-To: <20131211192954.GA21751@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11-12-2013 19:29, Guenter Roeck wrote:
> On Wed, Dec 11, 2013 at 11:11:13AM +0000, Jos=E9 Miguel Gon=E7alves wrote:
>> Some I2C bus drivers do not allow zero-length data transfers which are
>> required to start a measurement with the HIH6130/1 sensor. Nevertheless,
>> we can overcome this limitation by writing a zero dummy byte. This byte
>> is ignored by the sensor and was verified to be working with the OMAP
>> I2C bus driver in a BeagleBone board.
>>
>> Signed-off-by: Jos=E9 Miguel Gon=E7alves <jose.goncalves@inov.pt>
> Applied, after simplifying write_length initialization a bit.
>
> Should this go to -stable ?

Any BeagleBone user that tries to use this sensor will encounter this issue=
. As=20
this board is very popular, this will potentially solve the problems of man=
y=20
users. Nevertheless, it does not seems to me that this patch fixes "somethi=
ng=20
critical", which is one of the conditions to be accepted in the -stable tre=
e.

Jos=E9 Gon=E7alves

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

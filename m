From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Mar 2013 02:24:21 +0000
Subject: Re: [lm-sensors] Gigabyte E240N, it87 module, fan speed control not working, readings may bad
Message-Id: <20130327022421.GA29478@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <51522BDC.6070103@sirc.hu>
In-Reply-To: <51522BDC.6070103@sirc.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Mar 27, 2013 at 12:14:36AM +0100, Hajdu Tam=E1s M=E1rk wrote:
> Hi,
>=20
> I have a Gigabyte E240N mainboard (integrated amd cpu and gpu),
> which by pwmconfig reported to use it87 module. This is for first
> sight works, but one out of 3 temperature reading is always -70
> degrees (though it is the temp3, which I don't know what), other two

Most likely it is not connected to anything.

> seems to good. Also the fan speed readings seems to be ok (I am not
> 100% sure). What it really does, that hwmon1 is created and there
> are changing values so at least it is partially working.
> I have tried to use pwmconfig to configure and also tried to echo
> values I could think of, but I could not set (nor pwmconfig could)
> it's speed.

Fan control may be in automatic mode. That is the case if pwmX_enable
returns 2. If so, you are most likely better off by leaving it alone.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

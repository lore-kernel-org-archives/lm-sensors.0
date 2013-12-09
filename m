From: =?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?= <jose.goncalves@inov.pt>
Date: Mon, 09 Dec 2013 13:19:48 +0000
Subject: Re: [lm-sensors] Problem with a hih6130 sensor in a OMAP I2C bus
Message-Id: <52A5C374.1040609@inov.pt>
List-Id: <lm-sensors.vger.kernel.org>
References: <52A5AC95.3050803@inov.pt> <20131209132239.3c0f6402@endymion.delvare>
In-Reply-To: <20131209132239.3c0f6402-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Jean,

On 09-12-2013 12:22, Jean Delvare wrote:
> Hi Jos=E9,
>
> On Mon, 09 Dec 2013 11:42:13 +0000, Jos=E9 Miguel Gon=E7alves wrote:
>> While testing an HIH6130 humidity and temperature sensor with I2C
>> interface in a BeagleBone board I've found that I was unable to read it
>> because the driver always returned EINVAL. With some debugging I've
>> found that the error was due to a test on omap_i2c_xfer_msg() in OMAP
>> I2C driver that invalidates zero length writes. The hwmon hih6130 driver
>> issues such kind of request in hih6130_update_measurements() to issue a
>> measurement request to the sensor.
>>
>> I was able to get measurements from the sensor by hacking the hih6130
>> driver replacing the following line in hih6130_update_measurements();
>>
>>           ret =3D i2c_master_send(client, tmp, 0);
>>
>> by
>>
>>           tmp[0] =3D 0;
>>           ret =3D i2c_master_send(client, tmp, 1);
>>
>> Is this the correct way to fix this issue, or should the fix be in the
>> I2C OMAP driver to accept zero length transfers?
> Ideally it should be fixed in the i2c-omap bus driver. However, if
> zero-length transfers are explicitly prohibited, it may mean that the
> hardware itself can't do it (in which case adding a comment saying so
> in the source code would be great.) You'll have to check. The driver
> supports several generations of OMAP chipsets so you'll have to check
> them all, maybe some can handle zero-length messages and some do not.
>
> If fixing it in the i2c-omap driver is not possible, then working
> around it in the hih6130 driver would be acceptable. You'll have to
> make sure there is no side effect to sending a single byte to the chip.
> If performance is a concern, you may have to enable the workaround only
> when zero-byte messages aren't supported. You can check with:
>
> i2c_get_functionality(i2c_adapter) & I2C_FUNC_SMBUS_QUICK
>

I am by no means an expert on OMAP platforms and/or I2C drivers so, if=20
anyone else with more knowledge of them has a better suggestion, I will=20
follow your suggestion and submit my workaround patch for the hih6130=20
driver with the added check for support of zero-byte messages by the=20
underlying I2C driver. From my understanding of the technical note for=20
I2C communication on this chip;

http://www.mouser.com/pdfdocs/I2CCommunications.pdf

I see no problems on writing that dummy byte to it and my tests on a=20
real hardware also show that.

Best regards,
Jos=E9 Gon=E7alves

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

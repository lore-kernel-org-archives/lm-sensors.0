From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 18 Sep 2013 15:54:18 +0000
Subject: Re: [lm-sensors] [PATCH 06/16] hwmon: tmp102: expose to thermal fw via DT nodes
Message-Id: <5239CCAA.7030505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7193145785604461127=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com> <1379282563-14650-7-git-send-email-eduardo.valentin@ti.com> <523643D4.30208@roeck-us.net> <5238D7D9.9010203@ti.com> <20130918111849.GA9148@roeck-us.net> <5239B8B5.6050702@ti.com> <20130918151746.GA17065@roeck-us.net>
In-Reply-To: <20130918151746.GA17065-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

--===============7193145785604461127==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D9kjBGmus2G1QxnHP73AAnn6TMgeNRRb1"

--D9kjBGmus2G1QxnHP73AAnn6TMgeNRRb1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18-09-2013 11:17, Guenter Roeck wrote:
> On Wed, Sep 18, 2013 at 10:29:09AM -0400, Eduardo Valentin wrote:
>> On 18-09-2013 07:18, Guenter Roeck wrote:
>>> On Tue, Sep 17, 2013 at 06:29:45PM -0400, Eduardo Valentin wrote:
>>>> On 15-09-2013 19:33, Guenter Roeck wrote:
>>>>> On 09/15/2013 03:02 PM, Eduardo Valentin wrote:
>>>>>> This patch adds to tmp102 temperature sensor the possibility to
>>>>>> expose itself as thermal zone device, registered on the thermal
>>>>>> framework.
>>>>>>
>>>>>> The thermal zone is built only if a device tree node describing
>>>>>> a thermal zone for this sensor is present inside the tmp102 DT
>>>>>> node. Otherwise, the driver behavior will be the same.
>>>>>>
>>>>>> Cc: Jean Delvare <khali@linux-fr.org> Cc: Guenter Roeck
>>>>>> <linux@roeck-us.net> Cc: lm-sensors@lm-sensors.org Cc:
>>>>>> linux-kernel@vger.kernel.org Signed-off-by: Eduardo Valentin
>>>>>> <eduardo.valentin@ti.com> --- drivers/hwmon/tmp102.c | 28
>>>>>> ++++++++++++++++++++++++++++ 1 file changed, 28 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c=20
>>>>>> index d7b47ab..e432444 100644 --- a/drivers/hwmon/tmp102.c +++
>>>>>> b/drivers/hwmon/tmp102.c @@ -27,6 +27,8 @@ #include
>>>>>> <linux/mutex.h> #include <linux/device.h> #include
>>>>>> <linux/jiffies.h> +#include <linux/thermal.h> +#include
>>>>>> <linux/of.h>
>>>>>>
>>>>>> #define    DRIVER_NAME "tmp102"
>>>>>>
>>>>>> @@ -50,6 +52,7 @@
>>>>>>
>>>>>> struct tmp102 { struct device *hwmon_dev; +    struct
>>>>>> thermal_zone_device *tz; struct mutex lock; u16 config_orig;=20
>>>>>> unsigned long last_update; @@ -93,6 +96,19 @@ static struct
>>>>>> tmp102 *tmp102_update_device(struct i2c_client *client) return
>>>>>> tmp102; }
>>>>>>
>>>>>> +static int tmp102_read_temp(void *dev, long *temp) +{ +
>>>>>> struct tmp102 *tmp102 =3D
>>>>>> tmp102_update_device(to_i2c_client(dev)); + +    if
>>>>>> (tmp102->temp[0] < 0) +        dev_warn(tmp102->hwmon_dev, +
>>>>>> "operating in negative temp: %d\n", tmp102->temp[0]); +
>>>>>
>>>>> Please drop this warning.
>>>>>
>>>>
>>>> Done for both drivers.
>>>>
>>>>> Guenter
>>>>>
>>>>>> +    *temp =3D tmp102->temp[0]; + +    return 0; +} + static
>>>>>> ssize_t tmp102_show_temp(struct device *dev, struct
>>>>>> device_attribute *attr, char *buf) @@ -204,6 +220,16 @@ static
>>>>>> int tmp102_probe(struct i2c_client *client, goto
>>>>>> fail_remove_sysfs; }
>>>>>>
>>>>>> +    tmp102->tz =3D thermal_zone_of_sensor_register(&client->dev,
>>>>>> 0, +                             &client->dev, +
>>>>>> tmp102_read_temp, NULL); +    if (IS_ERR(tmp102->tz)) { +
>>>>>> dev_warn(&client->dev, +             "Could not parse thermal
>>>>>> data in device tree: %ld\n", +
>>>>>> PTR_ERR(tmp102->tz));
>>>>>
>>>>> Please drop this warning. You already create error messages in=20
>>>>> thermal_zone_of_sensor_register(). That should be sufficient. The
>>>>> same applies to the lm75 patch.
>>>>
>>>> OK. Done for both.
>>>>
>>>>>
>>>>> As a side note, I would suggest to provide devm_ functions for=20
>>>>> registration. We are introducing those for hwmon registration,
>>>>> which enables us to remove most _remove functions. It would be
>>>>> great if we can keep it that way.
>>>>>
>>>>
>>>> Right. This side note is taken. Actually this is on my todo list
>>>> for quite a while. But I believe this should not block this series,
>>>> should it? I will be probably cleaning the thermal framework code
>>>> after this current work is accepted at least.
>>>>
>>>>> On a higher level, I don't think it is a good idea to make
>>>>> thermal zones and thermal zone data mandatory. Many systems may
>>>>> neither need nor want it.
>>>>>
>>>>
>>>> Well, I agree with you. Did you see something hard required in the
>>>> patch I sent. I made it so that it could continue the driver probe
>>>> without thermal zones, as you requested.
>>>>
>>> If it is not mandatory you should not dump an error message to the
>>> console in the thermal registration function. Since you do, you at
>>> least consider it mandatory if that function is called.
>>>
>>> So please either drop the error message from the registration
>>> function or add a check into the drivers to only register into the
>>> thermal subsystem if there is a respective thermal entry for that
>>> sensor in the devicetree data.
>>>
>>> There are systes out there with literally dozens of temperature
>>> sensors. In many cases, those are purely for system health
>>> monitoring, not for thermal management. I don't want to end up in a
>>> situation where users complain about dozens of error messages on the
>>> console and no way to avoid it but providing dummy thermal subsystem
>>> data.
>>>
>>
>> Now I see.
>>
>>
>> Then I will rollback to the previous version in which lm sensors were
>> first probing for thermal properties within their dt node. Something l=
ike:
>> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
>> index dc96598..cb1c663 100644
>> --- a/drivers/hwmon/tmp102.c
>> +++ b/drivers/hwmon/tmp102.c
>> @@ -216,11 +216,13 @@ static int tmp102_probe(struct i2c_client *clien=
t,
>>                 goto fail_remove_sysfs;
>>         }
>>
>> -       tmp102->tz =3D thermal_zone_of_sensor_register(&client->dev, 0=
,
>> -                                                    &client->dev,
>> -                                                    tmp102_read_temp,=

>> NULL);
>> -       if (IS_ERR(tmp102->tz))
>> -               tmp102->tz =3D NULL;
>> +       if ((of_find_property(client->dev.of_node, "#sensor-cells", NU=
LL)) {
>> +               tmp102->tz =3D
>> thermal_zone_of_sensor_register(&client->dev, 0,
>> +                                                            &client->=
dev,
>> +
>> tmp102_read_temp, NULL);
>> +               if (IS_ERR(tmp102->tz))
>> +                       tmp102->tz =3D NULL;
>> +       }
>>
>>         dev_info(&client->dev, "initialized\n");
>>
>>
>> Does it sound reasonable?
>>
> Personally I would prefer if the registration code fails silently.
> Pushing the above code into each driver is just adding the same code
> repeatedly all over the place.

Fair enough. It becomes tedious and just duplicating code. I agree.

So I will keep the v2 I just sent and remove the annoying error messages
from of-thermal.c while registering the sensors.

>=20
> Also, each sensor instance will still result in an error if there
> is no global "thermal-zones" entry. Checking for that global entry
> in each driver would be even more excessive, and I just don't like
> that noisyness.
>=20
> Also, I think you'll need to create devicetree bindings documents
> for the two sensors.
>=20

Why would I? There is only one extra property and that is already
documented. I think the sensor still falls into the dummy dt node.

> Guenter
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--D9kjBGmus2G1QxnHP73AAnn6TMgeNRRb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlI5zK0ACgkQCXcVR3XQvP3YuAEAzkzcivYz9ciYlVPPykgEmaRq
6Kxyke20ZikedHvFIHAA/Axb9PjrwZxKFc3BOtt1y1TOFQebkY5wGwGORSZSSpdL
=jTks
-----END PGP SIGNATURE-----

--D9kjBGmus2G1QxnHP73AAnn6TMgeNRRb1--


--===============7193145785604461127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7193145785604461127==--

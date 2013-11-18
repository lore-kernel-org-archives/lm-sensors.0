From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Mon, 18 Nov 2013 14:27:41 +0000
Subject: Re: [lm-sensors] [PATCHv5 06/20] hwmon: lm75: expose to thermal fw via DT nodes
Message-Id: <528A23DD.2070406@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6319531977251344832=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-7-git-send-email-eduardo.valentin@ti.com> <20131115084354.656452b9@endymion.delvare>
In-Reply-To: <20131115084354.656452b9@endymion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

--===============6319531977251344832==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GJDxIMwtw5HB8VqIrMLWxE17K4uuuCD88"

--GJDxIMwtw5HB8VqIrMLWxE17K4uuuCD88
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15-11-2013 03:43, Jean Delvare wrote:
> Hi Eduardo,
>=20

Hello Jean!

> Sorry for joining the discussion a little late, I could never find the
> time to look into this patch series so far.

Well, better late than never, that's what it is said, isn't it? :-)
Thanks for arranging the time to look at these patches.

The patch series have been looked and contributed by several people and
a couple o maintainers now. Starts to be way better than the original
RFC. The core idea still holds though.

>=20
> On Tue, 12 Nov 2013 15:46:08 -0400, Eduardo Valentin wrote:
>> This patch adds to lm75 temperature sensor the possibility
>> to expose itself as thermal zone device, registered on the
>> thermal framework.
>>
>> The thermal zone is built only if a device tree node
>> describing a thermal zone for this sensor is present
>> inside the lm75 DT node. Otherwise, the driver behavior
>> will be the same.
>>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: lm-sensors@lm-sensors.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Guenter Roeck <linux@roeck-us.net>

On HWMON side, I got Guenter's solid contributions, as you can see.

>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>  drivers/hwmon/lm75.c | 35 ++++++++++++++++++++++++++++++-----
>>  1 file changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
>> index c03b490..1d3600a 100644
>> --- a/drivers/hwmon/lm75.c
>> +++ b/drivers/hwmon/lm75.c
>> @@ -27,6 +27,8 @@
>>  #include <linux/hwmon-sysfs.h>
>>  #include <linux/err.h>
>>  #include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/thermal.h>
>>  #include "lm75.h"
>> =20
>> =20
>> @@ -70,6 +72,7 @@ static const u8 LM75_REG_TEMP[3] =3D {
>>  /* Each client has this additional data */
>>  struct lm75_data {
>>  	struct device		*hwmon_dev;
>> +	struct thermal_zone_device	*tz;
>>  	struct mutex		update_lock;
>>  	u8			orig_conf;
>>  	u8			resolution;	/* In bits, between 9 and 12 */
>> @@ -90,22 +93,36 @@ static struct lm75_data *lm75_update_device(struct=
 device *dev);
>> =20
>>  /*-------------------------------------------------------------------=
----*/
>> =20
>> +static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
>> +{
>> +	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
>> +}
>> +
>>  /* sysfs attributes for hwmon */
>> =20
>> +static int lm75_read_temp(void *dev, long *temp)
>> +{
>> +	struct lm75_data *data =3D lm75_update_device(dev);
>> +
>> +	if (IS_ERR(data))
>> +		return PTR_ERR(data);
>> +
>> +	*temp =3D lm75_reg_to_mc(data->temp[0], data->resolution);
>> +
>> +	return 0;
>> +}
>> +
>>  static ssize_t show_temp(struct device *dev, struct device_attribute =
*da,
>>  			 char *buf)
>>  {
>>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
>>  	struct lm75_data *data =3D lm75_update_device(dev);
>> -	long temp;
>> =20
>>  	if (IS_ERR(data))
>>  		return PTR_ERR(data);
>> =20
>> -	temp =3D ((data->temp[attr->index] >> (16 - data->resolution)) * 100=
0)
>> -	       >> (data->resolution - 8);
>> -
>> -	return sprintf(buf, "%ld\n", temp);
>> +	return sprintf(buf, "%ld\n", lm75_reg_to_mc(data->temp[attr->index],=

>> +						    data->resolution));
>>  }
>=20
> I am a bit worried by this. I did expect that you'd have to split a
> piece of show_temp() into one separate function, not two. Here you have=

> quite some redundancy between lm75_read_temp and show_temp. Sure these
> are small functions so the duplicate code is limited, but if you
> multiply by the number of hwmon drivers which are candidates for this
> change, this all adds up.

Can you please elaborate a bit more on which way you think the code
above shall be improved? Are you suggesting we should make show_temp
call lm75_read_temp? On this specific case, I believe the code
duplication is minor, although I haven't measured.

>=20
>> =20
>>  static ssize_t set_temp(struct device *dev, struct device_attribute *=
da,
>> @@ -271,6 +288,13 @@ lm75_probe(struct i2c_client *client, const struc=
t i2c_device_id *id)
>>  		goto exit_remove;
>>  	}
>> =20
>> +	data->tz =3D thermal_zone_of_sensor_register(&client->dev,
>> +						   0,
>> +						   &client->dev,
>> +						   lm75_read_temp, NULL);
>=20
> I am also worried by this interface. Basically a separate callback
> function (here lm75_read_temp) is needed for every thermal input. Some
> hwmon drivers have many of these! This will result in duplicate code

The code registering a callback can actually have a private data, in
case you need to differentiate between inputs or in case you need to
derive specific data in order to access the correct input.

> again. If you could just pass a sensor ID as an extra parameter to
> lm75_read_temp, you could use the same callback for all sensors. This

Wouldn't the private pointer be enough?

I think it is a matter of checking what is the best way for the
candidates of users of this new API. In theory it is enough to hold the
ID on the data structure you pass through the void * parameter. However,
that would cause less impact if you have the users of the API already
structured in that way. Let me know what is best for your case.

> would maybe also let you refactor the code above, as I believe
> show_temp would then be able to call lm75_read_temp(dev, &temp, 0)
> instead of reimplementing most of it.
>=20
> I also note the lack of support for limits. Thermal zones can have
> limits, and the various hwmon drivers do support that, yet your
> interface offers no possibility to expose them. Wouldn't that be useful=
?
>=20
>> +	if (IS_ERR(data->tz))
>> +		data->tz =3D NULL;
>=20
> If you are doing that in all drivers, I would question the point of
> having thermal_zone_of_sensor_register() return a PTR_ERR in the first
> place.

Yeah, maybe it should simply return NULL in the fail path and drivers
would not need to bother about it. What do you think?

>=20
>> +
>>  	dev_info(&client->dev, "%s: sensor '%s'\n",
>>  		 dev_name(data->hwmon_dev), client->name);
>> =20
>> @@ -285,6 +309,7 @@ static int lm75_remove(struct i2c_client *client)
>>  {
>>  	struct lm75_data *data =3D i2c_get_clientdata(client);
>> =20
>> +	thermal_zone_of_sensor_unregister(&client->dev, data->tz);
>>  	hwmon_device_unregister(data->hwmon_dev);
>>  	sysfs_remove_group(&client->dev.kobj, &lm75_group);
>>  	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--GJDxIMwtw5HB8VqIrMLWxE17K4uuuCD88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKKI+EACgkQCXcVR3XQvP1x2AD9Fjz23HvvpYbtAyoYnOQEZyke
Gaq6BXAFSpM0xmT3dYYA/RcCywnEl51FXVJqyIRQ/pioX710uaBibYVKNErepGlm
=16tj
-----END PGP SIGNATURE-----

--GJDxIMwtw5HB8VqIrMLWxE17K4uuuCD88--


--===============6319531977251344832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6319531977251344832==--

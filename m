From: Cedric Le Goater <clg@fr.ibm.com>
Date: Fri, 20 Feb 2015 20:18:11 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] powerpc/powernv: Check OPAL sensor calls exist
Message-Id: <54E79683.2080605@fr.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-2-git-send-email-clg@fr.ibm.com>
 <20150220165306.GF22752@roeck-us.net>
In-Reply-To: <20150220165306.GF22752@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On 02/20/2015 05:53 PM, Guenter Roeck wrote:
> On Fri, Feb 20, 2015 at 04:07:35PM +0100, C=E9dric Le Goater wrote:
>=20
> You should explain here why this patch is needed.

Yes. What it does is to check that the firmware exposes the service
this driver is using (OPAL_SENSOR_READ). I will fix it.

Thanks,

C.=20


>=20
>> Signed-off-by: C=E9dric Le Goater <clg@fr.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/opal-sensor.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc=
/platforms/powernv/opal-sensor.c
>> index 4ab67ef7abc9..544292f2020f 100644
>> --- a/arch/powerpc/platforms/powernv/opal-sensor.c
>> +++ b/arch/powerpc/platforms/powernv/opal-sensor.c
>> @@ -72,6 +72,9 @@ static __init int opal_sensor_init(void)
>>  	struct platform_device *pdev;
>>  	struct device_node *sensor;
>> =20
>> +	if (!opal_check_token(OPAL_SENSOR_READ))
>> +		return -ENODEV;
>> +
>>  	sensor =3D of_find_node_by_path("/ibm,opal/sensors");
>>  	if (!sensor) {
>>  		pr_err("Opal node 'sensors' not found\n");
>> --=20
>> 1.7.10.4
>>
>=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

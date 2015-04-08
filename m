From: Cedric Le Goater <clg@fr.ibm.com>
Date: Wed, 08 Apr 2015 16:06:03 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (ibmpowernv) add support for the new device tree
Message-Id: <552551EB.9020808@fr.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150408152029.GA11030@roeck-us.net>
In-Reply-To: <20150408152029.GA11030@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On 04/08/2015 05:20 PM, Guenter Roeck wrote:
> On Wed, Apr 01, 2015 at 12:15:04PM +0200, C=E9dric Le Goater wrote:
>> The new OPAL device tree for sensors has a different layout and uses new
>> property names, for the type and for the handler used to capture the
>> sensor data.
>>
>> This patch modifies the ibmpowernv driver to support such a tree in a
>> way preserving compatibility with older OPAL firmwares.
>>
>> This is achieved by changing the error path of the routine parsing
>> an OPAL node name. The node is simply considered being from the new
>> device tree layout and fallback values are used.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@fr.ibm.com>
>=20
> Hi Cedric,
>=20
> I was about to apply the series, but then I found the following problem.
>=20
>> ---
>>  drivers/hwmon/ibmpowernv.c |   47 +++++++++++++++++++++++++++++++++++--=
-------
>>  1 file changed, 38 insertions(+), 9 deletions(-)
>>
> [ ... ]
>> =20
>> @@ -189,11 +204,16 @@ static u32 get_sensor_hwmon_index(struct sensor_da=
ta *sdata,
>>  {
>>  	int i;
>> =20
>> -	for (i =3D 0; i < count; i++)
>> -		if (sdata_table[i].opal_index =3D=3D sdata->opal_index &&
>> -		    sdata_table[i].type =3D=3D sdata->type)
>> -			return sdata_table[i].hwmon_index;
>> +	/*
>> +	 * We don't use the OPAL index on newer device trees
>> +	 */
>> +	if (sdata->opal_index !=3D -1) {
>=20
> opal_index is u32, so this won't work (or at least the result is
> unpredictable).
>=20
> Also, in patch 4/4 (v4), get_logical_cpu() takes unsigned int as paramete=
r,
> but get_hard_smp_processor_id() returns an int, causing gcc to complain
> if the code is built with W=3D1.
>=20
> Please fix and resubmit the entire series.
>=20
> When you do that, please also ensure that continuation lines
> are aligned (in patch 3/4).

Sure. Working on it right now.

Thanks,

C.=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

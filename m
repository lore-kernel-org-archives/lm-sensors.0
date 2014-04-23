From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 23 Apr 2014 23:43:04 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (lm92) Drop function macros
Message-Id: <53585008.5030502@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140421034351.GA11607@roeck-us.net>
In-Reply-To: <20140421034351.GA11607@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 04/23/2014 09:30 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun, 20 Apr 2014 20:43:51 -0700, Guenter Roeck wrote:
>> Function macros obfuscate code and increase code size, so drop them.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Drop comma after t_num_regs
>>      Declare register array as const and with explicit size
>>
>>   drivers/hwmon/lm92.c |  165 +++++++++++++++++++++++++-----------------=
--------
>>   1 file changed, 82 insertions(+), 83 deletions(-)
>> (...)
>> +static ssize_t set_temp(struct device *dev, struct device_attribute *de=
vattr,
>> +			   const char *buf, size_t count)
>>   {
>> -	struct lm92_data *data =3D lm92_update_device(dev);
>> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_crit)
>> -		       - TEMP_FROM_REG(data->temp1_hyst));
>> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
>> +	struct i2c_client *client =3D to_i2c_client(dev);
>> +	struct lm92_data *data =3D i2c_get_clientdata(client);
>> +	int nr =3D attr->index;
>> +	long val;
>> +	int err =3D kstrtol(buf, 10, &val);
>
> I would separate variable declaration from actual code here, that would
> be easier to read and would be consistent with the code in
> set_temp_hyst().
>
>> +	if (err)
>> +		return err;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	data->temp[nr] =3D TEMP_TO_REG(val);
>> +	i2c_smbus_write_word_swapped(client, regs[nr], data->temp[nr]);
>> +	mutex_unlock(&data->update_lock);
>> +	return count;
>>   }
>
> Other than this it looks good to me, although I can't test. Do you
> happen to have a register dump from an LM92, MAX6635 or any compatible
> chip?
>

Here you are, for LM92:

      0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: 380c b800 0001 0028 0005 0020 0020 0180
08: 380c b800 0001 0028 0005 0020 0020 0180
10: 380c b800 0001 0028 0005 0020 0020 0180
18: 380c b800 0001 0028 0005 0020 0020 0180
20: 380c b800 0001 0028 0005 0020 0020 0180
28: 380c b800 0001 0028 0005 0020 0020 0180
30: 380c b800 0001 0028 0005 0020 0020 0180
38: 380c b800 0001 0028 0005 0020 0020 0180
40: 380c b800 0001 0028 0005 0020 0020 0180
48: 380c b800 0001 0028 0005 0020 0020 0180
50: 380c b800 0001 0028 0005 0020 0020 0180
58: 380c b800 0001 0028 0005 0020 0020 0180
60: 380c b800 0001 0028 0005 0020 0020 0180
68: 380c b800 0001 0028 0005 0020 0020 0180
70: 380c b800 0001 0028 0005 0020 0020 0180
78: 380c b800 0001 0028 0005 0020 0020 0180
80: 380c b800 0001 0028 0005 0020 0020 0180
88: 380c b800 0001 0028 0005 0020 0020 0180
90: 380c b800 0001 0028 0005 0020 0020 0180
98: 380c b800 0001 0028 0005 0020 0020 0180
a0: 380c b800 0001 0028 0005 0020 0020 0180
a8: 380c b800 0001 0028 0005 0020 0020 0180
b0: 380c b800 0001 0028 0005 0020 0020 0180
b8: 380c b800 0001 0028 0005 0020 0020 0180
c0: 380c b800 0001 0028 0005 0020 0020 0180
c8: 380c b800 0001 0028 0005 0020 0020 0180
d0: 380c b800 0001 0028 0005 0020 0020 0180
d8: 380c b800 0001 0028 0005 0020 0020 0180
e0: 380c b800 0001 0028 0005 0020 0020 0180
e8: 380c b800 0001 0028 0005 0020 0020 0180
f0: 380c b800 0001 0028 0005 0020 0020 0180
f8: 380c b800 0001 0028 0005 0020 0020 0180

Matching output from sensors command:

lm92-i2c-9-48
Adapter: i2c-diolan-u2c at bus 003 device 013
temp1:        +24.1=B0C  (low  =3D +10.0=B0C)
                        (high =3D +64.0=B0C, hyst =3D +62.0=B0C)
                        (crit =3D +80.0=B0C, hyst =3D +78.0=B0C)

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

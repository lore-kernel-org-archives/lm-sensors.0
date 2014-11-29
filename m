From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 29 Nov 2014 18:00:10 +0000
Subject: Re: [lm-sensors] [PATCH] i8k: Add support for temperature sensor labels
Message-Id: <547A09AA.9010505@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417277047-15489-1-git-send-email-pali.rohar@gmail.com> <20141129174315.GA32132@kroah.com>
In-Reply-To: <20141129174315.GA32132@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Steven Honeyman <stevenhoneyman@gmail.com>, linux-kernel@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>, "lm-sensors >> LM Sensors" <lm-sensors@lm-sensors.org>

On 11/29/2014 09:43 AM, Greg Kroah-Hartman wrote:
> On Sat, Nov 29, 2014 at 05:04:07PM +0100, Pali Roh=E1r wrote:
>> This patch adds labels for temperature sensors if SMM function with EAX =
register
>> 0x11a3 reports it. These informations was taken from DOS binary NBSVC.MD=
M.
>>
>> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
>> ---
>>   drivers/char/i8k.c |  110 +++++++++++++++++++++++++++++++++++++++++---=
--------
>>   1 file changed, 88 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
>> index e34a019..77af46b 100644
>> --- a/drivers/char/i8k.c
>> +++ b/drivers/char/i8k.c
>> @@ -42,6 +42,7 @@
>>   #define I8K_SMM_GET_FAN		0x00a3
>>   #define I8K_SMM_GET_SPEED	0x02a3
>>   #define I8K_SMM_GET_TEMP	0x10a3
>> +#define I8K_SMM_GET_TEMP_TYPE	0x11a3
>>   #define I8K_SMM_GET_DELL_SIG1	0xfea3
>>   #define I8K_SMM_GET_DELL_SIG2	0xffa3
>>
>> @@ -288,6 +289,14 @@ static int i8k_set_fan(int fan, int speed)
>>   	return i8k_smm(&regs) ? : i8k_get_fan_status(fan);
>>   }
>>
>> +static int i8k_get_temp_type(int sensor)
>> +{
>> +	struct smm_regs regs =3D { .eax =3D I8K_SMM_GET_TEMP_TYPE, };
>> +
>> +	regs.ebx =3D sensor & 0xff;
>> +	return i8k_smm(&regs) ? : regs.eax & 0xff;
>> +}
>> +
>>   /*
>>    * Read the cpu temperature.
>>    */
>> @@ -493,6 +502,29 @@ static int i8k_open_fs(struct inode *inode, struct =
file *file)
>>    * Hwmon interface
>>    */
>>
>> +static ssize_t i8k_hwmon_show_temp_label(struct device *dev,
>> +				   struct device_attribute *devattr,
>> +				   char *buf)
>> +{
>> +	static const char * const labels[] =3D {
>> +		"CPU",
>> +		"GPU",
>> +		"SODIMM",
>> +		"Other",
>> +		"Ambient",
>> +		"Other",
>> +	};Documentation/hwmon/
>> +	int index =3D to_sensor_dev_attr(devattr)->index;
>> +	int type;
>> +
>> +	type =3D i8k_get_temp_type(index);
>> +	if (type < 0)
>> +		return type;
>> +	if (type >=3D ARRAY_SIZE(labels))
>> +		type =3D ARRAY_SIZE(labels) - 1;
>> +	return sprintf(buf, "%s\n", labels[type]);
>> +}
>
> No Documentation/ABI/ entry for your new sysfs file?
>
That would be Documentation/hwmon/sysfs-interface,
presumably for historic reasons (its existence precedes
the existence of Documentation/ABI).

Question might be if we should move that file at some point
to Documentation/ABI/<some-name>, though that would be a
major effort.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Johannes Winkelmann <johannes.winkelmann@gmail.com>
Date: Fri, 20 Jul 2012 15:13:51 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon: add support for Sensirion C1 sensor
Message-Id: <CAEYbzYsu_xhXJgbYKPj-rz-d26wTTM98+oyEDWbXMO5VNC5sgw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342789042-13433-1-git-send-email-johannes.winkelmann@sensirion.com>
	<6190165.D1PKLQQHEK@linux-lqwf.site>
In-Reply-To: <6190165.D1PKLQQHEK@linux-lqwf.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Johannes Winkelmann <johannes.winkelmann@sensirion.com>

On Fri, Jul 20, 2012 at 4:03 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Friday 20 July 2012 14:57:22 Johannes Winkelmann wrote:
>
>> +/* sysfs attributes */
>> +static struct shtc1_data *shtc1_update_client(struct device *dev)
>> +{
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     struct shtc1_data *data = i2c_get_clientdata(client);
>> +
>> +     char buf[SHTC1_RESPONSE_LENGTH];
>
> Is this used for DMA?

No

>
>> +     int val;
>> +     int ret;
>> +
>> +     mutex_lock(&data->update_lock);
>> +
>> +     /*
>> +      * initialize 'ret' in case we had a valid result before, but
>> +      * read too quickly in which case we return the last values
>> +      */
>> +     ret = !data->valid;
>> +
>> +     if (time_after(jiffies, data->last_updated + HZ / 10)
>> +         || !data->valid) {
>> +             ret = shtc1_update_values(client, data, buf, sizeof(buf));
>> +
>> +             if (ret)
>> +                     goto out;
>> +
>> +             /*
>> +              * From datasheet:
>> +              *   T = -45 + 175 * ST / 2^16
>> +              *   RH = -10 + 120 * SRH / 2^16
>> +              *
>> +              * Adapted for integer fixed point (3 digit) arithmetic
>> +              */
>> +             val = (buf[0] << 8) | buf[1];
>> +             data->temperature = ((21875 * val) >> 13) - 45000;
>> +             val = (buf[3] << 8) | buf[4];
>
> We have dedicated macros for conversion of endianness.

Like this:
		val = swab16p((__le16 *)buf);
		data->temperature = ((21875 * val) >> 13) - 45000;
		val = swab16p((__le16 *)(buf+2));
		data->humidity = ((15000 * val) >> 13) - 10000;


>
>> +             data->humidity = ((15000 * val) >> 13) - 10000;
>> +
>> +             data->last_updated = jiffies;
>> +             data->valid = 1;
>> +     }
>> +
>> +out:
>> +     mutex_unlock(&data->update_lock);
>> +
>> +     return ret = 0 ? data : NULL;
>> +}
>         Regards
>                 Oliver
>

Thanks, Johannes

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

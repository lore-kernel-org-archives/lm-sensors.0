From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2014 08:55:59 +0000
Subject: Re: [lm-sensors] [PATCH v2] powerpc/powernv: hwmon driver for power values, fan rpm and temperature
Message-Id: <53A1514F.30907@linux.vnet.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140519141931.9248.11356.stgit@neelegup-tp-t420.in.ibm.com>
 <53858F02.2020808@roeck-us.net>
In-Reply-To: <53858F02.2020808@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de, lm-sensors@lm-sensors.org
Cc: sbhat@linux.vnet.ibm.com


>> +}
>> +
>> +static void __init get_sensor_index_attr(const char *name, u32 
>> *index, char *attr)
>> +{
>> +    char *hash_pos = strchr(name, '#');
>> +    char *dash_pos;
>> +    u32 copy_len;
>> +    char buf[8];
>> +
>> +    memset(buf, 0, sizeof(buf));
>> +    *index = 0;
>> +    *attr = '\0';
>> +
>> +    if (hash_pos) {
>> +        dash_pos = strchr(hash_pos, '-');
>> +        if (dash_pos) {
>> +            copy_len = dash_pos - hash_pos - 1;
>> +            if (copy_len < sizeof(buf)) {
>> +                strncpy(buf, hash_pos + 1, copy_len);
>> +                sscanf(buf, "%d", index);
>
> What if sscanf fails ? Might be an interesting exercise to try and create
> multiple sensors with index 0 (or, for that matter, with the same 
> index value).
> Do you have any protection against bad input data ? Guess not; did you 
> test
> what happens if you pass bad data to the driver (such as duplicate sensor
> entries) ?

We can't have duplicate entries in the device tree under the same node ?
But yes, rest other scenarios must be validated.

- Neelesh

>
>> +            }
>> +
>> +            strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
>> +        }
>> +    }
>> +}
>> +
>> +
>>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

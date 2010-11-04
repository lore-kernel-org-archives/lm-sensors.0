From: Henrik Rydberg <rydberg@euromail.se>
Date: Thu, 04 Nov 2010 08:20:18 +0000
Subject: Re: [lm-sensors] [PATCH 2/8] hwmon: applesmc: Introduce a register
Message-Id: <4CD26CC2.7070401@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se> <1288511434-5662-3-git-send-email-rydberg@euromail.se> <20101104042121.GA19231@ericsson.com>
In-Reply-To: <20101104042121.GA19231@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Guenter,

>> @@ -217,14 +235,13 @@ static unsigned int fans_handled;

>>  /* Indicates which temperature sensors set to use. */
>>  static unsigned int applesmc_temperature_set;
>>
>> -static DEFINE_MUTEX(applesmc_lock);
>> -
>>  /*
>>   * Last index written to key_at_index sysfs file, and value to use for all other
>>   * key_at_index_* sysfs files.
>>   */
>>  static unsigned int key_at_index;
>>
>> +
> 
> unnecessary blank line


Ironically, I even tried to get rid out it two times. ;-)

>> +static int applesmc_get_entry_by_index(int index, struct applesmc_entry *entry)
>> +{
> 
> One thing I don't understand about the whole caching scheme - why don't you just
> return (and use) a pointer to the cached entry ? Seems to me that would be much simpler.
> If you want to return error types, you could use ERR_PTR, PTR_ERR, and IS_ERR.


Yes, the return types are important. I can change this, it will reduce the patch
by some lines.

>> +       struct applesmc_entry *cache = &smcreg.entry[index];
>> +       __be32 be;
>> +       int ret;
>> +
>> +       if (cache->valid) {
>> +               memcpy(entry, cache, sizeof(*entry));
>> +               return 0;
>>         }
>> -       key[4] = 0;
>>
>> -       return 0;
>> +       mutex_lock(&smcreg.mutex);


Note to self: it is possible to arrive here with a valid cache. If pointers are
used, exit to avoid incoherent reads.

>> +
>> +       be = cpu_to_be32(index);
>> +       ret = read_smc(APPLESMC_GET_KEY_BY_INDEX_CMD, (u8 *)&be, cache->key, 4);
>> +       if (ret)
>> +               goto out;
>> +       ret = read_smc(APPLESMC_GET_KEY_TYPE_CMD, cache->key, &cache->len, 6);
> 
> This one is a bit odd. cache->len is an u8. You are reading 6 bytes into it.
> I assume this is supposed to fill both cache->len and cache->type in a single operation.


True.


> Not sure if this is a good idea. Seems to depend a lot on the assumption that
> fields are consecutive. Might be safer to read the data into a temporary
> 6 byte buffer and copy it into ->len and ->type afterwards.


Right, there could be alignment problems here. Thanks.

> If that is not acceptable, please add a comment describing what you are doing here
> and why.


It was just about the extra stack space. There will be a natural place for the
buffer once the pointer are used.

>> +       if (ret)
>> +               goto out;
>> +
>> +       cache->type[4] = 0;
> 
> Why read 6 bytes above if you overwrite the last byte anyway ?


Backwards compatibility reasons. The register type names have been used as four
byte strings since the beginning. I do not know is the last value codes
something else - I can make that clearer by reserving a byte in the struct instead.

> 
>> +       cache->valid = 1;


Continued note to self: a switch here is not handled properly.

>> +       memcpy(entry, cache, sizeof(*entry));
>> +
>> +out:
>> +       mutex_unlock(&smcreg.mutex);
>> +       return ret;
>>  }



>> +/*
>> + * applesmc_init_smcreg_try - Try to initialize register cache. Idempotent.
>> + */
>> +static int applesmc_init_smcreg_try(void)
>> +{
>> +       struct applesmc_registers *s = &smcreg;
>> +       int ret;
>> +
>> +       if (s->init_complete)
>> +               return 0;
>> +
>> +       mutex_init(&s->mutex);
>> +
>> +       ret = read_register_count(&s->key_count);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!s->entry)
>> +               s->entry = kcalloc(s->key_count, sizeof(*s->entry), GFP_KERNEL);
>> +       if (!s->entry)
>> +               return -ENOMEM;
>> +
>> +       s->init_complete = true;
>> +
>> +       pr_info("key=%d\n", s->key_count);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * applesmc_init_smcreg - Initialize register cache.
>> + *
>> + * Retries until initialization is successful, or the operation times out.
>> + *
>> + */
>> +static int applesmc_init_smcreg(void)
>> +{
>> +       int ms, ret;
>> +
>> +       for (ms = 0; ms < INIT_TIMEOUT_MSECS; ms += INIT_WAIT_MSECS) {
>> +               ret = applesmc_init_smcreg_try();
>> +               if (!ret)
>> +                       return 0;
>> +               pr_warn("slow init, retrying\n");
>> +               msleep(INIT_WAIT_MSECS);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void applesmc_destroy_smcreg(void)
>> +{
>> +       kfree(smcreg.entry);
>> +       smcreg.entry = NULL;
> 
> Do you also have to reset init_complete ?


Yes!

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

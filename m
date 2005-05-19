From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH][I2C] ST M41T00 I2C RTC chip driver
Message-Id: <42002DFB.2090203@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FE7368.1000307@mvista.com>
In-Reply-To: <41FE7368.1000307@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the contribution.
the ST M41xx product line is a good one, lots of variants,
I've used the 41T80 which adds an interrupt output but
unfortunately has a slightly different register layout.

The reason for using smbus calls instead of i2c_transfer is that
now you will work with any bus master rather than just
the pure i2c bit-bangers. So no matter what the hardware setup
the driver will work. That's why the smbus calls are "preferred".
You could use smbus_i2c_read_i2c_block_data() to get the efficiency back,
but most smbus drivers don't support that. So you did it right to
design for maximum flexibility.

mds


Mark A. Greer wrote:
> Thank you for your comments, Jean.
> 
> Jean Delvare wrote:
> 
>> Hi Mark,
>>
>>  
>>
>>> +      This driver can also be built as a module.  If so, the module
>>> +      will be called i2c-m41t00.
>>>   
>>
>>
>> It'll actually be called m41t00, according to the Makefile.
>>
> 
> Good catch.
> 
>>  
>>
>>> +struct m41t00_data {
>>> +    struct i2c_client client;
>>> +};
>>>   
>>
>>
>> You don't have to do that. Including the i2c_client stucture in the data
>> structure is a trick which let us get both allocated with a single
>> kmalloc (and freed with a single kfree) while still respecting the
>> arch-dependent alignment requirements. If you have no private data to
>> carry around, you can do the kmalloc on the i2c_client structure
>> directly, and have client->data point to NULL (which it actually already
>> does thanks to memset). This will save some code in both the detection
>> and the detach functions.
>>
>> However, if you know that, in a future update of this driver, you *will*
>> have to store client-private data, then I guess you can keep it this way.
>>
> 
> Its gone.
> 
>>> +    i2c_detach_client(client);
>>>   
>>
>>
>> This one supposedly can fail.
>>
> 
> Okay, I'll check.
> 
>>  
>>
>>> +    .name        = "M41T00",
>>>   
>>
>>
>> No caps in name please (will be used in sysfs).
>>
> 
> Done.
> 
>>
>>  
>>
>>> +static int __devinit
>>> +m41t00_init(void)
>>> +{
>>> +    return i2c_add_driver(&m41t00_driver);
>>> +}
>>>
>>> +static void __devexit
>>> +m41t00_exit(void)
>>> +{
>>> +    i2c_del_driver(&m41t00_driver);
>>> +    return;
>>> +}
>>>   
>>
>>
>> Should be __init and __exit, respectively, unless I am mistaken. And the
>> last return is usless.
>>
> 
> I thought the __devxxx ones were the best ones to use but I don't know 
> for sure.  I'll change them to __init/__exit.
> 
>>
>> I'm also suspicious about the other __devexit and __devinit you used. No
>> other i2c chip drivers has them.
>>  
>>
> 
> Done.
> 
> Here is a replacement patch that should address Jean Delvare and Dick 
> Johnson's issues.  Please let me know if there are any more issues.
> 
> Thanks,
> 
> Mark

From: Anish Patel <anish.mailing.list@gmail.com>
Date: Tue, 18 Jan 2011 00:46:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm93) Add support for LM94
Message-Id: <4D34E2EC.8050500@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D34C19A.7070707@gmail.com>
In-Reply-To: <4D34C19A.7070707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/17/11 17:47, Guenter Roeck wrote:
> On Mon, 2011-01-17 at 17:24 -0500, Anish Patel wrote:
>> please add device id 0x7a for the LM94 as well.
>>
> Hint - top posting is discouraged.
>
sorry, won't do it again
> I don't mind, but not even the "official" datasheet from National (dated
> 07/15/2010) lists 0x7a as supported stepping. Do you have information
> that this version of the chip exists ?
yes, i have about 15 boards here with an LM94 that have the 0x7a ID
i will post the i2cdump tomorrow morning.
> Thanks,
> Guenter
>
>> thanks
>>
>> On 01/17/11 17:41, Guenter Roeck wrote:
>>> This patch adds basic support for LM94 to the LM93 driver. LM94 specific
>>> sensors and features are not supported.
>>>
>>> Signed-off-by: Guenter Roeck<guenter.roeck@ericsson.com>
>>> ---
>>>    Documentation/hwmon/lm93 |    7 +++++++
>>>    drivers/hwmon/lm93.c     |   19 +++++++++++++++++--
>>>    2 files changed, 24 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/hwmon/lm93 b/Documentation/hwmon/lm93
>>> index 7a10616..f3b2ad2 100644
>>> --- a/Documentation/hwmon/lm93
>>> +++ b/Documentation/hwmon/lm93
>>> @@ -6,6 +6,10 @@ Supported chips:
>>>        Prefix 'lm93'
>>>        Addresses scanned: I2C 0x2c-0x2e
>>>        Datasheet: http://www.national.com/ds.cgi/LM/LM93.pdf
>>> +  * National Semiconductor LM94
>>> +    Prefix 'lm94'
>>> +    Addresses scanned: I2C 0x2c-0x2e
>>> +    Datasheet: http://www.national.com/ds.cgi/LM/LM94.pdf
>>>
>>>    Authors:
>>>    	Mark M. Hoffman<mhoffman@lightlink.com>
>>> @@ -56,6 +60,9 @@ previous motherboard management ASICs and uses some of the LM85's features
>>>    for dynamic Vccp monitoring and PROCHOT. It is designed to monitor a dual
>>>    processor Xeon class motherboard with a minimum of external components.
>>>
>>> +LM94 is also supported in LM93 compatible mode. Extra sensors and features of
>>> +LM94 are not supported.
>>> +
>>>
>>>    User Interface
>>>    --------------
>>> diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
>>> index c9ed14e..4a8b984 100644
>>> --- a/drivers/hwmon/lm93.c
>>> +++ b/drivers/hwmon/lm93.c
>>> @@ -135,6 +135,10 @@
>>>    #define LM93_MFR_ID		0x73
>>>    #define LM93_MFR_ID_PROTOTYPE	0x72
>>>
>>> +/* LM94 REGISTER VALUES */
>>> +#define LM94_MFR_ID		0x79
>>> +#define LM94_MFR_ID_PROTOTYPE	0x78
>>> +
>>>    /* SMBus capabilities */
>>>    #define LM93_SMBUS_FUNC_FULL (I2C_FUNC_SMBUS_BYTE_DATA | \
>>>    		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA)
>>> @@ -2504,6 +2508,7 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
>>>    {
>>>    	struct i2c_adapter *adapter = client->adapter;
>>>    	int mfr, ver;
>>> +	const char *name;
>>>
>>>    	if (!i2c_check_functionality(adapter, LM93_SMBUS_FUNC_MIN))
>>>    		return -ENODEV;
>>> @@ -2517,13 +2522,22 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
>>>    	}
>>>
>>>    	ver = lm93_read_byte(client, LM93_REG_VER);
>>> -	if (ver != LM93_MFR_ID&&   ver != LM93_MFR_ID_PROTOTYPE) {
>>> +	switch (ver) {
>>> +	case LM93_MFR_ID:
>>> +	case LM93_MFR_ID_PROTOTYPE:
>>> +		name = "lm93";
>>> +		break;
>>> +	case LM94_MFR_ID:
>>> +	case LM94_MFR_ID_PROTOTYPE:
>>> +		name = "lm94";
>>> +		break;
>>> +	default:
>>>    		dev_dbg(&adapter->dev,
>>>    			"detect failed, bad version id 0x%02x!\n", ver);
>>>    		return -ENODEV;
>>>    	}
>>>
>>> -	strlcpy(info->type, "lm93", I2C_NAME_SIZE);
>>> +	strlcpy(info->type, name, I2C_NAME_SIZE);
>>>    	dev_dbg(&adapter->dev,"loading %s at %d,0x%02x\n",
>>>    		client->name, i2c_adapter_id(client->adapter),
>>>    		client->addr);
>>> @@ -2602,6 +2616,7 @@ static int lm93_remove(struct i2c_client *client)
>>>
>>>    static const struct i2c_device_id lm93_id[] = {
>>>    	{ "lm93", 0 },
>>> +	{ "lm94", 0 },
>>>    	{ }
>>>    };
>>>    MODULE_DEVICE_TABLE(i2c, lm93_id);
>
>




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

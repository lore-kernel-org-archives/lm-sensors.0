From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Dec 2014 14:12:47 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm95234) Add support for LM95233
Message-Id: <547DC8DF.7020802@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417383473-10328-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417383473-10328-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/02/2014 04:07 AM, Jean Delvare wrote:
> On Sun, 30 Nov 2014 13:37:53 -0800, Guenter Roeck wrote:
>> LM95233 is similar to LM95234, but it only supports two
>> instead of four external temperature sensors.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Update Kconfig
>>      Improve detection code (add more checks)
>>      Update MODULE_DESCRIPTION
>>
>>   Documentation/hwmon/lm95234 | 15 +++++---
>>   drivers/hwmon/Kconfig       |  6 +--
>>   drivers/hwmon/lm95234.c     | 91 ++++++++++++++++++++++++++++++++-------------
>>   3 files changed, 78 insertions(+), 34 deletions(-)
>> (...)
>> diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
>> index 411202b..af8fabd 100644
>> --- a/drivers/hwmon/lm95234.c
>> +++ b/drivers/hwmon/lm95234.c
>> (...)
>> @@ -622,15 +641,31 @@ static int lm95234_detect(struct i2c_client *client,
>>   		return -ENODEV;
>>
>>   	chip_id = i2c_smbus_read_byte_data(client, LM95234_REG_CHIP_ID);
>> -	if (chip_id != LM95234_CHIP_ID)
>> +	switch(chip_id) {
>
> Missing space here again. Other than that:
>
Fixed.

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

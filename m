From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jun 2014 13:07:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] sensors-detect: Add detection of various TI chips
Message-Id: <53AC1B2A.1090300@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359434448-21181-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359434448-21181-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/26/2014 02:07 AM, Jean Delvare wrote:
> Hi Guenter,
>
> You got my address wrong again ;-)
>
> On Wed, 25 Jun 2014 13:42:25 -0700, Guenter Roeck wrote:
>> Detect TMP441, TMP442, LM95233, LM95234, LM95235.
>> Strengthen detection of TMP421/TMP422/TMP423
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   CHANGES                    |  2 ++
>>   prog/detect/sensors-detect | 49 ++++++++++++++++++++++++++++++++++++++++------
>>   2 files changed, 45 insertions(+), 6 deletions(-)
>>
>> diff --git a/CHANGES b/CHANGES
>> index 240ba9f..3390942 100644
>> --- a/CHANGES
>> +++ b/CHANGES
>> @@ -11,6 +11,8 @@ SVN HEAD
>>     sensors-detect: Add detection of ADC128D818
>>                     Add detection of AMD family 16h Kabini and Mullins
>>                     Add detection of ITE IT8620E and IT8623E
>> +                  Add detection of TMP441, TMP442, LM95233, LM95234,
>> +                  and LM95235
>>
>>   3.3.5 "Happy Birthday Beddy" (2014-01-22)
>>     libsensors: Improve documentation of two functions
>> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
>> index 51b4936..df9a408 100755
>> --- a/prog/detect/sensors-detect
>> +++ b/prog/detect/sensors-detect
>> @@ -1033,6 +1033,16 @@ use vars qw(@i2c_adapter_names);
>>   		i2c_addrs => [0x4c, 0x4d],
>>   		i2c_detect => sub { lm90_detect(@_, 17); },
>>   	}, {
>> +		name => "Texas Instruments TMP441",
>> +		driver => "tmp421",
>> +		i2c_addrs => [0x1c..0x1f, 0x2a, 0x4c..0x4f],
>> +		i2c_detect => sub { tmp42x_detect(@_, 3); },
>> +	}, {
>> +		name => "Texas Instruments TMP442",
>> +		driver => "tmp421",
>> +		i2c_addrs => [0x1c..0x1f, 0x2a, 0x4c..0x4f],
>> +		i2c_detect => sub { tmp42x_detect(@_, 4); },
>> +	}, {
>
> According to the datasheet, the TMP442 has no address pins, so its
> slave address is fixed. The TMP442A has address 0x4c, and the TMP442B
> has address 0x4d, so these would be the only two possible addresses,
> much like for the TMP423.
>

Ok.

>>   		name => "Texas Instruments TMP451",
>>   		driver => "lm90",
>>   		i2c_addrs => [0x4c],
>> @@ -1048,11 +1058,21 @@ use vars qw(@i2c_adapter_names);
>>   		i2c_addrs => [0x2b, 0x19, 0x2a],
>>   		i2c_detect => sub { lm95231_detect(@_, 0); },
>>   	}, {
>> +		name => "National Semiconductor LM95233",
>> +		driver => "lm95234",
>> +		i2c_addrs => [0x18, 0x2a, 0x2b],
>> +		i2c_detect => sub { lm95231_detect(@_, 5); },
>> +	}, {
>>   		name => "National Semiconductor LM95234",
>> -		driver => "to-be-written",		# lm95234
>> +		driver => "lm95234",
>>   		i2c_addrs => [0x18, 0x4d, 0x4e],
>>   		i2c_detect => sub { lm95231_detect(@_, 3); },
>>   	}, {
>> +		name => "National Semiconductor LM95235",
>> +		driver => "lm95245",
>> +		i2c_addrs => [0x18, 0x29, 0x4c],
>> +		i2c_detect => sub { lm95231_detect(@_, 4); },
>> +	}, {
>>   		name => "National Semiconductor LM95241",
>>   		driver => "lm95241",
>>   		i2c_addrs => [0x2b, 0x19, 0x2a],
>> @@ -4765,9 +4785,11 @@ sub lm90_detect
>>   	return;
>>   }
>>
>> -# Chip to detect: 0 = TMP421, 1 = TMP422, 2 = TMP423
>> +# Chip to detect: 0 = TMP421, 1 = TMP422, 2 = TMP423, 3 = TMP441, 4 = TMP442
>>   # Registers used:
>> -#   0xfe: Manufactorer ID
>> +#   0x08: Status (7 unused bits)
>> +#   0x0b: Conversion rate (value 0x07 or lower)
>> +#   0xfe: Manufacturer ID
>>   #   0xff: Device ID
>>   sub tmp42x_detect()
>>   {
>> @@ -4775,12 +4797,18 @@ sub tmp42x_detect()
>>
>>   	my $mid = i2c_smbus_read_byte_data($file, 0xfe);
>>   	my $cid = i2c_smbus_read_byte_data($file, 0xff);
>> +	my $status = i2c_smbus_read_byte_data($file, 0x08);
>> +	my $rate = i2c_smbus_read_byte_data($file, 0x0b);
>>
>>   	return if ($mid != 0x55);
>> +	return if ($status & 0x7f);
>> +	return if ($rate > 0x07);
>
> These extra checks could be added to the tmp421 driver too.
>
I actually have a patch ready to do just that (since April ;-),
I only didn't have time to send it out.

> All the rest looks good, feel free to commit.
>

Will do. Thanks a lot for the review.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

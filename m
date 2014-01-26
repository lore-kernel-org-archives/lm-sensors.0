From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 26 Jan 2014 00:13:51 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of TI ADC128D818
Message-Id: <52E4533F.90800@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 01/25/2014 02:05 PM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat, 25 Jan 2014 09:54:51 -0800, Guenter Roeck wrote:
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   CHANGES                    |    3 +++
>>   prog/detect/sensors-detect |   26 +++++++++++++++++++++-----
>>   2 files changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/CHANGES b/CHANGES
>> index e1347a6..970dd67 100644
>> --- a/CHANGES
>> +++ b/CHANGES
>> @@ -1,6 +1,9 @@
>>   lm-sensors CHANGES file
>>   -----------------------
>>
>> +SVN HEAD
>> +  sensors-detect: Add detection of ADC128D818
>> +
>>   3.3.5 "Happy Birthday Beddy" (2014-01-22)
>>     libsensors: Improve documentation of two functions
>>                 Increase MAX_SENSORS_PER_TYPE to 33
>> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
>> index a2093f3..2136b76 100755
>> --- a/prog/detect/sensors-detect
>> +++ b/prog/detect/sensors-detect
>> @@ -547,6 +547,11 @@ use vars qw(@i2c_adapter_names);
>>   		i2c_addrs => [0x28..0x2f],
>>   		i2c_detect => sub { lm80_detect(@_, 1); },
>>   	}, {
>> +		name => "TI / National Semiconductor ADC128D818",
>> +		driver => "adc128d818",
>> +		i2c_addrs => [0x1d, 0x1e, 0x1f, 0x2d, 0x2e, 0x2f, 0x35, 0x36, 0x37],
>> +		i2c_detect => sub { lm80_detect(@_, 2); },
>
> How does this relate to the LM80?
>
> Is this chip really something people will need sensors-detect for (i.e.
> it is found in PC-like computers) or something which will be always
> declared in DT-like declarations anyway?
>
No idea, really. I was asked by someone from TI to write a driver some time ago,
and finally found the time to actually do it. I recall they had a request
from a customer, but I did not ask for the use case.

The chip is a close relative to LM80 and LM96080. Register addresses are
almost the same, but the sensor registers are 16 bit wide instead of 8,
and there are no fan registers. I didn't use the lm80 driver because of
the 16 bit registers, but decided to write a new one.

> I'm asking because I am worried about the address list. I'm fine with
> 0x1d..0x1f and 0x2d..0x2f (you can declare them that way in perl BTW,
> it's more compact) but addresses 0x35..0x37 we don't currently scan.
> Adding a new address to the scan list is always a risk, as you may start
> probing a whole new class of devices and the effects can be very bad.
>
> Actually we used to scan address 0x37 until r3233 / 2006-01-16. Commit
> message was:
>
> "Lower the confidence of ITE overclocking chips. Do not scan
> address 0x37 for these chips, as it may cause problem with some
> eeproms."
>
> Addresses 0x35 and 0x36 I don't think we ever scanned, but EEPROMs can
> reply to these as well so I'd rather not add them.
>
Ok with me to take out those three addresses ... or drop the entire detection
if you think it isn't worth it.

Question is what I should do in the driver. Any thoughts on that ?
For my part I am fine with dropping the detect function entirely from it;
I suspect you are right and it will mostly be used from DT type systems,
and from what you said it sounds a bit risky to scan the 0x35..0x37
address range.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

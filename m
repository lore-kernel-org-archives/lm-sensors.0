From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jun 2014 13:13:30 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] sensors-detect: Add detection of NCT7802Y
Message-Id: <53AC1C7A.3090103@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359434448-21181-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359434448-21181-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/26/2014 02:40 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Wed, 25 Jun 2014 13:42:26 -0700, Guenter Roeck wrote:
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   CHANGES                    |  1 +
>>   prog/detect/sensors-detect | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 69 insertions(+)
>>
>> diff --git a/CHANGES b/CHANGES
>> index 3390942..a16e7be 100644
>> --- a/CHANGES
>> +++ b/CHANGES
>> @@ -13,6 +13,7 @@ SVN HEAD
>>                     Add detection of ITE IT8620E and IT8623E
>>                     Add detection of TMP441, TMP442, LM95233, LM95234,
>>                     and LM95235
>> +                  Add detection of NCT7802Y
>>
>>   3.3.5 "Happy Birthday Beddy" (2014-01-22)
>>     libsensors: Improve documentation of two functions
>> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
>> index df9a408..159d2cb 100755
>> --- a/prog/detect/sensors-detect
>> +++ b/prog/detect/sensors-detect
>> @@ -733,6 +733,11 @@ use vars qw(@i2c_adapter_names);
>>   		i2c_addrs => [0x2c..0x2f],
>>   		i2c_detect => sub { w83795_detect(@_); },
>>   	}, {
>> +		name => "Nuvoton NCT7802Y",
>> +		driver => "to-be-written",
>> +		i2c_addrs => [0x28..0x2f],
>> +		i2c_detect => sub { nct7802_detect(@_); },
>> +	}, {
>>   		name => "Winbond W83627HF",
>>   		driver => "use-isa-instead",
>>   		i2c_addrs => [0x28..0x2f],
>> @@ -5483,6 +5488,69 @@ sub w83795_detect
>>   }
>>
>>   # Registers used:
>> +#   0x00: bank selection (Bank 0, 1)
>> +#   0x40, 0x80, 0xc0: bank selection (Bank 1)
>> +#   0x01, 0x41, 0x81, 0xc1: PECI control register 1 (Bank 1)
>> +#   0x02, 0x42, 0x82, 0xc2: PECI control register 2 (Bank 1)
>> +#   0x03, 0x43, 0x83, 0xc3: PECI control register 3 (Bank 1)
>> +#   0xfd: Vendor ID (Bank 0)
>> +#   0xfe: Device ID (Bank 0)
>> +#   0xff: Device Revision (Bank 0)
>> +sub nct7802_detect
>> +{
>> +	my ($bank, $reg, $pc1, $pc2, $pc3);
>> +	my ($file, $addr) = @_;
>> +
>> +	$bank = i2c_smbus_read_byte_data($file, 0x00);
>> +	return unless ($bank = 0x00 or $bank = 0x01);
>> +
>> +	# we can not do much if bank 1 is selected
>> +	if ($bank = 0x01) {
>> +		# We can not use bit masks since all bits
>> +		# (including reserved bits) can be set.
>> +		$pc1 = i2c_smbus_read_byte_data($file, 0x01);
>> +		$pc2 = i2c_smbus_read_byte_data($file, 0x02);
>> +		$pc3 = i2c_smbus_read_byte_data($file, 0x03);
>> +
>> +		# Register values repeat every 64 registers on bank 1.
>> +		# Check the first four registers of each group.
>> +		for (my $i = 0x40; $i <= 0xc0; $i += 0x40) {
>> +			$reg = i2c_smbus_read_byte_data($file, $i);
>> +			return if $reg != 0x01;
>> +			$reg = i2c_smbus_read_byte_data($file, $i + 1);
>> +			return if $reg != $pc1;
>> +			$reg = i2c_smbus_read_byte_data($file, $i + 2);
>> +			return if $reg != $pc2;
>> +			$reg = i2c_smbus_read_byte_data($file, $i + 3);
>> +			return if $reg != $pc3;
>> +		}
>> +		return 3;
>> +	}
>
> Bah. I discussed the need to have the identification registers in
> non-banked registers with Winbond/Nuvoton engineers years ago, and it
> looked like they did listen to me with the W83795G/ADG, but now they
> are doing it all wrong again :-(
>
> The above is simply too weak, I'm afraid. Chips cycling over 8, 16, 32
> or 64 register addresses are legions. Just from my register dump
> collection, the LM80 and the VIA 686A chips would both be detected by
> the loop above. There may be more, in particular if Nuvoton keeps using
> the same strategy for future chips.
>
> So I would say, just skip the detection if the chip is in bank 1. Let's
> hope the BIOS will leave the chip in bank 0. When we have a driver for
> that chip, we'll make sure to leave the chip in bank 0 too.
>
Ok with me. I didn't feel comfortable with it either.

>> +
>> +	# bank 0, can support real chip detection
>> +
>> +	$reg = i2c_smbus_read_byte_data($file, 0xfd);
>> +	return unless ($reg = 0x50);
>
> Unneeded parentheses.
>
Ok.

>> +
>> +	$reg = i2c_smbus_read_byte_data($file, 0xfe);
>> +	return unless $reg = 0xc3;
>> +
>> +	$reg = i2c_smbus_read_byte_data($file, 0xff);
>> +	return unless ($reg & 0xf0) = 0x20;
>> +
>> +	$reg = i2c_smbus_read_byte_data($file, 0x05);
>> +	return unless ($reg & 0x1f) = 0x00;
>> +
>> +	$reg = i2c_smbus_read_byte_data($file, 0x08);
>> +	return unless ($reg & 0x3f) = 0x00;
>> +
>> +	$reg = i2c_smbus_read_byte_data($file, 0x0f);
>> +	return unless ($reg & 0x3f) = 0x00;
>
> You did not say above, what these last 3 registers were. Also I am
> surprised because checking these is in contradiction with your statement
> above that "we can not use bit masks since all bits (including reserved
> bits) can be set."
>
That only applies to the bank 1 registers. The above registers are read-only.
Or at least I hope so - I'll test with the real chip to make sure.

I'll add the documentation and re-submit.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

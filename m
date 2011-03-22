From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 22 Mar 2011 10:19:37 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon: sht15: add checksum
Message-Id: <4D8877B9.5080508@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/21/11 23:14, Vivien Didelot wrote:
> Thanks for your review Jonathan.
> On Mon, Mar 21, 2011 at 07:28:58PM +0000, Jonathan Cameron wrote:
>>> to and from the device using
>>> a crc8 function. Two utility functions to read individual bytes from
>>> the device and reverse a byte have also been added.
>> This setting should definitely be configured via platform data.
>> If there is reason to have it on for a given device, that is unlikely
>> to only be true sometimes!
> Yes, it will.
Sorry, you lost me.  It will be true that you want checksum's only sometimes?
If so please explain.
>>
>> Otherwise, more or less fine.  A few minor suggestions inline.
> 
>>> +/* Table from crc data sheet, section 2.4 */
>> I'll just assume you got this right. The table google gave me was in
>> decimal and I'm feeling lazy.
> This is right, it has been taken from the SHT15 CRC calculation paper.
Cool. I wasn't suggesting it wasn't, just admitting I was to lazy to
check there were no typos!
> 
>> Please don't introduce unwanted function prototypes.  If you need
>> to reorganise the code so they aren't needed.
>>
>>> +static u8 sht15_read_byte(struct sht15_data *);
>>> +static void sht15_ack(struct sht15_data *);
>>> +static void sht15_end_transmission(struct sht15_data *);
> Ok, I'll try to rearrange the code.
> 
>> Ternary operatures in the middle something like this are really
>> really hard to read!
>> How about...
>>   c |= (!!(byte & (1 << i))) << (7 - i);
>>> +		c |= ((byte & (1 << i)) ? 1 : 0) << (7 - i);
>>> +	return c;
> It works too, I'll update this if you think that's better.
They are both pretty hideous constructs and I guess the compiler may
well give the same output. Up to you.
> 
>> That looks rather over 80 characters. Please run checkpatch.pl on this
>> before resending.
>>> +		checksum_values[0] = (data->flag = SHT15_READING_TEMP) ? SHT15_MEASURE_TEMP : SHT15_MEASURE_RH;
>>> +		checksum_values[1] = (u8) (val >> 8);
>>> +		checksum_values[2] = (u8) val;
>>> +		data->checksum_ok = (sht15_crc8(checksum_values, 3) = dev_checksum);
> Ok.
> 
>> No. That changes the default.  By all means allow this to be turned on, but
>> making it the default may effect existing users.
>>> +	data->checksumming = 1; /* Verify checksums by default */
> That's true. It has been changed.

Thanks,

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

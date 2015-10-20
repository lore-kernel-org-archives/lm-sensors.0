From: Marc Titinger <mtitinger@baylibre.com>
Date: Tue, 20 Oct 2015 13:17:33 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: ina2xx: allow for actual measurement bandwidth above 160 Hz
Message-Id: <56263EED.7020902@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <56259997.6080706@roeck-us.net>
 <1445329244-21627-1-git-send-email-mtitinger@baylibre.com>
 <56263973.300@roeck-us.net>
In-Reply-To: <56263973.300@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, mturquette@baylibre.com

On 20/10/2015 14:54, Guenter Roeck wrote:
> On 10/20/2015 01:20 AM, Marc Titinger wrote:
>> With the current implementation, the driver will prevent a readout at a
>> pace faster than the default conversion time (2ms) times the averaging
>> setting, min AVG being 1:1.
>>
>> Any sysfs "show" read access from the client app faster than 500 Hz
>> will be
>> 'cached' by the driver, but actually since do_update reads all 8
>> registers,
>> the best achievable measurement rate is roughly 8*800 us (for the time
>> spent in i2c-core) i.e. <= 156Hz with Beagle Bone Black.
>>
>> This change set uses a register mask to allow for the readout of a single
>> i2c register at a time. Furthermore, performing subsequent reads on the
>> same register will make use of the ability of the i2c chip to retain the
>> last reg offset, hence use a shorter i2c message (roughly 400us
>> instead of
>> 800us spent in i2c-core.c).
>>
> That doesn't work. There could be accesses from other sources (such as
> through
> i2c-dev, or in multi-master systems) between two reads.

Re-setting the register address with each read transaction will not 
prevent another master to change the configuration in your back, in this 
case. That sounds like a general issue of concurrent clients for one 
device, this is beyond just reading one register IMO.

>
>> The best readout rate for a single measurement is now around 2kHz. And
>> for
>> four measurements around (1/(4*800us) = 312 Hz. Since for any readout
>> rate
>> faster than 160 Hz the interval is set by the i2c transactions
>> completion,
>> the 'last-update' anti-flooding code will not have a limiting effect in
>> practice. Hence I also remove the elapsed time checking in the hwmon
>> driver
>> for ina2xx.
>>
>> To summarize, the patch provides a max bandwidth improvement with hwmon
>> client apps from ~160 Hz to ~320 Hz, and better in single-channel
>> polling mode.
>>
> Overall your patch pretty much re-implements regmap. Since you drop
> caching,
> it is also unnecessary to read all registers at a time, so you can just use
> a function to read _one_ register and returns its value (with retries).
> Or use regmap. Either case, do_update() and ina2xx_update_device() are no
> longer needed.
Agreed.

>
> If you want to convert the driver to regmap, just look for 'regmap' in
> drivers/hwmon for examples.

Fair enough, but based on your comments, I may look into an iio driver 
instead for this device, given our application, rather than 'twisting' 
the hwmon interface.

Cheers,
Marc.


>
> Guenter
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 20 Dec 2008 08:16:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add a driver for the ADT7475
Message-Id: <494CA9EE.2000000@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080610194818.GA21150@cosmic.amd.com>
In-Reply-To: <20080610194818.GA21150@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Matt Roberds wrote:
> On Fri, 19 Dec 2008, Hans de Goede wrote:
>> * converted to the new i2c driver style
> 
> I suspect this is what is causing the failure to compile on my old
> kernel (2.6.18), and right now I don't have time to try it against a
> newer kernel.
> 

Yes, you need atleast a 2.6.27 kernel for the new style.

> I did take a quick look through the patch and I do have a question about
> find_nearest().  Sometimes it returns an array index (if the query is
> less than the lowest data value in the array, or if the query is in the
> middle of the data values in the array), and sometimes it returns a data
> value (if the query is higher than the highest data value in the array).
> Looking at what happens next after find_nearest() is called, I think it
> should always return an array index.
> 
> In other words, in find_nearest(), this:
> 
> if (val > array[size - 1])
>   return array[size - 1];
> 
> should be this:
> 
> if (val > array[size - 1])
>   return size - 1;
> 

Correct, good catch!

> Also, when find_nearest() is used against autorange_table, the low 4
> bits of the return value are used.  Since autorange_table has 16
> entries, this is probably OK.  But when find_nearest is used against
> pwmfreq_table, only the low 2 bits of the return value are used.
> pwmfreq_table has 8 entries; should the low 3 bits of the return value
> be used instead?
> 
> In other words, in set_pwmfreq(), should this:
> 
> data->range[sattr->index] &= ~3;
> data->range[sattr->index] |= out & 0x03;
> 
> be something like this:
> 
> data->range[sattr->index] &= ~0x07;
> data->range[sattr->index] |= out & 0x07;
> 
> Maybe this is just how the hardware works, but I figured I would mention
> it.

Hmm, another good catch, lemme check the datasheet ... You are right there are 
3 frequency bits (the 3 least significant bits) in the range register so the 
mask should be 7 not 3. New version coming up!

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

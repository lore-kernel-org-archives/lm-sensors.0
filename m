From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 07 Apr 2008 20:04:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fix common race conditions, batch 2
Message-Id: <47FA7E48.7060306@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406180721.GN27659@mars.solarsys.private>
In-Reply-To: <20080406180721.GN27659@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 07 Apr 2008 07:49:06 +0200, Hans de Goede wrote:
>> I don't believe this is necessary, as data->temp_ovt / data->temp_high can be 
>> changed independend of data->temp_hyst. SO if a reader and a writer are racing 
>> with the locks the reader will either get the value from before or after the 
>> read, and without the lock, the same.
>>
>> There are no parts of the code which change both data->temp_ovt/data->temp_high 
>> and data->temp_hyst at _the same time_. With the one exception being the code 
>> reading the values back from the IC in update_device(), so unless something is 
>> mucking with the hardware underneath us, in which case we have much bigger 
>> problems! , there us no race here.
> 
> update_device() is exactly what Mark's patch attempts to protect the
> sysfs callbacks from.
> 

As already said I have no objections to adding the locking, I just thought it 
was worthwhile to notice that it isn't entirely needed.

>> Talking about something else touching the hardware, maybe we should change the 
>> code which reads non changing registers periodically to actually check for 
>> unexpected changes, and yell if these are found, because AFAIK thats the only 
>> reason why we read these registers periodically even though they should 
>> theoretically never change.
> 
> You can't read on a regular basis from registers which you don't expect
> to change, and at the same time not handle the case properly if it were
> to happen.

I agree.

> We have to be consistent in our choices. The general
> decision for Linux hardware monitoring drivers was to read the
> registers that aren't supposed to change. While this decision could be
> discussed (as you seem to be willing to do),

Yes, I wonder why we read registers which are not supposed to change?
The only reason I can come up with is that we suspect something maybe meddling 
with the hardware underneath us (most likely ACPI). If this is the reason, then 
we should check if that has _actually happened_ and if it does report it 
(through printk/dmesg). Thinking about this I wonder of the use of reading 
these registers regulary at all, even if ACPI is communicating with the hwmon 
device, I think its highly unlikely it will be changing any settings (like for 
example limits) after boot.

So my vote goes out to rather then adding this locking, remove the periodically 
reading of registers which never change. With that said, I still have no 
objections to this patch going in in the mean time, until we decide upon how to 
handle this in the future and then start preparing the necessary patches.

> as long as we don't change
> it, I agree with Mark that we should have a locking model consistent
> with this choice.

Ok.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

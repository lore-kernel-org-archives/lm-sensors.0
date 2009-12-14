From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 14 Dec 2009 07:04:12 +0000
Subject: Re: [lm-sensors] [PATCH] w83793 watchdog support.
Message-Id: <4B25E36C.2050807@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B18F35A.5060808@anduras.de>
In-Reply-To: <4B18F35A.5060808@anduras.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 12/14/2009 11:15 AM, Sven Anders wrote:
>> Hi,
>> Comments inline.
>
> First: Thanks for the comments!
>
> I attached a new version to this mail, but I did not changed the close
> function (see comment there!).
>

See comments to your comments below :)

<snip>

>> +static int watchdog_trigger(struct w83793_data *data)
>> +{
>> +	int ret = 0;
>> +
>> +	mutex_lock(&data->watchdog_lock);
>> +	if (!data->client) {
>> +		ret = -ENODEV;
>> +		goto leave;
>> +	}
>> +
>> +	/* Set Timeout value (in Minutes) */
>> +	w83793_write_value(data->client, W83793_REG_WDT_TIMEOUT, timeout);
>> +
>>
>> Hmm, and here things get a bit funky, you write the TIMEOUT configuration
>> register, are you sure this is the right way to do a trigger ?
>
> Yes. The Winbond chipsets do not have any special register to reset the
> countdown timer. The counter timer register is decremented during counting
> down. Most Winbond chipsets use seconds as an unit. This works fine for
> them. Unfortunatly this chipset uses minutes as unit, which seems
> to rises an additional problem: The internal timer is only reset, if the
> value of the register is different. Because the timer counts only minutes
> this means if it's value is 1 (which means 1 second to 60 seconds left) we
> cannot write a new value of 1 after 30 seconds into it, because it would not
> reset the counter. Therefore it's only working for timeouts greater than 1.
> (Writing a greater value before the correct one will not help!)
>

Ok, thanks for the explanation.

>> If so you should remember the configured timeout (the one configured through the
>> ioctl) in data and write that each trigger.
>
> The timeout here is an global variable, so it's already done here.
>

Erm, no.

The watchdog_set_timeout() function currently writes the timeout passed in
to the chip, but that will only change the timeout now, and not for future
triggers. The way the ioctl should work is that the timeout between 2 triggers
(before the system resets) should be changed, so the value written by
watchdog_trigger() should be changed. And since this driver can support multiple
ic's (unlikely this ever happens but still) the timeout should be stored in
the w83793_data struct so that it can be changed per device. The module parameter
can then be used to initialize the per device timeout when the
device is probed.

So:

-per device timeout in w83793_data
-this gets initialized to the module parameter timeout value
-watchdog_set_timeout() changes the per device timeout in the
  struct and calls (trigger) to immediately apply the new timeout
-watchdog_get_timeout() returns the timeout from the per device
  data struct
-watchdog_trigger writes the per device timeout to the chip.


<snip>

>> +static int watchdog_close(struct inode *inode, struct file *filp)
>> +{
>> +	struct w83793_data *data = filp->private_data;
>> +
>> +	if (data->watchdog_expect_close) {
>> +		watchdog_disable(data);
>> +		data->watchdog_expect_close = 0;
>> +	} else {
>> +		watchdog_trigger(data);
>> +		dev_crit(&data->client->dev,
>> +			"unexpected close, not stopping watchdog!\n");
>> +	}
>> +
>> +	clear_bit(0,&data->watchdog_is_open);
>> +
>>
>> You are missing:
>>
>>           mutex_lock(&watchdog_data_mutex);
>>           kref_put(&data->kref, w83793_release_resources);
>>           mutex_unlock(&watchdog_data_mutex);
>
> I'm not sure if you're right. Closing the watchdog did not remove the
> module nor does it disable it configurability.
> But maybe I misunderstood something here.
>

Well I'm sure I'm right :)   (please don't take this wrong and please
keep asking questions).

The problem with the free-ing of the per device data struct is that there
are 2 ways to get to it:

1) Through the hwmon interface
2) Through the watchdog device

Now the following can happen:

1) Driver attaches to w83793 i2c device
2) app opens /dev/watchdog
3) Driver detaches from w83793 i2c device
    (for example because the i2c master module
     gets unloaded)

Now before your changes 3) Would remove the hwmon interface
(and thus the only path to the per device data) and then
the per device data would be freed.

However now, someone can still have a reference to the per device
data (the app which has /dev/watchdog open). This is why we now
use reference counting for the per device data struct (this is
what the kref stuff does). So we start by initializing the
kref in probe() which puts its counter at 1, then the
watchdog open function increases the counter (the kref_get)
to 2. Then when the driver detaches, the w83793_remove() function
decreases the counter (the kref_put) to 1, this does not
call w83793_release_resources, as that will only get called when
the kref hits 0.

Now when:
4) The app closes /dev/watchdog

The close function should call kref_put too, so that the counter
will hit 0 and the data struct gets free-ed.


Note:

1) that the misc_deregister() call in w83793_remove() only
removes the /dev/watchdog node, and does not close any open
filehandles already pointing to the watchdog (closing of filehandles
is up to the application not the kernel).

2) that this (the i2c client being detached while /dev/watchdog is still
open), is the reason for the data->client check in all watchdog functions
which actually read/write the chip.

<snip>

>> -MODULE_AUTHOR("Yuan Mu");
>> +MODULE_AUTHOR("Yuan Mu, Rudolf Marek, Sven Anders");
>>    MODULE_DESCRIPTION("w83793 driver");
>>    MODULE_LICENSE("GPL");
>>
>> Not quite sure why you are adding Rudolf Marek here.
>
> He's mentioned in the copyright above. If this entry is only used as a
> "maintainers" entry, I should set it to:
>
> +MODULE_AUTHOR("Yuan Mu (sensors), Sven Anders (watchdog)");
>

The meaning of MODULE_AUTHOR is not exactly defined AFAIK, but users often
use it as "maintainers" entry, so given that he is not part of the
MODULE_AUTHOR value now I don't think you should add him.

> On the other hand, I think you are missing the 'reboot notifier' in
> your fschmd driver code.
>

The fsc chips are all part of Fujitsu Siemens Computers, iow the manufacturer
of the motherboard = the manufacturer of the watchdog. As such the watchdog
always gets initialized by the BIOS, so there is no reason to disable
it before shutdown / reboot.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 16 Oct 2008 14:02:22 +0000
Subject: Re: [lm-sensors] Patch: fschmd-watchdog-v2.patch
Message-Id: <48F7496E.8000709@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <487F4DDE.7040909@hhs.nl>
In-Reply-To: <487F4DDE.7040909@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Thu, 17 Jul 2008 15:49:18 +0200, Hans de Goede wrote:
>> Hi all,
>>
>> This patch adds support for the watchdog part found in _all_ supported FSC
>> sensor chips.
>>
>> This is version 2 of this patch and this version is meant to be applied on
>> top of the fschmd new-style i2c-driver conversion patch by Jean.
>>
>> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>>
>> Jean, can you review this please?

Thanks for the review!

<snip>
> 
> First of all: your patch triggers many errors and warnings in
> checkpatch.pl. Please fix them.
> 

Will Do.

<snip>

>>  /* our driver name */
>>  #define FSCHMD_NAME "fschmd"
>>  
>> +/* Watchdog filp->private_data pointer use utility macros. We store our minor
>> +   (to find our device data) in the private_data pointer, since the
>> +   private_data pointer can hold atleast an int, we use the "major" space 
>> +   of that int to store an per open expect_close flag. */
>> +#define WATCHDOG_INIT_FILP(filp, minor) \
>> +	(filp)->private_data = (void *)(long)(minor)
>> +#define WATCHDOG_GET_MINOR(filp) \
>> +	MINOR((long)(filp)->private_data)
>> +#define WATCHDOG_CLEAR_EXPECT_CLOSE(filp) \
>> +	(filp)->private_data = (void *)(long)WATCHDOG_GET_MINOR(filp)
>> +#define WATCHDOG_SET_EXPECT_CLOSE(filp) \
>> +	(filp)->private_data = (void *)(long)MKDEV(1, WATCHDOG_GET_MINOR(filp))
>> +#define WATCHDOG_GET_EXPECT_CLOSE(filp) \
>> +	MAJOR((long)(filp)->private_data)
> 
> I don't much like this pointer abuse. What about defining a structure
> containing the things you need, and including this structure in struct
> fschmd_data? You would get much cleaner code that way, and the few
> extra bytes of memory are certainly not worth discussing.
> 

This was done this way to keep some info per fd refering too the device, as we
now allow only one open (see below) this is mute now.

>> +
>> +
>>  /*
>>   * Functions declarations
>>   */
>> @@ -209,14 +241,23 @@
>>   */
>>  
>>  struct fschmd_data {
>> +	struct i2c_client *client;
>>  	struct device *hwmon_dev;
>>  	struct mutex update_lock;
>> +	struct list_head list;
> 
> Please add a comment saying which list the structure is a member of.
> 

Will Do.

>> +	struct miscdevice watchdog_miscdev;
>>  	int kind;
>> +	int watchdog_open_count;
>> +	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
>>  	char valid; /* zero until following fields are valid */
>>  	unsigned long last_updated; /* in jiffies */
>>  
>>  	/* register values */
>> +	u8 revision;            /* chip revision */
>>  	u8 global_control;	/* global control register */
>> +	u8 watchdog_control;    /* watchdog control register */
>> +	u8 watchdog_status;     /* watchdog status register */
>> +	u8 watchdog_preset;     /* watchdog counter preset on trigger val */
> 
> Not sure what sense it makes to store these values in the data
> structure. You'll always do read-modify-write operations on these
> register values, and doing that on possibly old copies is a bad idea in
> general.
> 

They are also used for certain "show settings" watchdog ioctls, as for the old 
copies, the contents of this registers never changes, unless written by software.

>>  	u8 volt[3];		/* 12, 5, battery voltage */
>>  	u8 temp_act[5];		/* temperature */
>>  	u8 temp_status[5];	/* status of sensor */
>> @@ -228,11 +269,20 @@
>>  };
>>  
>>  /* Global variables to hold information read from special DMI tables, which are
>> -   available on FSC machines with an fscher or later chip. */
>> +   available on FSC machines with an fscher or later chip. There is no need to
>> +   protect these with a lock as they are only modified from our attach function
>> +   which always gets called with the i2c-core lock held and never accessed
>> +   before the attach function is done with them. */
>>  static int dmi_mult[3] = { 490, 200, 100 };
>>  static int dmi_offset[3] = { 0, 0, 0 };
>>  static int dmi_vref = -1;
>>  
>> +/* Somewhat ugly :( global data pointer list with all fschmd devices, so that
>> +   we can find our device data as when using misc_register there is no other
>> +   method to get to ones device data from the open fop. */
>> +static LIST_HEAD(watchdog_data_list);
>> +static DEFINE_MUTEX(watchdog_data_mutex);
> 
> I suspect this list is duplicating something the driver core already
> offers. If you look in /sys/bus/i2c/drivers/fschmd, you'll see your
> devices listed there. This means that the driver core has a list of all
> devices bound to your driver. You should be able to find the correct
> device using driver_find_device().
> 

Using a list in the module is how all watchdog drivers do it.
driver_find_device might work, but that doesn't protect against races
when the client gets removed from underneath us and the watchdog device is
open, which can happen upon rmmod of the i2c adapter driver.

Using the list + lock protects against this race.

> But actually... Do you really need to do this? As far as I can see,
> struct miscdevice has a parent member which you can set to point to
> your fschmd device. From there you can get your i2c_client by using
> to_i2c_client(), or your fschmd_data structure by using
> device_get_drvdata(). This would be way more efficient and elegant than
> walking a list each time, don't you think?u
> 

I completely agree, and therefor was amazed when I wrote this driver that this
is not possible. But alas this is not possible I spend many hours on trying to
find more elegant ways to do this when originally writing the driver.

The problem is there is no way to get to the miscdevice struct you pass to
misc_register from the open fop called when the watchdog character device gets
opened. This is because drivers/char/misc.c still uses the old and obsolete
register_chrdev() way of registering character devices instead of the new
cdev_add(), therefor inode->i_cdev gets allocated by fs/char_dev.c and not as
part of a larger struct by drivers/char/misc.c. Leaving the only way to find
out for which device ones open fop is actually being called using the minor
from the inode. Now drivers/char/misc.c has a list of all registered miscdevice
structs and really should offer a utility function to walk that list and get a
pointer to the miscdevice struct in question by using the minor.

Or even better drivers/char/misc.c should be fixed to stop using the obsolete
register_chrdev() and instead should use cdev_add() (and related friends), I
almost begun writing a patch for drivers/char/misc.c, but I backed of due to
lack of time. So as you can see this is the only way, which is why all the
other watchdog drivers also keep their own list of devices.

>> +
>>  
>>  /*
>>   * Sysfs attr show / store functions
>> @@ -551,7 +601,286 @@
>>  
>>  
>>  /*
>> - * Real code
>> + * Watchdog routines
>> + */
>> +static struct fschmd_data *watchdog_get_data_unlocked(int minor)
>> +{
>> +	struct fschmd_data *data = NULL, *pos;
>> +
>> +	list_for_each_entry(pos, &watchdog_data_list, list) {
>> +		if (pos->watchdog_miscdev.minor = minor) {
>> +			data = pos;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return data;
>> +}
>> +
>> +static int watchdog_set_timeout_unlocked(struct fschmd_data *data, int timeout)
> 
> Rather than naming these routines foo_unlocked, I'd rather see you
> document which locks must be held when calling these functions. There
> are two locks involved so it matters to clarify the expectations.
> 

Will do.

> As a side note, I wonder if it would make sense to have a separate lock
> for the watchdog struct members. fschmd_update_device() can hold
> data->update_lock for a significant amount of time, and you probably
> don(t want to delay watchdog_timer() too much.
> 

Hmm, question: can one do multiple i2c_smbus_read/write_byte_data() requests 
and will the i2c core then do locking to serialize requests?

>> +{
>> +	int resolution;
>> +	int kind = data->kind + 1; /* 0-x array index -> 1-x module param */
>> +
>> +	/* 2 second or 60 second resolution? */
>> +	if (timeout <= 510 || kind = fscpos || kind = fscscy) {
>> +		data->watchdog_control &= ~FSCHMD_WDOG_CONTROL_RESOLUTION_MASK;
>> +		resolution = 2;
>> +	} else {
>> +		data->watchdog_control |= FSCHMD_WDOG_CONTROL_RESOLUTION_MASK;
>> +		resolution = 60;
>> +	}
> 
> Don't you want to reject a timeout value of 0? The drivers I've looked
> at, do that.
> 

Will do.

>> +
>> +	if (timeout > (resolution * 255))
>> +		data->watchdog_preset = 255;
>> +	else		
>> +		data->watchdog_preset = (timeout + (resolution - 1)) /
>> +					resolution;
> 
> You might want to use DIV_ROUND_UP().
> 

Will do.

<snip>

>> +static int watchdog_open(struct inode *inode, struct file *filp)
>> +{
>> +	int ret;
>> +	struct fschmd_data *data;
>> +
>> +	mutex_lock(&watchdog_data_mutex);
>> +	data = watchdog_get_data_unlocked(iminor(inode));
>> +	/* Check our i2c client didn't get removed from underneath us */
>> +	if (!data) {
>> +		ret = -ENODEV;
>> +		goto unlock_mutex;
>> +	}
>> +
>> +	/* Set a default timeout if necessary */
>> +	mutex_lock(&data->update_lock);
>> +	if (data->watchdog_preset = 0)
>> +		watchdog_set_timeout_unlocked(data, 60);
>> +	mutex_unlock(&data->update_lock);
> 
> I think you could do that at driver load time. Also I wouldn't make it
> conditional. Always having the same default value would be preferable,
> and that's what other drivers do as far as I can see.
> 

Will do.

>> +
>> +	/* Start the watchdog */
>> +	watchdog_trigger(data);
>> +
>> +	data->watchdog_open_count++;
> 
> Most (all?) other watchdog drivers only allow the device to be opened
> once, and return -EBUSY on subsequent tries. This makes a lot of sense
> IMHO.
> 

Agreed, I'll fix this in my next version.

<snip>

>> +	case WDIOC_SETOPTIONS:
>> +		if (get_user(i, (int *)arg)) {
> 
> Shouldn't all these (int *)arg be (int __user *)arg?
> 

Correct, will fix.

<snip>

>>  
>>  /* DMI decode routine to read voltage scaling factors from special DMI tables,
>> @@ -661,9 +990,9 @@
>>  			const struct i2c_device_id *id)
>>  {
>>  	struct fschmd_data *data;
>> -	u8 revision;
>>  	const char * const names[5] = { "Poseidon", "Hermes", "Scylla",
>>  					"Heracles", "Heimdall" };
>> +	const int watchdog_minors[] = { 130, 212, 213, 214, 215 };
> 
> Do you really need this? I couldn't find any other watchdog driver
> paying attention to the "extra" watchdog minors. At any rate, this
> shouldn't have to be handled by individual drivers. And you don't
> expect more than one FSC monitoring chip on a given system, do you?
> 

I don't expect more then one FSC monitoring chip (although I do try to keep the 
driver capable of driving multiple chips) but there can be multiple watchdogs. 
For example my test system also has an iTCO watchdog, which is a PCI devices 
and thus the driver gets loaded by udev before the lm_sensors init script laods 
the fschmd driver, this is why I do things this way, otherwise I could not test 
the watchdog code without having to first remove the iTCO driver, so I think 
this is really needed, also the char misc device documentation has 5 watchdog 
minors reserved, so I think the other drivers are weird / buggy in only 
supporting 1.

> At least, I believe that you should use MINOR_WATCHDOG instead of
> hardcoding 130. That's what the other watchdog drivers do.

Will do.
<snip>

>> +	/* Read in some never changing registers */
>> +	data->revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
>> +	data->global_control = i2c_smbus_read_byte_data(client,
>> +					FSCHMD_REG_CONTROL);
>> +	data->watchdog_control = i2c_smbus_read_byte_data(client,
>> +					FSCHMD_REG_WDOG_CONTROL);
>> +	data->watchdog_status = i2c_smbus_read_byte_data(client,
>> +					FSCHMD_REG_WDOG_STATE);
> 
> For consistency, you should choose once and for all if this is "status"
> or "state", and stick to it.
> 

Will do.

<snip>

>> +		mutex_lock(&watchdog_data_mutex);
>> +		list_add(&data->list, &watchdog_data_list);
>> +		mutex_unlock(&watchdog_data_mutex);
>> +		printk(KERN_INFO FSCHMD_NAME
>> +			": Registered watchdog chardev major 10, minor: %d\n",
>> +			watchdog_minors[i]);
> 
> As much as possible you should use dev_info(), dev_warn() etc. instead
> of printk(). You could also print the value of parameter nowayout, it
> seems that most other drivers print it.
> 

Will do.

<snip>

>> @@ -861,6 +1238,7 @@
>>  MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and "
>>  			"Heimdall driver");
>>  MODULE_LICENSE("GPL");
>> +MODULE_ALIAS_MISCDEV(WATCHDOG_GET_MINOR);
> 
> This looks bogus to me... WATCHDOG_GET_MINOR is a macro that takes one
> parameter. I guess you really mean:
> 
> MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
> 
> As a side note, I see that all other watchdog drivers do this, but
> honestly I don't much get the point. With so many drivers declaring to
> be an alias for char-major-10-130, what happens when the alias is
> requested? Over 50 drivers are loaded at once?
> 

I agree its bogus I'll remove this.

> The rest looks OK to me, but remember I am no watchdog specialist. You
> might want to show the next iteration of your patch to Wim Van
> Sebroeck, the maintainer of the watchdog subsystem.
> 

Well you seem to have done a good job at reviewing this :)

Thanks & Regards,

Hans

p.s.

I'll now start working on fixing all this and send a new patch to the list when 
I'm done.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

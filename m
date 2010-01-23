From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 23 Jan 2010 16:22:45 +0000
Subject: Re: [lm-sensors] [PATCH] w83793 watchdog support.
Message-Id: <4B5B2255.6010701@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060003000507070507070306"
List-Id: <lm-sensors.vger.kernel.org>
References: <4B18F35A.5060808@anduras.de>
In-Reply-To: <4B18F35A.5060808@anduras.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060003000507070507070306
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 01/21/2010 10:47 AM, Sven Anders wrote:
> Hello!
>
> Thanks for you last comments on the code. Now after the holidays, I found
> time to write you an answer and sent you an updated patch as well.

You're welcome, thanks for being persistent, so this can get into the kernel
eventually.

<snip>

>> Now the following can happen:
>>
>> 1) Driver attaches to w83793 i2c device
>> 2) app opens /dev/watchdog
>> 3) Driver detaches from w83793 i2c device
>>      (for example because the i2c master module
>>       gets unloaded)
>
> Is it really possible to unload the i2c master module without
> unloading any dependend module first? I thought this isn't possible...
>

Yes, their is no dependency relation between the modules, only a driver
binding, when the i2c master goes away, the i2c driver will simply have
its detach function called.

> I assume the already running watchdog app can still access the opened
> file even if the /dev/watchdog node does not exist anymore. So this
> should be a problem.
>

Correct, this is exactly why the ref counting is there, and why
the watchdog functions called through the device check if client
has not disappeared.

> There is one small problem left:
>
> If the watchdog_open() functions failes with EBUSY, we must not
> increase the counter.
>

Oh, good catch that bug is present in the fschmd.c code too. Note that the
way you've fixed this with an unlock in the error path is sort of
frowned up on. It is correct, but we usually try to keep locks and unlocks
in balanced pairs, so that it is easy to check for missing unlocks. See the
patch I've done to fix this same issue for fschmd (attached).

>>> On the other hand, I think you are missing the 'reboot notifier' in
>>> your fschmd driver code.
>>
>> The fsc chips are all part of Fujitsu Siemens Computers, iow the manufacturer
>> of the motherboard == the manufacturer of the watchdog. As such the watchdog
>> always gets initialized by the BIOS, so there is no reason to disable
>> it before shutdown / reboot.
>
> But you will need it, to prevent the watchdog to reboot the machine, if the
> shutdown sequence needs more time to shutdown than the watchdog is set to.
>
> Consider the following szenario:
>
> 1) Watchdog timeout is set to 1 Minute.
> 2) Watchdog helper tool resets the watchdog timer every 30 seconds.
> 3) User executes "shutdown" binary.

Shutdown is pure userspaces, and does not do much more then signal
init to switch runlevel.

> 4) Watchdog timer is currently at 31 seconds and the watchdog helper
>     tool is stopped first.
> 5) Watchdog timer has now about 30 seconds left.
> 6) Heavy loaded database needs much time to write it's caches or perform any
>     other tasks during shutdown. For instance it will need about 2 minutes.

That would be an initscripts bug then, the watchdog tool should be stopped
as one of the last tasks in the runlevel.

> 7) After 30 seconds the hardware watchdog kicks in and reboots the machine
>     leaving the database in an inconsistent state.
>

This will happen even with a reboot/halt notifier. That won't get called until
the kernel actually is going to do the reboot (as in make the BIOS call to do
a soft reset).

> Please notify me, if I need to make some more changes or if you sent the patch
> upstream.
>

Well, I don't have any path for sending patches directly upstream, Jean Delvare
usually does that for hwmon tree patches. I can ack this though, telling Jean
it has been reviewed by me and I don't see any more issues.

But atm I still do see a few issues:

watchdog_get_timeout():
Should return data->watchdog_timeout, not the register value, as that register
actually counts down the minutes till it will reboot. IOW it does not contain
the counter reload value (which is what we want to return), but it contains
the actual counter.

+       case WDIOC_SETTIMEOUT:
+               if (get_user(val, (int __user *)arg)) {
+                       ret = -EFAULT;
+                       break;
+               }
+               data->watchdog_timeout = val;
+               ret = watchdog_set_timeout(data, val);
+               if (ret > 0)
+                       ret = put_user(ret, (int __user *)arg);
+               break;

Note that here you store val, which is in seconds! into data->watchdog_timeout,
and then on the next trigger you will write that to W83793_REG_WDT_TIMEOUT,
resulting in a timeout of as many minutes as the user asked seconds.
I think it would best to remove the setting of data->watchdog_timeout
here (esp as no rounding and bounds checking has been done yet), and
set it to stimeout in  watchdog_set_timeout() after all error checking
has been done there.

And I think Jean might fall over the balanced lock unlock thingie, Jean ?

Regards,

Hans

--------------060003000507070507070306
Content-Type: text/plain;
 name="hwmon-fschmd-fix-memleak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hwmon-fschmd-fix-memleak.patch"

hwmon fschmd: Fix a memleak on multiple opens of /dev/watchdog

When /dev/watchdog gets opened a second time we return -EBUSY, but
we already have got a kref then, so we end up leaking our data struct.
This patch fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- vanilla-2.6.32-rc5-git3/drivers/hwmon/fschmd.c~	2009-10-29 09:11:52.000000000 +0100
+++ vanilla-2.6.32-rc5-git3/drivers/hwmon/fschmd.c	2010-01-23 16:56:41.000000000 +0100
@@ -767,6 +767,7 @@ leave:
 static int watchdog_open(struct inode *inode, struct file *filp)
 {
 	struct fschmd_data *pos, *data = NULL;
+	int watchdog_is_open;
 
 	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
 	   call misc_register() from fschmd_probe() with watchdog_data_mutex
@@ -781,10 +782,12 @@ static int watchdog_open(struct inode *i
 		}
 	}
 	/* Note we can never not have found data, so we don't check for this */
-	kref_get(&data->kref);
+	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
+	if (!watchdog_is_open)
+	        kref_get(&data->kref);
 	mutex_unlock(&watchdog_data_mutex);
 
-	if (test_and_set_bit(0, &data->watchdog_is_open))
+	if (watchdog_is_open)
 		return -EBUSY;
 
 	/* Start the watchdog */

--------------060003000507070507070306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060003000507070507070306--

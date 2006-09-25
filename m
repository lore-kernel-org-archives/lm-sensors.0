From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Sep 2006 21:31:17 +0000
Subject: [lm-sensors] [patch] hwmon/w83791d - fix unchecked errs
Message-Id: <20060925233117.830083f6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45173E99.6050608@gmail.com>
In-Reply-To: <45173E99.6050608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

> In the original code, there was nothing that removed the sysfs files
> in the detach. Was that a bug? Or is the removal something new for the
> sysfs_create_group() call?  Adding and removing the module before
> didn't show any problems (would it show as a kernel memory leak
> visible via something like /proc/meminfo?)

No, it wasn't a real bug and there was no memory leak. Not removing the
files was simply considered not clean and bad, and given that it is now
really easy to remove them when using groups, we decided to fix both
problems (unchecked errors on creation and lack of deletion) at once.
We could have made separate patches, but given that we had to change
all drivers, doing it all in one pass sounded easier.

Another reason to now properly delete the files on driver detach is
that we plan to convert the i2c subsystem to the device driver model
someday. In the device driver model, devices exist independently of
drivers being loaded to handle them. This means that a devices will
survive its driver removal, and if we don't remove the files when the
driver is removed, we end up with dangling callbacks. Bad.

> I've modified the patch per the discussion below (attached). I have
> confirmed the sysfs files are created and the values are accessed
> appropriately, but is there a good way to validate the error cases?

The easiest way to test is to simulate an error at the end of the detect
function, i.e. do as if hwmon_device_register() had failed. That way
you train the whole error path. Of course it's even better to test each
possible failure individually, but that takes more time.

Anyway, I'm confident the patch is OK now - it was really the same fix
for all drivers. I'll apply the patch to my tree now.

Thanks,
-- 
Jean Delvare


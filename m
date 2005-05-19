From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: ATXP1 kernel patch
Message-Id: <20050103223959.77711c52.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've updated the module:
> http://www.hasw.net/linux/atxp1-0.3.patch

Comments:

1* Please respect the alphabetical order in i2c/chips/Makefile.

2* You include linux/config.h but don't seem to use it.

3* What is this "low_voltage" module parameter?

4* I am really suspicious that the atxp1 has 0x37 and 0x4e as possible
addresses. How do you know?

5* normal_i2c_range is gone in Linux 2.6.10.

6* Don't use .id in i2c_driver atxp1_driver, you don't need it.

7* Other drivers don't call I2C_CLIENT_INSMOD directly.

8* In the current implementation, atxp1_data.valid is usless (value is
always 0). I also think that you should use restore and use
atxp1_data.last_updated.

9* What's the difference between VID and CPU VID?

10* You hardcode the VID <-> Vcore translation formula. Depending on the
VRM version, it might or might not be correct. You should use the
functions in i2c-sensor-vid.

11* atxp1_write is quite complex. What makes you believe that the write
could possibly fail? Other i2c drivers don't do that kind of check.

12* Why does vcore default to 1.650V in atxp1_storevcore? Why is vcore
arbitrarily kept between 1.075V/1.100V and 1.850V? If trying to write a
value outside of this range is an error, then atxp1_storevcore should
return an error (negative value) when it happens.

13* Use dev_info/dev_dbg etc... instead of printk wherever possible.

14* Care to comment/document the final loops in atxp1_storevcore? Since
atxp1_write is complex, I fear that these loops will be damn slow. Why
are they needed at all?

15* Why does atxp1_storevcore set data->valid to 0?

16* Sysfs file name should probably be cpu0_vid, not cpu_vid, although I
admit I don't know how to properly handle the case where more than one
device is present.

17* Don't set new_client->id to 0 in atxp1_detect, it's useless.

18* You detection method is too weak and will most likely result in
frequent misdetections. You have to improve it. I know that the device
doesn't have a decidated identification register, nor does it have many
registers to test, but we can certainly do something. Which registers
does the device have exactly? What happens when reading from
non-existent registers? The output of "i2cdump" may help.

19* atxp1_detach_client frees the client data even if the deregistration
failed. This is probably dangerous.

20* init and exit functions are not properly marked __init and __exit.

Good work nonetheless, this device is completely different from what we
have seen before so it's quite normal that some things need to be
discussed and tweaked before you/we get them right.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/

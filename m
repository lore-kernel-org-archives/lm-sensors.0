From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: [PATCH 2.6] I2C chipset drivers use temp_hyst[1-3]
Message-Id: <3FBD8C64.46CB8449@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116205914.49637571.khali@linux-fr.org>
In-Reply-To: <20031116205914.49637571.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Agree that appending a 1 to the single-temp drivers is a good idea,
it helps the automatic mapping.

Don't know why we need both max and over. Just because some drivers have
hyst
instead of min doesn't mean we have to rename max to over.
Why not leave everything max?
What if a driver can do both hyst and min? Would it have to offer
both max and over (identical)?

it87 and via686a violate the sysfs standard by having "alarm" instead
of "alarms", would you please fix in your next patch?

thanks
mds


Jean Delvare wrote:
> 
> The chipset drivers patch now.
> 
> Summary of the changes:
> adm1021.c: No changes, that chipset uses a real min/max model.
> eeeprom.c: No changes (obviously).
> it87.c:    Remove buggy comments (obviously taken from via686a) about
>            max and min temperature limits being over and hyst. This
>            isn't the case for this driver (min/max model).
> lm75.c:    Simple sysfs file name change (temp_min to temp_hyst).
> lm78.c:    Simple sysfs file name change (temp_min to temp_hyst).
> lm85.c:    No changes needed (min/max model).
> via686a.c: Rename functions and macros from min/max to hyst/over, what
>            it really is. Remove unnecessary comments. Rename sysfs
>            files from temp_min[1-3] to temp_hyst[1-3].
> w83781d.c: Rename variables from temp_min* to temp_hyst* (needed so
>            that the macros keep working). Update macro calls
>            accordingly. Fix writing temp to max and hyst being swapped.
> 
> Additional remarks:
> 
> The lm75 and lm78 having a single temperature channel, there is no
> number appended to the file names. Shouldn't a "1" be appended in this
> case? I think it would make it easier for the future library to catch
> all the files.
> 
> I made sure the drivers would still compile after the changes, but did
> not test them otherwise (no working 2.6.0 kernel here, and not all the
> hardware anyway).
>

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH 2.6] I2C chipset drivers use temp_hyst[1-3] V2
Message-Id: <20031204214034.GB2239@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116205914.49637571.khali@linux-fr.org>
In-Reply-To: <20031116205914.49637571.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 18, 2003 at 08:25:56PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here is an hopefully fixed version of the previous patch. Sorry for
> sending a bad one in the first place.
> 
> Mark, please test that patch if you can, thanks.
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
>            accordingly. Fix writing temp to max and hyst being
>            swapped.

Applied, thanks.

greg k-h

From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Aug 2008 13:40:55 +0000
Subject: Re: [lm-sensors] New style driver for w83781d?
Message-Id: <20080806154055.23e39f1b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4899A4F7.70201@grandegger.com>
In-Reply-To: <4899A4F7.70201@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfgang,

On Wed, 06 Aug 2008 15:19:51 +0200, Wolfgang Grandegger wrote:
> I realized that various HWMON drivers have been converted to new style.
> Has the w83781d been ported as well? Or is somebody already working on it?

This is one of the two hwmon drivers that have not yet been converted
(the other one is lm78.) I had been delaying them because they are
special (hybrid drivers, supporting both I2C and ISA devices) and also
because there are pending patches for these drivers and I was hoping
that the pending patches could be merged first (but it didn't happen
yet.) If you want to work on either of these drivers, please do. I can
do some testing on both. If you have a particular interest in these
drivers, maybe we can work together.

For a general overview of the conversion of i2c drivers to new-style,
please see:

http://jdelvare.pck.nerim.net/linux/legacy_i2c_driver.list

** means the patch is already upstream, * means that the patch is
available but needs testing and/or review. The driver list might not be
totally up-to-date, I didn't check yet if there have been legacy i2c
drivers added upstream lately.

My initial hope was to have everything converted in 2.6.28, but now I
suspect that only hwmon and rtc drivers will be completely converted by
then

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

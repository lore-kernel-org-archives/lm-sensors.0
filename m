From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 29 Nov 2005 15:06:49 +0000
Subject: [lm-sensors] Re: [PATCH] hwmon: w83792d fix unused fan pins
Message-Id: <AVmfoR1y.1133273164.0283370.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEB7B7A0@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEB7B7A0@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yuan,

On 2005-11-29, Yuan Mu wrote:
> This is the patch we have discussed, please check, thank you all :)
>
> 1. This patch add check for fan4,5,6,7 and do not create device file if
>    their pins are not configured as fan.
> 2. Fix the issue that can not set fan divisor to 128.
> 3. Fix the index out of bounds bug in w83792d_detect function.

Looks good, I'll apply that. Thanks!

Please note that the list didn't receive your patch, because you did not
use the proper attachement type. You used application/octet-stream
(binary) while the list only accepts text types (text/plain,
text/x-patch, text/x-diff). Please use the proper type next time. Your
e-mail client may pick the correct type for you if the file name
includes an extension (e.g. fix_fan_pins_divs_w83792d.patch instead of
patch_fix_fan_pins_divs_w83792d). Or you may even have to add ".txt"
to the name (like I just did for my previous post, because by braindead
webmail client doesn't recognize .patch and .diff as text extensions.)

--
Jean Delvare

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jun 2008 08:01:23 +0000
Subject: Re: [lm-sensors] [PATCH] Add driver for AD7414 i2c temperature
Message-Id: <20080615100123.5f8c092f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

Sorry for the late reply, your reply got lost in my mailbox.

On Wed, 30 Apr 2008 00:41:01 -0400, Sean MacLennan wrote:
> Here is a rework based on Jean Delvare's suggestions.
> 
> One change that may not be apparent is that the alert bit is active
> low. I feel that it reads wrong to have "cat temp_alert" return 1
> when the alert is off. So I invert this bit. Let me know how you feel
> about this.

I agree with you that 1 should mean "on" in sysfs, regardless of the
physical polarity. However, it seems to me that the ALERT polarity can
be changed (bit 4 of configuration register) so you shouldn't always
invert the bit in sysfs, only when the polarity is actually inverted.

That being said... After reading the datasheet, I am under the
impression that temp1_alert and temp1_max_alarm will trigger on the
same condition (temp1 > temp1_max). So having both files doesn't look
terribly useful to me. Especially when "temp1_alert" is not a standard
feature name, so libsensors will no pick it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

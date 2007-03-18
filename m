From: straterra@gmail.com (Straterra)
Date: Sun, 18 Mar 2007 19:32:02 +0000
Subject: [lm-sensors] pwmconfig patch
Message-Id: <74cdf1b10703181232t5949cc6fude9f624521a91d65@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Shuttle SN25P and like most shuttles, all of the fans in it
are controlled via PWM. I recently tried pwmconfig to set them up for
automatic speed control and found that there was an issue in the lm85
driver that has been known, but not fixed. Hopefully, this patch will
generate enough of a stir that people with the broken driver will
email and nag the devs so the fix gets done.

This patch merely detects to see if there was a problem disabling the
pwm control interfaces. When the user gets an access denied error,
this is a sure symptom of a problem with the underlying driver. It
detects this and spits out a warning and instructs the user to let the
appropriate people know.

Thanks!
-- Thomas "Straterra" York
straterra<at>gmail<dot>com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pwmconfig.patch
Type: application/octet-stream
Size: 2052 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070318/9ba97b52/attachment.obj 

From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Feb 2009 16:10:34 +0000
Subject: Re: [lm-sensors] W83667HG driver test for in6 and temp3
Message-Id: <20090226171034.47e0e62d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

On Thu, 26 Feb 2009 17:37:38 +0800, JGong@nuvoton.com wrote:
> Thanks very much for your quick comment. I've added the skip_in6 and
> temp3_disable into the data struct, cut the sda_temp into sub-arrays now.

Looks good to me. Only your Signed-off-by line is missing. Can I add it?

To all potential testers: I've split support for the W83667HG into 3
patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-01-invert-fan-pin-logic.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-02-add-support-for-w83667hg.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-03-fix-temp3-vs-in6.patch

These patches are now in linux-next and will be merged into kernel
2.6.30 if we receive positive feedback.

Any further change should be in a new patch to be applied on top of
these 3 patches we already have.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

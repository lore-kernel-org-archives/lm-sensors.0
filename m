From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 20 May 2006 13:57:37 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <446F2051.8020605@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I'm attaching the fix for fan5 fan4 conditional enable.
Please test it. The patch apply on the top of my previous email
of this thread.

On my board is fan4 disabled and programed as midi serial in.
Fan5 shares pins with serial flash, which is disabled. but for some reason
the on/off register is set to manual output mode and surprisingly it cannot
be changed?!

So on my configuration ASUS A8V-E SE I do not have fan4 and fan5 either.

You may provide dump of following to check if the config is correct:
isadump -k 0x86,0x86 0x2e 0x2f
isadump 0x295 0x296

Thanks,
Regards
Rudolf
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ehf_patch_fix_fan45
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060520/673bf0cc/ehf_patch_fix_fan45.pl

From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 24 Mar 2006 06:01:08 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <4dfa50520603232201y68c4d4eek16a6c31214541c95@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Yes this is correct W83792D has it vice versa. Please fix that.

Patch to fix that below, with updated regression test that gets to the
point where echo 0 > pwm_enable should set the fan to 100% and
doesn't. Anyway, that's coming up next.

-David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_pwm_mode_fix.patch
Type: application/octet-stream
Size: 41270 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060324/ca4609c4/w83627ehf_pwm_mode_fix-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_regression.sh
Type: application/x-sh
Size: 14765 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060324/ca4609c4/w83627ehf_regression-0001.sh

From: pavang_eee@rediffmail.com (Pavan)
Date: Fri, 09 Feb 2007 08:57:07 +0000
Subject: [lm-sensors] i have a problem with ds1337,arm linux 2.6.20
Message-Id: <1171010707.9705.6.camel@titan.picopeta.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the part that enables the RTC after first power up in
ds1337_init_client() fails to write a status bit in the chip, so we fall
into the same reset code (that writes zeros in the RTC regs) after each
reboot.


its giving time from zero onwards,if i set the time also its not
taking ,its taking from zero onwards  ,please tell me the way to come
out from this problem.

please tell me soon because i struct with this ,from 2 days .....






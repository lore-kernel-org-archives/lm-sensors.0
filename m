From: nemesis-lists@icequake.net (Ryan Underwood)
Date: Fri, 10 Nov 2006 19:05:57 +0000
Subject: [lm-sensors] sensord and missing alarms
Message-Id: <20061110190557.GA25801@dbz.icequake.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,
Some sensor chipsets assert an alarm always while a condition is true
(lm78) while others only assert alarm when that condition is crossed
(winbond).  I want to add a separate software "latch" for transient
alarms that can only be cleared by software, so that it is impossible
for sensord to miss an alarm.

Has this been done before, are there any arguments for or against it?

-- 
Ryan Underwood, <nemesis at icequake.net>


From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Mar 2006 19:10:13 +0000
Subject: [lm-sensors] lm87 on kernel 2.6.9: kinda-sorta working. What
Message-Id: <20060321201013.ff131c90.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603211249.43224.swsnyder@insightbb.com>
In-Reply-To: <200603211249.43224.swsnyder@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve,

> Oops! Forgot to mention that I'm using lm_sensors-2.8.7 for the userspace 
> programs.  (Standard with RHEL4).

This is the cause of your problem then. Proper support for the Linux
2.6 lm87 driver was only added in lm_sensors-2.8.8.

> I got the lm87.c from the standard 2.6.10 kernel and simply dropped it
> into Red Hat's source tree.  After adding the required normal_i2c_range[]
> and normal_isa_range{} references (see below) it built without complaint.
> No errors or warnings are seen in the system log at load time, either.

Note that you may want to backport the driver from 2.6.12 rather than
2.6.10 - it has some more bugfixes and cleanups, and the backport
should be similarly easy.

-- 
Jean Delvare


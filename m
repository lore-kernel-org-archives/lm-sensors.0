From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 15 Apr 2006 13:40:07 +0000
Subject: [lm-sensors] lm87 support on Centos 4.3 (kernel 2.6.9-34.EL) /
Message-Id: <20060415154007.8f879e3b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <443C3FF8.9080002@sedonanetworks.com>
In-Reply-To: <443C3FF8.9080002@sedonanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> > Oh exept one. You can try to build the kernel outside the kernel tree. But his implies
> > you can run make modules_prepare in in the 2.6.9 kernel and you must have proper
> > configuration file (.config) installed.
> 
> I thought out-of-tree builds were not supported anymore for 2.6
> kernels. If they are I could pick them up again and create rpms for
> them (kmdls) like for the 2.4 kernels. That would solve Doug's issue,
> too, as I package for RHEL4, too.

But what would you be packaging exactly? Remember that the kernel
modules in lm_sensors2 CVS are *not* suitable for 2.6 kernels. What
Rudolf was proposing was to backport one given driver from a recent 2.6
kernel to 2.6.9. This would be done on an individual basis. There is no
out-of-tree set of hardware monitoring drivers working for every 2.6
kernel, like we had for 2.4 kernels.

-- 
Jean Delvare


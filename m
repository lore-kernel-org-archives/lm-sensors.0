From: Nuzhna Pomoshch <nuzhna_pomoshch@yahoo.com>
Date: Sun, 26 Jul 2009 01:45:11 +0000
Subject: [lm-sensors] Same problem, different form factor.
Message-Id: <537754.36624.qm@web111504.mail.gq1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am having a problem that I have researched a bit, and hope that
someone can help me with it.

I have a Compaq Evo D510 USDT that I can't get the kernel to recognize
the SMBus on.

I found this page, which indicates a similar problem (now fixed) on the
same basic machine (but with a different form factor).

http://www.lm-sensors.org/ticket/2304 (and the patch, which shows CMT
and SFF form factors, but not USDT).

My computer behaves exactly the same way (meaning it gives the same
output).

The pci-enable-SMBus-on-Compaq-Evo-D510.patch does not work on this particular form factor.

I have tried various 2.6.28 and 2.6.29 kernels (all with lm_sensors
2.10.7), but still don't see the SMBus.

Any thoughts? Thanks.

Nuzhna


      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

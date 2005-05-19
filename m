From: clemy@clemy.org (Bernhard Schrenk)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH] Port of w83627hf to kernel 2.6
Message-Id: <001901c3fb79$18ffd5a0$3d07010a@isispapyrus.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
In-Reply-To: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please excuse my late response. I have attached the new patch including the
changes in latest cvs revision (1.15) of the driver and the suggestion from
Jean to change the descriptive text. The patch is against kernel version
2.6.3.

> * Jean Delvare <khali@linux-fr.org> [2004-02-21 16:50:17 +0100]:
> > MMH, can you take care about this port (review, test if possible, and
> > send to Greg)?

I can take care about this, but its my first linux kernel patch, so I do not
really know the required review and test process.
I am testing this on w83627thf. It is now running for some days without
reboot and without any problems (used by fancontrol).

Regards,
Bernhard
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627hf.patch4.bz2
Type: application/octet-stream
Size: 9405 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040225/19c2ffc7/w83627hf.patch4.obj

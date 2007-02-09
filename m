From: rjackson@lnxi.com (Ryan Jackson)
Date: Fri, 09 Feb 2007 23:09:47 +0000
Subject: [lm-sensors] [PATCH] Support for National Semiconductor LM94
Message-Id: <20070209230947.GV12898@hactar.lnxi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here are two patches that add support for the National Semiconductor
LM94.  They're based on the LM93 patches linked to on the 'Devices'
page of lm-sensors.org.

I did not work on this code (it was done by a coworker who has since
moved on), so I can't answer too many questions about it.  I figured I'd
submit it to the list anyway in case anyone found it useful.  I know
that the 2.6 kernel driver works, but I'm not sure how well-tested the
2.4 driver is.  I have not submitted the 2.6 driver to lkml because it
looks like the 2.6 driver for lm93, on which this driver was based,
hasn't been submitted.

-- 
Ryan Jackson
Linux Networx
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors_lm94.diff
Type: text/x-diff
Size: 119664 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070209/fe6e2111/attachment-0002.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm94_2.6_driver.diff
Type: text/x-diff
Size: 62688 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070209/fe6e2111/attachment-0003.bin 

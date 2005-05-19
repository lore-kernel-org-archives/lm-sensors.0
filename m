From: martin.bene@icomedias.com (Martin Bene)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: Ticket # 15731: bmcsensors panics  with Dell Poweredge 1750
Message-Id: <FA095C015271B64E99B197937712FD0227A6E5@freedom.grz.icomedias.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FA095C015271B64E99B197937712FD020B0159@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD020B0159@freedom.grz.icomedias.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Another update fort his issue [kernel panic triggered by bmcsensors}:

The source of the problem are the non-atomic kernel mallocs for device
registration called from an interrupt context - this doesn't seem to be
supported and as observed can crash the kernel.

A possible solution  is to create a kernel thread on initialisation,
leave that thread hanging round while the device scan runs, and finaly
signal the init thread when device scan is complete to finish
initialisation be registing the sensors found during scan.

A patch implementing such a scheme was created by Yvon JEGOU, I'll post
it here again.

Thanks, Martin


-------------- next part --------------
A non-text attachment was scrubbed...
Name: bmcsensors-patch
Type: application/octet-stream
Size: 7965 bytes
Desc: bmcsensors-patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040423/1c6df5bf/bmcsensors-patch.obj

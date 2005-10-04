From: lmsensors@lizardlogic.co.uk (Stig Telfer)
Date: Tue, 04 Oct 2005 21:23:53 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <0a6819a60ee6860215238f7d9d4de722@lizardlogic.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean -

I have split the patch into two, annotated and signed off.  Patch 1 is 
the bug fixes.  Patch 2 is a bit of code cleanup.  Some of patch 2 you 
may think is not worth changing.  I have no problem with that.

On my system, the current elektor driver will oops on module load and 
has no chance of working because the IO regions are not mapped.  Patch 
1 fixes it (for me).

Regards,
Stig Telfer

-------------- next part --------------
A non-text attachment was scrubbed...
Name: elektor-alpha-1.patch
Type: application/octet-stream
Size: 4121 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051004/038fd7c6/elektor-alpha-1.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: elektor-alpha-2.patch
Type: application/octet-stream
Size: 2089 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051004/038fd7c6/elektor-alpha-2.obj
-------------- next part --------------

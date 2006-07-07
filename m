From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 07 Jul 2006 13:23:35 +0000
Subject: [lm-sensors] [OT]Patch: libsensors support for gkrellm
Message-Id: <44AE6057.30309@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Sort of offtopic, but I know some people here are interested in this.
Here is the promised patch for libsensors support. Notice that I didn't
add any support for this to the Makefile. Here is how I compiled to test
the patch, you will need todo something similar to get gkrellm compiled
with libsensors support:
make CFLAGS="-O2 -Wall -DHAVE_LIBSENSORS" INSTALLROOT=/usr \
SYS_LIBS=-lsensors

This patch has also been send to gkrellm upstream and is likely to get
merged there.

Regards,

Hans

-------------- next part --------------
A non-text attachment was scrubbed...
Name: gkrellm-2.2.9-libsensors.patch
Type: text/x-patch
Size: 8783 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060707/e1af6cf0/attachment.bin 

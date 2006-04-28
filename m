From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Apr 2006 11:03:19 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060428130319.5b9c9217.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

> I hope you don't mind the imposition, Jean Delvare (khali on
> #linux-sensors) suggested I contact you about a geode driver that I need
> to write. (He said you wanted to do something similar a while back.)

That was Rudolf Marek who did, actually.

> At the moment I am using an "adapter" driver for the SC1100 called
> i2c-nscacb.c. It doesn't seem to have a maintainer, but it only had a
> couple of little bug-fixes required, so once I'd done that it worked
> perfectly.

We have two drivers for similar boards in the kernel already:
scx200_i2c and scx200_acb. I suspect that the latter is a replacement
for the older, never merged i2c-nscacb driver you're using. This guess
is backed up by this one-year old thread:
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-April/011756.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012043.html

> The driver that I wrote for the Atmel is basically a vanilla sensor
> driver. (...)

How does a microcontroller qualify as a sensor? And what do you mean
with "vanilla"?

I will merge the following documentation update for the scx200_acb
driver, comments welcome.

* * * * *

Documentation update for the scx200_acb driver. Hopefully this should
help future users.

References:

[lm-sensors] Support of i2c-nscacb (April, May 2005)
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-April/011756.html
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012043.html

[lm-sensors] making a geode i2c slave driver (April 2006)
  http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015998.html

Kernel bug #6445
  http://bugzilla.kernel.org/show_bug.cgi?idd45

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/scx200_acb |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc3.orig/Documentation/i2c/busses/scx200_acb	2006-04-03 20:12:23.000000000 +0200
+++ linux-2.6.17-rc3/Documentation/i2c/busses/scx200_acb	2006-04-28 10:45:30.000000000 +0200
@@ -2,14 +2,31 @@
 
 Author: Christer Weinigel <wingel at nano-system.com>
 
+The driver supersedes the older, never merged driver named i2c-nscacb.
+
 Module Parameters
 -----------------
 
-* base: int
+* base: up to 4 ints
   Base addresses for the ACCESS.bus controllers on SCx200 and SC1100 devices
 
+  By default the driver uses two base addresses 0x820 and 0x840.
+  If you want only one base address, specify the second as 0 so as to
+  override this default.
+
 Description
 -----------
 
 Enable the use of the ACCESS.bus controller on the Geode SCx200 and
 SC1100 processors and the CS5535 and CS5536 Geode companion devices.
+
+Device-specific notes
+---------------------
+
+The SC1100 WRAP boards are known to use base addresses 0x810 and 0x820.
+If the scx200_acb driver is built into the kernel, add the following
+parameter to your boot command line:
+  scx200_acb.base=0x810,0x820
+If the scx200_acb driver is built as a module, add the following line to
+the file /etc/modprobe.conf instead:
+  options scx200_acb base=0x810,0x820


-- 
Jean Delvare


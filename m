From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: General questions
Message-Id: <20040118184912.GA4208@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118125025.3102d486.khali@linux-fr.org>
In-Reply-To: <20040118125025.3102d486.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 18, 2004 at 12:50:25PM +0100, Jean Delvare wrote:
> A few questions if you don't mind:

No problem.  I'll go apply your patches later today or tomorrow, so
don't think I'm ignoring them.

> 1* Where again can I see the patches for the 2.6 i2c subsystem as you
> apply them? I thought it was somewhere in http://linuxusb.bkbits.net/ but
> I can't see anything these days, although you say you have applied a
> dozen patches.

Oops, I moved my bk trees, and didn't tell anyone :(

The tree previously at bk://linuxusb.bkbits.net/usb-2.5 is now at:
	bk://kernel.bkbits.net/home/gregkh/linux/gregkh-2.6
I don't know if there is web access to that tree or not, sorry.

I'm also staging the i2c patches to send off to Linus at:
	bk://kernel.bkbits.net/home/gregkh/linux/i2c-2.6

> 2* Wouldn't it be time to send what you have to Linus? I count no less
> than 18 patches (and I think I have one or two more for you), would be
> great if at least some of them could be in 2.6.2-pre1.

Oh yeah, it's beyond time.  Just that Linus has been in australia for
linux.conf.au this past week or so.  When he gets back (don't know when
that will be yet) I will send him the tree.

> 3* Is there a chance that the i2c subsystem could be moved one level
> down in the configure tree? I wonder why we live in "Character Devices".
> The i2c subsystem is big enough to have its own subdirectory, so I would
> expect it to appear in "Device Drivers" directly.

Heh, I had that same idea a few days ago, and already did it in my trees
with the following patch.

thanks,

greg k-h


 Date: 15 Jan 2004 10:33:34 -08:00
 Subject: I2C: move the Kconfig "source..." out of the drivers/char/ location

diff -Nru a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig	Sun Jan 18 10:47:04 2004
+++ b/drivers/Kconfig	Sun Jan 18 10:47:04 2004
@@ -38,6 +38,8 @@
 
 source "drivers/char/Kconfig"
 
+source "drivers/i2c/Kconfig"
+
 # source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Sun Jan 18 10:47:04 2004
+++ b/drivers/char/Kconfig	Sun Jan 18 10:47:04 2004
@@ -588,8 +588,6 @@
 	bool "Support for console on line printer"
 	depends on PC9800_OLDLP
 
-source "drivers/i2c/Kconfig"
-
 
 menu "Mice"
 

From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Call for testers: Kernel connector update, SuperIO update.
Message-Id: <20040912011638.19a93285@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040909080310.GA32003@uganda.factory.vocord.ru>
In-Reply-To: <20040909080310.GA32003@uganda.factory.vocord.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 11 Sep 2004 17:46:06 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> Doh. Minor update.
> 
> Questions, requests, suggestions?

I swear I will not smoke bad crack anymore.

Patch for Makefile was broken.
Corrected shoud use SC_SUPERIO not SUPERIO.

--- /usr/local/src/linux/soekris/linux-2.6/drivers/Makefile.orig	2004-09-12 01:14:07.000000000 +0400
+++ /usr/local/src/linux/soekris/linux-2.6/drivers/Makefile	2004-09-11 22:49:32.000000000 +0400
@@ -43,6 +43,8 @@
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
+obj-$(CONFIG_CONNECTOR)		+= connector/
+obj-$(CONFIG_SC_SUPERIO)	+= superio/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt

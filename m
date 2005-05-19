From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [kronos@kronoz.cjb.net: Re: [patch] sensors/w83781d.c creates useless
Message-Id: <20031011193739.GA2999@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Kronos <kronos@kronoz.cjb.net> -----

From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: frodol@dds.nl, Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [patch] sensors/w83781d.c creates useless sysfs entries
Reply-To: kronos@kronoz.cjb.net
X-Spam-Status: No, hits=-7.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH,RCVD_IN_OSIRUSOFT_COM version=2.20
X-Spam-Level: 

Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> Hello,
> 
> here is a trivial fix for Winbond sensor driver, which currently creates 
> useless entries in sys/bus/i2c due to missing braces after if statements 
> - author probably forgot about the macro expansion.

IMHO it's better to fix the macro:

--- a/drivers/i2c/chips/w83781d.c	Sun Sep 28 17:47:38 2003
+++ b/drivers/i2c/chips/w83781d.c	Sat Oct 11 18:31:04 2003
@@ -422,9 +422,11 @@
 sysfs_in_offsets(8);
 
 #define device_create_file_in(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_in_input##offset); \
 device_create_file(&client->dev, &dev_attr_in_min##offset); \
-device_create_file(&client->dev, &dev_attr_in_max##offset);
+device_create_file(&client->dev, &dev_attr_in_max##offset); \
+} while (0);
 
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

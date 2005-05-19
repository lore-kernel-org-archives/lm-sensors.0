From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [BK PATCH] More i2c driver fixes for 2.6.0-test7
Message-Id: <20031015180456.GA22107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030808235501.GA2795@kroah.com>
In-Reply-To: <20030808235501.GA2795@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some more minor i2c driver fixes for 2.6.0-test7.  They fix
some bugs in the w83781d.c driver, and remove some unneeded MOD_INC and
MOD_DEC calls (which fixes some compiler warnings.)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

thanks,

greg k-h

------

Greg Kroah-Hartman:
  o I2C: fix more define problems in w83781d driver
  o I2C: remove unneeded MOD_INC and MOD_DEC calls

Luca Tettamanti:
  o I2C: sensors/w83781d.c creates useless sysfs entries

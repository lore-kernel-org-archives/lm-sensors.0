From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test3
Message-Id: <20030815183207.GA3851@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes for 2.6.0-test3.  They include a fix for
the i2c-dev driver that has gone into 2.4 and a pii4x bugfix from Tom
Rini.  I've also added adapter and client "name" files in sysfs as the
driver core no longer supplies them.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/i2c-nforce2.c |   29 ++++-----------------------
 drivers/i2c/busses/i2c-piix4.c   |   13 ++++++++++--
 drivers/i2c/chips/Makefile       |    4 ++-
 drivers/i2c/chips/adm1021.c      |    8 +++----
 drivers/i2c/i2c-core.c           |   28 ++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c            |   41 ++++++++++++++++++++++++---------------
 6 files changed, 77 insertions(+), 46 deletions(-)
-----

<khali:linux-fr.org>:
  o i2c: user/kernel bug and memory leak in i2c-dev

Greg Kroah-Hartman:
  o I2C: add adapter and client name files as the driver core no longer provides them
  o I2C: fix up the wording for the pii4x bugfix
  o i2c: move w83481d to top of link order due to chip address takeover ability
  o i2c: fix up "raw" printk() call

Mark M. Hoffman:
  o I2C: i2c nforce2.c fixes

Rusty Lynch:
  o I2C: bugfix for initialization bug in adm1021 driver

Tom Rini:
  o I2C: Fix for i2c-piix4 with on some boards

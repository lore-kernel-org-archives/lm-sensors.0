From: xkb@hypernation.net (Sander@hypernation.net)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: DevFS and i2c
Message-Id: <1054477965.3646.5.camel@MAIN.hypernation.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Im trying to build the cvs checkout of 01-06-2003 of the i2c project.
This build is supposed to be for 2.5.x kernel series. Im trying to build
in on 2.5.70-mm2 kernel release.

However in /kernel/i2c-dev.c it seems that old (2.4.x) code for devfs is
used. Is this correct? If so, how can I change it?

During build (make all) the following error occurs:

kernel/i2c-dev.c: In function `i2cdev_attach_adapter':
kernel/i2c-dev.c:414: `DEVFS_FL_DEFAULT' undeclared 

Gcc is version 3.2.2

Regards,

Sander

-- 
Sander van den Berg
Student CS, TU/e
hypernation.net
sander@hypernation.net
PGP-public-key: see website

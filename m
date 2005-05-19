From: nroeder@inf.ed.ac.uk (Nils Roeder)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: linux-2.6.7 parallel port adapter
Message-Id: <427B6E12.9000008@inf.ed.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi

using the parallel adapter (light) in 2.6.7

#CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT is not set

causes a kernel panic ...
has anyone had similar problems or is it fixed
in later versions (i did only a quick search)?

using the normal parallel port adapter

CONFIG_I2C_PARPORT=y
#CONFIG_I2C_PARPORT_LIGHT is not set

seems to work fine with sysfs but
causes problems over /dev/i2c-0 :
i2cdetect just takes forever to complete a run
e.g. just the following line took 5 minutes (and isnt correct)

20: UU UU UU UU UU UU UU UU XX XX XX XX XX XX XX XX

removing the physical adapter during the run, allows
the program to terminate immediatly...

is that a problem with the i2c-to-parallel adapter ?

cheers,
   nils roeder

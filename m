From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Error on Compiling latest CVS i2c
Message-Id: <20030130164251.MNHD10203.pop017.verizon.net@[192.168.1.101]>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


During "make" in i2c, I get an error in "kernel/i2c/i2c.h"

kernel/i2c.h: In function `i2c_client_command':
kernel/i2c.h:327: `EINVAL' undeclared (first use in this function)
kernel/i2c.h:327: (Each undeclared identifier is reported only once
kernel/i2c.h:327: for each function it appears in.)
make: *** [kernel/i2c-velleman.o] Error 1

I do not use i2c-velleman.o, but I can't compile until I know what this means and how to fix it.


Ed Harrison, broadcasting on:
        L I N U X
by SuSE (8.1), Kernel 2.4.19-4GB,
X-server 4.2, PolarBarMailer 1.25rc3

From: nroeder@inf.ed.ac.uk (Nils Roeder)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <42775670.5070709@inf.ed.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi

i use a userspace program to access /dev/i2c-0 which
uses (/doc/dev-interface)
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
which works fine in linux-2.4.x

'porting' this to linux-2.6.7 causes too many errors.
can anyone point me to the right direction so solve these ?
(i realised in 2.6.7 the smbus macros are missing in i2c-dev.h
so i am basically a bit lost...)


a more interesting question (for me at least) is -
do i actually need to do that.
just today (i must admit) i tried lmsensors for the first time, 
crosscompiled 'i2cdetect' and realised it can find all my devices 
attached to /dev/i2c-0.
so, can i read and write to the devices found by i2cdetect
(e.g 0x4b on /dev/i2c-0)
using kernel drivers rather than my userspace program,
if so how (or where can i read about it) ?

cheers,
   nils

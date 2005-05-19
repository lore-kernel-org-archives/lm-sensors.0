From: jpiszcz@lucidpixels.com (Justin Piszcz)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Kernel 2.6.9 & adm1021 & i2c_piix4 temperature monitoring
Message-Id: <Pine.LNX.4.61.0411080907500.10502@p500>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sensors@stimpy.netroedge.com

Anyone know why this happens?

I am monitoring the temperature sensors on my Dell GX1 box, and I get the 
following in dmesg:

i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed reset at end of transaction (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed reset at end of transaction (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)

I am using lm-sensors 2.8.7.

Relevant modules include:

$ lsmod
Module                  Size  Used by
adm1021                12092  0
i2c_piix4               5648  0
i2c_sensor              2912  1 adm1021
i2c_dev                 7776  0
i2c_core               19312  4 adm1021,i2c_piix4,i2c_sensor,i2c_dev

Of course the ``secret'' to getting the temperature sensors to work on a 
Dell is two options when loading the i2c driver and the adm1024 driver.

   TYPE="/sbin/modprobe"

   $TYPE i2c_piix4 force=1
   $TYPE adm1021 read_only=1

The force is required to enable it, otherwise I do not believe it even 
loads.

The read_only=1 is so it does not change the temperature range in the 
monitoring chip, if read_only=1 is not set and the machine gets hot, say 
from compiling the kernel, the machine shuts itself off.

My question is, why all the failed transactions?
I graph the temperature without any issues (system and CPU) but I still 
get some of these in dmesg, any ideas?


From: wolfgang.sepp@gmx.net (Wolfgang Sepp)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: modprobe piix4 does not return
Message-Id: <15076.1042157201@www40.gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have Linux 2.2.16 running on a Asus Tx97e board. I had several problems
with the i2c package. 

First, I downloaded the new i2c package i2c-2.7.0.tar.gz. I realized, that
it does not contain the i2c-piix4.o module. Is that what the developers
intended?
Then, I downloaded the lm_sensors-2.7.0.tar.gz package, which contains the
i2c-piix4.c source code. This time, I had problems with the compilation of the
package:

------
kernel/chips/lm92.c:96: warning: parameter names (without types) in function
deckernel/chips/lm92.c: In function `lm92_temp':
kernel/chips/lm92.c:180: `mutex' undeclared (first use in this function)
kernel/chips/lm92.c:180: (Each undeclared identifier is reported only once
kernel/chips/lm92.c:180: for each function it appears in.)
kernel/chips/lm92.c: In function `lm92_alarms':
kernel/chips/lm92.c:207: `mutex' undeclared (first use in this function)
kernel/chips/lm92.c: In function `lm92_detect':
kernel/chips/lm92.c:280: `mutex' undeclared (first use in this function)
kernel/chips/lm92.c:298: `THIS_MODULE' undeclared (first use in this
function)  
------
which I solved by copying the definitin of DECLARE_MUTEX and THIS_MODULE
from der modules.

Finally, I could modprobe the i2c-piix4 module, but unfortunately the call
to modprobe does not return and the process cannot be terminated. This is the
same behavior as with the old module from the 2.2.16 kernel.

sensors-detect  reports the following:
------
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:01.3: Intel 82371AB PIIX4 ACPI
Probe succesfully concluded.
------
dmesg reports:
------
i2c-piix4.o version 2.7.0 (20021208)
i2c-piix4.o: Found PIIX4 device
------

I did not patch my kernel with the i2c/lm_sensor patches.

Any idea??
Thank you in advance for any help you can give me,

ciao,
wolfgang

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr f?r 1 ct/ Min. surfen!

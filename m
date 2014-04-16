From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Apr 2014 16:01:15 +0000
Subject: Re: [lm-sensors] Fwd: Fan readings for Nuvoton NCT6776F
Message-Id: <20140416160115.GA21572@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAyKf8_J9Q=GV86E5Ojm8_UR2NyDkhs8zMzxhs=PqakMupSNkw@mail.gmail.com>
In-Reply-To: <CAAyKf8_J9Q=GV86E5Ojm8_UR2NyDkhs8zMzxhs=PqakMupSNkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 16, 2014 at 07:31:26AM -0700, Shannon Ross wrote:
> Hello,
> 
> First I want to say thanks to those who developed lm-sensors, it has been a
> very nice product and I have been impressed with the instillation and
> detection tools. I am able to install lm-sensors, and read the temperature
> sensors, but not the fan information.
> 
> There are 3 fans in my system and upon opening the bios settings on startup
> I am able to see the RPM of each fan, however lm-sensors does not seem
> capable of reading the fan speed.
> 
> 1) Should I be able to read the fan speed if I have a Nuvoton NCT6776F chip?
> 2) Is there another option besides lm-sensors if you believe this is not a
> viable option to read fan speeds.
> 
> Motherboard Info: Supermicr X9SPV-M4-3QE
> lm-sensor version: sensors version 3.3.1 with libsensors version 3.3.1
> kernel version: Linux hssl-test 3.5.0-36-generic #57~precise1-Ubuntu SMP
> Thu Jun 20 18:21:09 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
> 
> I have the dmesg output, however it made my email too long and was
> rejected. If you would like to see it, or a portion please let me know.
> 
Hi,

Unfortunately you don't tell us about your kernel version. The w83627ehf module
is not loaded in your kernel, which suggests that either you did not load it
(try 'sudo modprobe w83627ehf'), or your kernel is too old and the w83627ehf
driver does not support NCT6776. If the driver is loaded, you should see some
information in dmesg telling you if it supports the chip or not.

If your kernel is too old, it might make sense to download and install the
nct6775 driver and use it instead of the w83627ehf driver. You can get it
from github [1]. If your kernel is recent, it may already include the new
driver. Try "sudo modprobe nct6775" to find out.

Guenter

[1] https://github.com/groeck/nct6775

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

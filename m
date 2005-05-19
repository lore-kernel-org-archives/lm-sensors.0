From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Missing download
Message-Id: <200405111511.i4BFBZEf088310@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr7rnlmpsk46x2i@localhost>
In-Reply-To: <opr7rnlmpsk46x2i@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I did as you wrote, and got the same result; no temperatures or voltages.
>I'm guessing the reason is this:
>[root@localhost william]# modprobe i2c-viapro
>[root@localhost william]# modprobe i2c-isa
>[root@localhost william]# modprobe eeprom
>[root@localhost william]# modprobe w83627hf
>FATAL: Module w83627hf not found.
>
>I don't know why this module isn't found, as it shows OK in sensors-detect.
>Any advice appreciated.

This is simply because you are using Linux 2.6.3 and the w83627hf was
introduced in Linux 2.6.5-rc1. The sensors-detect script doesn't know
about which modules are available on which kernels. So basically you'll
need a newer kernel in order to get hardware monitoring to work on your
system.

Jean

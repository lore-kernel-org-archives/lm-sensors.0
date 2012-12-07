From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 Dec 2012 17:31:25 +0000
Subject: Re: [lm-sensors] decode-dimms can't detect DIMM in all slots
Message-Id: <20121207183125.563a6820@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50C21D04.8040003@yandex.com>
In-Reply-To: <50C21D04.8040003@yandex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 07 Dec 2012 20:44:52 +0400, wind wrote:
> I use motherboard with 2 CPU and 6 DIMM (3 DIMM on each CPU).  I run 
> decode-dimms and it detect 3 DIMM modules in the 3 slots but another 3 
> DIMM decode-dimms can't detect.

That's an off-topic question, as it has nothing to do with lm-sensors,
but I'll reply still...

> lm-sensors 3.3.3
> decode-dimms in the i2c-tools 3.1.0-3 and even I tried rev.6068
> kernel 2.6.32.20 and even I tried 3.4.2
> motherboard - Supermicro X8DTG
> 
> modprobe i2c-i801
> modprobe i2c-dev
> modprobe i2c-core
> modprobe eeprom
> 'i2cdetect 3' give table something like this
> 
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- UU -- UU -- UU -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 -- 52 -- 54 -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --

Most multi-CPU boards use SMBus multiplexing with memory for each CPU
being on a separate bus segment. This is explained here:
https://i2c.wiki.kernel.org/index.php/I2C_bus_multiplexing

Support for Asus Z8 series boards was added in kernel 3.7, you'd
probably need something similar for your board. Unfortunately this
can't be auto-detected, so you have to get the multiplexing information
from the vendor. You need to know what multiplexing chip is used, and
for GPIO-controlled multiplexing chips, which motherboard chips' GPIO
pins are used.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

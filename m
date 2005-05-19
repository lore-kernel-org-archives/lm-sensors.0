From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Wrong temperature readings
Message-Id: <Djz9Zh0h.1113406040.1074980.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <425D3645.1030500@algitech.com>
In-Reply-To: <425D3645.1030500@algitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Roger,

> I have bunch of machines with Intel SE7210TP1-E motherboard running 
> Fedora Core 2 and lm_sensors 2.8.6 (installed with yum).
>
> Some of the machines report problems with the CPU temperature beeing to 
> high ("CPU0: Temperature above threshold","CPU0: Running in modulated 
> clock mode")

These messages don't come from our drivers. They are either from ACPI or
from CPU-specific MCE. Search the web for "Running in modulated clock
mode" and you'll find several references to your problem.

http://www.ussg.iu.edu/hypermail/linux/kernel/0404.2/1223.html

You should check if you can find anything relevant in
/proc/acpi/thermal_zone. If temperature limits are too low, try
increasing them.

As for MCE, I don't know how you can change their threshold. Maybe it's
just a matter of improving the CPU cooling.

--
Jean Delvare

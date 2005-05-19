From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <20031130184119.784bc205.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130134504.142f7cde.khali@linux-fr.org>
In-Reply-To: <20031130134504.142f7cde.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For a7n8x-x fan1_div is surely 4

Depends on the fan itself, not the motherboard.

> with fan1_div 2 in /etc/sensors.conf
>   newdeal:/home/robs# sensors -s
>   newdeal:/home/robs# sensors
>   ...
>   as99127f-i2c-1-2d
>   ...
>   fan1:     5000 RPM  (min = 2657 RPM, div = 2)                     
> 
> 
> with fan1_div 4 in /etc/sensors.conf
>   newdeal:/home/robs# sensors -s
>   newdeal:/home/robs# sensors
>   eeprom-i2c-0-51
>   ...
>   as99127f-i2c-1-2d
>   ...
>   fan1:     2463 RPM  (min = 1328 RPM, div = 4)                     
>   
>   (second run with no pause and no change in sensors.conf)
>   newdeal:/home/robs# sensors
>   ...
>   as99127f-i2c-1-2d
>   ...
>   fan1:     4963 RPM  (min = 1328 RPM, div = 4)                     

This is the expected behavior. When you set the divisor, you change a
range vs. accuracy setting. You do *not* change the reported value. This
might seem strange at first, but that's the way it goes. You might want
to read doc/fan-divisors for more information. As you change the divisor
from 2 to 4, you say to the chip: "instead of reporting 1 revolution
every 2, now report 1 every 4 [1]". But this doesn't change the value
stored in the register. You have to wait that the chipset writes a value
there again, taking the new fan divisor into account. In your example
above, the second time you run sensors, the chipset has been filling the
register while divisor was set to 2, but the sensors program sees the
divisor at 4, so it computes the value from the register as if the
chipset has filled it with divisor 4, thus the bad value.

If you want sensors to match your BIOS readings, don't use fan divisors,
use the following line in your configuration file instead:

   compute fan1  @/2,  2*@


[1] Actually, most fans return two pulses for one rotation, thus the
default divisor of 2.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

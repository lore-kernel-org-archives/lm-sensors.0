From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Apr 2010 09:17:33 +0000
Subject: Re: [lm-sensors] Coretemp goes up since 2.6.31.4
Message-Id: <20100409111733.7bb2b5fa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 08 Apr 2010 18:36:34 +0200, dienet wrote:
> I'll try to ask You first then I'll write do LKML.

Neither is correct. Please check MAINTAINERS, it says:

CORETEMP HARDWARE MONITORING DRIVER
M:      Rudolf Marek <r.marek@assembler.cz>
M:      Huaxu Wan <huaxu.wan@intel.com>
L:      lm-sensors@lm-sensors.org
S:      Maintained
F:      Documentation/hwmon/coretemp
F:      drivers/hwmon/coretemp.c

I'm adding the lm-sensors list to Cc now.

> I was using 2.6.31.4 for quite some time - it works OK.
> Command 'sensor' that gives me temperature on my C2D, was saying that  
> cores have around 28-45 deg (min and maxs on normal day work)
> Now on 2.6.33.1 sensors gives temperatures around 32-48 deg. I never seen  
> 29 or below. No room temperature is changing (got two kernels installed,  
> so I can change it quickly)
> Who is telling the truth here? Was there any works on coretemp module  
> since 2.6.31.4 that made the change in read-out?

There were some changes to the coretemp driver in 2.6.32 and 2.6.33,
but these shouldn't affect older CPU models and would also not change
the readout by a few degrees. You can check if the high temperature
limit is the same - then you can assume the driver changes did not
affect your system. If you want to double-check, feel free to download
the standalone version of the coretemp driver from:
  http://khali.linux-fr.org/devel/misc/coretemp/
You can use that driver with both kernels. If the temperature readings
are still different, then this means that the coretemp driver is
innocent.

> I think that because that temp. change fan is working more often.
> 
> I'm using Lenovo ThinkPad T61.

This suggests that the temperature increase is real and this isn't just
a reporting issue. I suggest that you check
in /proc/acpi/processor/*/power, the amount of time spent in C2 and C3
states. Also install powertop and run it on both kernels, see if 2.6.33
has more frequent wake-ups than 2.6.31.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

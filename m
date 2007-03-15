From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Mar 2007 07:22:01 +0000
Subject: [lm-sensors] Solution for ACPI <-> lmsensors arbitration?
Message-Id: <20070315082201.6eb34027.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F85340.2080702@hhs.nl>
In-Reply-To: <45F85340.2080702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 14 Mar 2007 20:55:44 +0100, Hans de Goede wrote:
> In order to better understand the PC8374L datasheet I've also been reading the 
> w83627hf datasheet, and I noticed that the w83627hf contains a driver 
> arbitration mechanism in hardware. This may not be the case for all hwmon's but 
> I believe that we should start supporting this for those who do. The address 
> register of the hwmonitor part has a busy flag, currently the code for reading 
> from it says:
> /*
>     ISA access must always be locked explicitly!
>     We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
>     would slow down the W83781D access and should not be necessary.
>     There are some ugly typecasts here, but the good news is - they should
>     nowhere else be necessary! */
> 
> If we would check this first and an address was written by ACPI, then we would 
> know to wait. The only problem is that there is a race between the time we 
> check the bit and then write our own access, I'm currently thinking about 
> fixing this as follows:
> 
> while (!access_successfull && attemps)
> {
>     if (busy)
>         sleep
>     else
>     {
>         disableinterrupts() /* or take a lock shared with acpi,
>             but then we still have SMI problems, can we disable SMI too?
>             or maybe only acpi-lock + mask SMI? */

As far as I know, SMI cannot be disabled at all.

>         if (!busy)
>         {
>            do_read_or_write();
>            access_successfull = 1;
>         }
>         enableinterrupts()
>     }
>     attemps--; /* do we need this? */
> }
> 
> I know this isn't pretty, but it should work, right? Comments?

I can't see how it solves the race condition.

As you noticed, the hardware lock is racy, so it's useless. The best we
can do with it is detecting a concurrent access, but not prevent it.
So instead of working around the race, we better simply use a software
lock, it has the same cost and doesn't depend on the hardware. This is
more of less what Rudolf Marek proposed some times ago and that was
discussed here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019065.html

Other problems with the hardware lock:
* If someone writes to the address port and never writes to nor reads
from the data port, we have a deadlock. Unlikely to happen but it would
have to be handled still.
* We cannot assume that ACPI will check the hardware busy flag, so its
accesses will not be safe.

-- 
Jean Delvare


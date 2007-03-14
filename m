From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 14 Mar 2007 19:55:44 +0000
Subject: [lm-sensors] Solution for ACPI <-> lmsensors arbitration?
Message-Id: <45F85340.2080702@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

In order to better understand the PC8374L datasheet I've also been reading the 
w83627hf datasheet, and I noticed that the w83627hf contains a driver 
arbitration mechanism in hardware. This may not be the case for all hwmon's but 
I believe that we should start supporting this for those who do. The address 
register of the hwmonitor part has a busy flag, currently the code for reading 
from it says:
/*
    ISA access must always be locked explicitly!
    We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
    would slow down the W83781D access and should not be necessary.
    There are some ugly typecasts here, but the good news is - they should
    nowhere else be necessary! */

If we would check this first and an address was written by ACPI, then we would 
know to wait. The only problem is that there is a race between the time we 
check the bit and then write our own access, I'm currently thinking about 
fixing this as follows:

while (!access_successfull && attemps)
{
    if (busy)
        sleep
    else
    {
        disableinterrupts() /* or take a lock shared with acpi,
            but then we still have SMI problems, can we disable SMI too?
            or maybe only acpi-lock + mask SMI? */
        if (!busy)
        {
           do_read_or_write();
           access_successfull = 1;
        }
        enableinterrupts()
    }
    attemps--; /* do we need this? */
}

I know this isn't pretty, but it should work, right? Comments?

Regards,

Hans


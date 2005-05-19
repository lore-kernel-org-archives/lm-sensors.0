From: panic@itu.dk (Arne John Glenstrup)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: BIOS Smart CPU Fan affected by lm_sensors
Message-Id: <423C1182.6090201@itu.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi sensors-folks,


I have MSI's K8N Neo Platinum board with a W83627THF chip.
I couldn't find the following piece of advice in the FAQ, so I had to
find out the hard way---trial and error:

Q: My Smart CPU Fan goes to full speed when I use lm_sensors!

A: The Smart CPU Fan option in the BIOS slows down the fan when
    the CPU is below a given temperature.  If your CPU temperature
    *is* below this level and the fan doesn't slow down, this might
    be caused by sensor chip initialisation.  For the W83627THF
    chip you can try replacing the line

    MODULE_1=w83627hf

    in /etc/sysconfig/lm_sensors by this line:

    MODULE_1="w83627hf init=0"

  ------------------

Also, I have a fan that runs at RPMs below 600, so I have set
the fan divisor to 32, which seems to work fine for this chip.

Best Regards,

-- Arne
____________________________________________________________
Arne John Glenstrup             mailto:panic@itu.dk
IT University of Copenhagen

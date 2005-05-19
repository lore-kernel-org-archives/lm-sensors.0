From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: bug : mkdev.sh creates devices that sensors-detect cannot use
Message-Id: <20040708225411.243e60cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040708184144.4554439e@pegasus.ucs.co.za>
In-Reply-To: <20040708184144.4554439e@pegasus.ucs.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I hope this is the correct forum to report bugs, and that this bug
> hasn't been reported already. If it isn't the correct forum, please
> let me know where I should report it.
> 
> Just downloaded and installed lm_sensors-2.8.7 from source. I've found
> a small bug. When I run mkdev.sh, it creates devices named like so :
> 
> /dev/i2c-0
> /dev/i2c-1
> /dev/i2c-2
> 
> etc
> 
> However, sensors-detect looks for a device named /dev/i2c/0  and can't
> find it. This causes sensors-detect to skip the probing of my SMBus
> Via Pro adapter, and gives the error :
> 
> Can't open /dev/i2c/0

First of all, which version of lm_sensors are you using?

Both names exist, depends on your system. /dev/i2c/0 is for people using
devfs. It is created by devfs, no script is needed. /dev/i2c-0 is for
other people (not using devfs). It needs to be created manually if your
distrubution didn't do it for you.

If the sensors-detect script searches for /dev/i2c/0, it means that it
detected that your system uses devfs. Is it true?

If it then complains that it didn't find it, it means that i2c-dev was
not loaded as it should. Maybe you miss that driver in your current
kernel configuration?

If you are using the latest version if sensors-detect AND you use devfs
AND you have i2c-dev loaded AND sensors-detect still complains, then
this is likely to be a problem with your bus driver (i2c-viapro).

-- 
Jean Delvare
http://khali.linux-fr.org/

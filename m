From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Sign me up....
Message-Id: <20040910085343.M91723@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094750714.29203.32.camel@pavement.sandburst.com>
In-Reply-To: <1094750714.29203.32.camel@pavement.sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 09 Sep 2004 13:25:14 -0400, Travis B. Sawyer wrote
> Also:  I'm working with a power supply that has i2c for an interface 
> to internal temperatures, faults, etc.  Some fields within the i2c 
> registers for the device are ascii.  Search the lm_sensors page I've 
> found nothing for ascii conversion for the /proc interface.  Is 
> there anything?  Granted this is a little odd in the use of 
> lm_sensors for this, but I was hoping....

There is no room for ASCII strings in the procfs interface (nor sysfs for that
matter). However, you can always carry raw ASCII code values, and convert them
back to a string in libsensors/sensors. Obviously the interface was not really
meant for that, but it is still doable. This is what is done for the Sony Vaio
EEPROMs, which contain the machine model name, serial number etc... You should
take a look at the eeprom driver, and the eeprom part of libsensors and
sensors (especially the vaio part) for an example of how this can be done.

-- 
Jean Delvare
http://khali.linux-fr.org/

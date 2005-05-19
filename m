From: dsaxena@mvista.com (Deepak Saxena)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Driver for Phillips PCF8594-2 eeprom
Message-Id: <20030301010514.GA29168@xanadu.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've been handed a driver for the PCF8594-2 eeprom driver that I plan
on cleaning up and pushing out to the community.  Currently, the driver
exports itself to userspace through /dev/nvram as that is the purpose
of the eeprom on the custom board its on, but is this OK with the I2C
maintainers? I know that the lmsensors EEPROM driver uses the sysctl
interface to export itself, but IMHO that seems like a much harder
to use interface then just /dev/nvram with read() and write() calls.
The standard sensors-based EEPROM won't work well on this chip b/c it has
the feature of allowing 8-byte block transfers that I'd like to see
supported, plus this driver has the ability to write to the EEPROM.

Also, the customer that is using the driver wants a nice eeprom_read()
and eeprom_write() function that they can use to access the eeprom
contents for reading the MAC addresses of their custom network drivers.
I'm assuming something like this is probably not acceptable to the
community and should just be put in a separate driver layer for the
customer-specific port?

~Deepak

-- 
Deepak Saxena, Code Monkey - Ph:480.517.0372 Fax:480.517.0262 
MontaVista Software - Powering the Embedded Revolution - www.mvista.com

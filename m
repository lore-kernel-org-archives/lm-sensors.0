From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: lm_sensors doesn't detect voltage measurements on HP Proliant
Message-Id: <20040914152215.M47634@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
In-Reply-To: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please see attached file for details done by sensors-detectprogram. I am
> using Linux Enterprise 3 (Red Hat 2.4.21).

Actually Red Hat Enterprise 3 (Linux 2.4.21), I presume.

> I have downloaded the lm_sensors2.8.7 and installed on my mahcine and it
> works fine with the detecting the eepromand AMBus adaptor but couldn't list
> the voltages, fan speeds and temperatures.It sounds like it couldn't detect
> the sensors chip. Could you help to have lookwhat exactly happened and any
> possible solution for this? I have also raised aticket in the forum with No.
> of 1774.

The output from sensors-detect reveals that you have no known ISA chip, one
Super-I/O chipset but known not to have integrated sensors, and a few
I2C/SMBus chips (including your memory module EEPROM at 0x53 and presumably a
clock chip at 0x69). There are two more (unknown) I2C chips at 0x33 and 0x60.
The former is probably the same EEPROM as 0x53 but maybe not.

Both addresses are not typical addresses for hardware monitoring devices, but
who knows... Please provide the output of "i2cdump 0 0x33" and "i2cdump 0
0x60" (assuming that this is I2C bus 0; if not, pick the correct number from
/proc/bus/i2c).

Note that i2cdump is potentially dangerous to use especially on unknown chips,
so run it at your own risk and only if rebooting the machine afterwards is an
option.

-- 
Jean Delvare 
http://khali.linux-fr.org/

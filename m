From: timebandit@dzn.mine.nu (timebandit)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Turn off alarm?
Message-Id: <20041027140616.BCD9.TIMEBANDIT@dzn.mine.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
In-Reply-To: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Yes... What i'm aware of i don't changed any hardware or settings at all.
The only thing i might change was from kernel 2.4.29 to 2.6.7.
When i runed the sensors-detect script it says this:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)


And on Gigabytes hompage is says is has Super I/O: ITE8702 chip.
And i'm using the new config file as a removed the old and made make
install user again =)

I'm not so good at editing the config file to much as my english isn't
that good. The only readings that are wrong for me now is the +3.3V,
-12V, -5V and Stdby readings.

"A comparison between IT8705 and IT8702 datasheets could help too." <---
How do i make one? =)


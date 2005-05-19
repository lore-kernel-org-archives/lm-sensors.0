From: anton@korzh.ru (Anton A. Korzh)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: i2c for 2.6.0-test11
Message-Id: <1070258710.3218.9.camel@phoebus>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

? ???, 29.11.2003, ? 20:38, Jean Delvare ?????:
> > sensors gives me segfault:
> 
> Should be fixed in current CVS, if you want to give it a try.
> Thanks for reporting.

Yes, it gives no more a segfault but i still have no sensors readings.

sensors-detect gives following positive results:

Driver `lm80' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x2d
    Chip `National Semiconductor LM80' (confidence: 3)
 
Driver `via686a' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `VIA Technologies VT82C686 Integrated Sensors' (confidence: 9)

sensors gives: 
[root@pueblo lm_sensors2]# sensors
eeprom-i2c-1-52
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
Memory type: Unavailable
 
eeprom-i2c-1-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
Memory type: Unavailable


What can you recommend me to do?
I have compiled i2c-dev,i2c-isa,i2c-viapro, all i2c chips(But there are no lm80). Sysfs is mounted to /sys

Thank You for any advance, 

Anton


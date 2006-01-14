From: adobin@gmail.com (Alexander Dobin)
Date: Sat, 14 Jan 2006 02:19:29 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m
Message-Id: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I am trying to get lm_sensors to work on the ASUS p5mt-m motherboard.
I can see the Winbond w83627ehf-A chip on the board.

I have kernel 2.6.14 and have installed lm_sensors 2.9.2

sensors-detect find the chip (see the output below), and after all the
suggested steps,
sensors output is apparently nothing for fans and temps (see below).

I will be happy to quickly provide any additional information if any of
developers decide to resolve this problem.

Thanks a lot in advance,
Alex Dobin

--------------------------------------------
sensors output:

w83627ehf-isa-0290
Adapter: ISA adapter
fan1:        0 RPM  (min = 10546 RPM, div = 128)
fan2:        0 RPM  (min =    0 RPM, div = 128)
fan3:        0 RPM  (min =    0 RPM, div = 128)
fan4:        0 RPM  (min = 10546 RPM, div = 128)
temp1:       -48?C  (high =    +0?C, hyst =   +64?C)
temp2:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
temp3:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)

-----------------------------------------------------------------------------
Here is the "summary of probes" of the sensors-detect:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060114/6262c80e/attachment.html

From: omicronix@gmail.com (Tiago Rodrigues)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: sensors on a MSI 915p neo2 platinum don't work
Message-Id: <41E84F51.2060505@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, i just upgraded to a MSI 915p neo2 , that has the winbond w83627thf.
kernel: 2.6.10-gentoo-r4
lm_sensors: 2.9.0

with the w83627hf  driver in the kernel when i tried to insert the 
module i would always get "no such device",
after looking for the problem i found this patch 
"http://archives.andrew.net.au/lm-sensors/msg28713.html" and applied it.
the module now loads but i still get the "no sensors found!" from 
sensors prog.

here is the lsmod output:
w83627hf               29352  0
i2c_isa                 2304  0
i2c_algo_pcf            7172  0
i2c_algo_pca            6276  0
i2c_algo_bit           10120  0
i2c_sensor              4480  1 w83627hf
i2c_i801               11148  0
(...)

sensors-detect:
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)

Driver `it87' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

dmesg:
i2c_adapter i2c-1: Registered as minor 1
i2c_adapter i2c-1: registered as adapter #1
i2c-core: driver w83627hf registered.
i2c_adapter i2c-1: found normal isa entry for adapter 9191, addr 0290

isadump 0x295 0x296:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 4b 10 00 32 50 01 4b 01 01 3c 3c 01 01
10: 01 ff 10 00 00 01 01 3c 43 00 ff ff 24 32 00 d6
20: 93 44 cf b9 c3 53 00 1c ff 50 ff f0 00 4c 0c 88
30: 48 a4 08 00 c0 38 00 00 02 21 00 00 02 01 00 00
40: 03 cc 19 ff ff 00 01 ff 2d 03 01 c4 58 95 80 5c
50: ff ff 80 ff ff ff 00 80 90 70 ff ff 11 05 ff 05
60: 93 44 cf b9 c3 53 00 1c ff 50 ff f0 00 4c 0c 88
70: 48 a4 08 00 c0 38 00 00 02 21 00 00 02 01 00 00
80: 01 ff 01 4b 10 00 32 50 01 4b 01 01 3c 3c 01 01
90: 01 ff 10 00 00 01 01 3c 43 00 ff ff 24 32 00 d8
a0: 93 44 cf b9 c3 53 00 1b ff 50 ff f0 00 4c 0c 88
b0: 48 a4 08 00 c0 38 00 00 02 21 00 00 02 01 00 00
c0: 03 00 00 ff ff 00 01 ff 2d 03 01 c4 58 95 80 5c
d0: ff ff 00 ff ff ff 00 80 90 70 ff ff 11 05 ff 05
e0: 93 44 cf b9 c3 53 00 1b ff 50 ff f0 00 4c 0c 88
f0: 48 a4 08 00 c0 38 00 00 02 21 00 00 02 01 00 00

i2cdetect 0:
I will probe file /dev/i2c/0.
I will probe address range 0x03-0x77.
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2f
30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX 6e XX
70: XX XX XX XX XX XX XX XX                   

lastly i do have the /etc/sensors.conf file configured:
chip "w83782d-*" "w83783s-*" "w83627hf-*"
(...)

hope someone can help,
Tiago.

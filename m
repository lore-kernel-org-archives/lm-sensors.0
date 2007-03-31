From: koko <citizenr@gmail.com>
Date: Sat, 31 Mar 2007 23:29:34 +0000
Subject: Re: [lm-sensors] repost: read the spd on A7V133 | without UTF-8
Message-Id: <3df49b7b0703311629t317db7abt64e10cec7f661a04@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3df49b7b0703311542l79ea2595pcfd8546aab4b07ac@mail.gmail.com>
In-Reply-To: <3df49b7b0703311542l79ea2595pcfd8546aab4b07ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/1/07, koko <citizenr@gmail.com> wrote:

more info (trimmed to relevant parts)
================
rasz@capek:/proc/bus/pci/00$ sudo sensors-detect

Next adapter: NVIDIA i2c adapter 2 at 1:00.0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No

Next adapter: NVIDIA i2c adapter 1 at 1:00.0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'

Next adapter: NVIDIA i2c adapter 0 at 1:00.0
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus Via Pro adapter at e800
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2d
Handled by driver `w83781d' (already loaded), chip type `as99127f'
Client found at address 0x48
Handled by driver `w83781d' (already loaded), chip type `as99127f subclient'
Client found at address 0x49
Handled by driver `w83781d' (already loaded), chip type `as99127f subclient'

Probing for `VIA VT82C686 Integrated Sensors'...            Success!
    (confidence 9, driver `via686a')


Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `NVIDIA i2c adapter 1 at 1:00.0'
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at e800'
    Busdriver `i2c-viapro', I2C address 0x2d
    Chip `as99127f' (confidence: 6)
  * Bus `SMBus Via Pro adapter at e800'
    Busdriver `i2c-viapro', I2C address 0x48
    Chip `as99127f subclient' (confidence: 6)
  * Bus `SMBus Via Pro adapter at e800'
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `as99127f subclient' (confidence: 6)

Driver `via686a' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `VIA VT82C686 Integrated Sensors' (confidence: 9)

================

rasz@capek:/proc/bus/pci/00$ sudo i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


so all i got under linux without the 'magic' everest hack is 2d 48 49
ill go check linuxbios for spd reading hacks
-- 
Who logs in to gdm? Not I, said the duck.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

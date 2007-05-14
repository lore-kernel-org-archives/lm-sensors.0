From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 14 May 2007 19:54:48 +0000
Subject: Re: [lm-sensors] hwmon/w83627ehf
Message-Id: <4648BE88.60906@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
In-Reply-To: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lambert,

Please CC the list too.

Lambert Carsten wrote:
> Client found at address 0x2f
> Probing for `National Semiconductor LM78'...                No
> Probing for `National Semiconductor LM78-J'...              No
> Probing for `National Semiconductor LM79'...                No
> Probing for `National Semiconductor LM80'...                No
> Probing for `Analog Devices ADT7470'...                     No
> Probing for `Winbond W83781D'...                            No
> Probing for `Winbond W83782D'...                            No
> Probing for `Winbond W83792D'...                            No
> Probing for `Winbond W83793R/G'...                          No
> Probing for `Winbond W83791SD'...                           No
> Probing for `Winbond W83627HF'...                           No
> Probing for `Winbond W83627EHF'...                          No
> Probing for `Winbond W83627DHG'...                          No
> Probing for `Asus AS99127F (rev.1)'...                      No
> Probing for `Asus AS99127F (rev.2)'...                      No
> Probing for `Asus ASB100 Bach'...                           No
> Probing for `Analog Devices ADM9240'...                     No
> Probing for `Dallas Semiconductor DS1780'...                No
> Probing for `National Semiconductor LM81'...                No
> Probing for `Analog Devices ADM1029'...                     No
> Probing for `ITE IT8712F'...                                No
> Probing for `Fintek custom power control IC'...             No
> Probing for `Winbond W83791D'...                            No
> Client found at address 0x30
> Client found at address 0x32
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Client found at address 0x50
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x52
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x69
> Client found at address 0x6a
> 
> Found `Winbond W83627DHG Super IO Sensors'                  Success!
>     (address 0xa00, driver `w83627ehf')
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 0400'
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `eeprom' (confidence: 6)
>   * Bus `SMBus I801 adapter at 0400'
>     Busdriver `i2c-i801', I2C address 0x52
>     Chip `eeprom' (confidence: 6)
> 
>   EEPROMs are *NOT* sensors! They are data storage chips commonly
>   found on memory modules (SPD), in monitors (EDID), or in some
>   laptops, for example.
> 
> Driver `w83627ehf' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0a00 (Busdriver `i2c-isa')
>     Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify other file 
> name?
>   (yes/NO/s):
> 
> ######################
> isadump -y 0x0A05 0xA05
> ######################
> 

So there is some chip I think you did:
isadump -y 0x0A05 0xA06



>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 ff 04 60 14 00 37 10 01 50 01 50 3c 10 02 02 
> 10: 04 ff ff 00 00 01 01 3c 43 17 00 00 ff ff ff d7 
> 20: a5 e8 cc cc c5 cf c2 31 ff c2 ff da 00 04 10 10 
> 30: 12 ca 3b 02 a2 08 a8 21 90 13 0a 06 fe 00 01 ff 
> 40: 01 00 10 ff ff ff 07 e5 2d 00 00 84 18 95 00 a3 
> 50: ff ff 00 ff ff ff 80 80 c1 7f ff ff 19 a5 00 05 
> 60: 04 ff 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff 
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 80: 04 ff 04 60 14 00 37 10 01 50 01 50 3c 10 02 02 
> 90: 04 ff ff 00 00 01 01 3c 43 17 00 00 ff ff ff d7 
> a0: a5 e8 cc cc c5 cf c2 31 ff c2 ff da 00 04 10 10 
> b0: 12 ca 3b 02 a2 08 a8 21 90 13 0a 06 fe 00 01 ff 
> c0: 01 00 10 ff ff ff 07 e5 2d 00 00 84 18 95 00 a3 
> d0: ff ff 00 ff ff ff 80 80 c1 7f ff ff 19 a5 00 05 
> e0: 04 ff 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff 
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 
> ######################
> isadump -y -k 0x87,0x87 0x2e 0x2f 0xb 0x7
> ######################
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

Maybe it lives on 0x4e/0x4f ? Could you please try the latest sensors-detect 
(check our devices page how to get it) and try with:
isadump -y -k 0x87,0x87 0x4e 0x4f 0xb 0x7

Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

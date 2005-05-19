From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket #: 758, ITE IT8712F-A not detected, and not
Message-Id: <3C35D7F1.2BD81CC6@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

please rerun with the correct arguments
'isadump 0x295 0x296'
I can look at boosting the confidence for the it8712 detection 
from 7 to 8 so it will be recommended over the lm78.
mds

Jakub Narebski wrote:
> 
> Here comes the output of isadump output (which was missing in previous
> e-mail)
> 
> [root@localhost root]# isadump -f 0
> [...]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: e4 38 43 fd 00 ff b6 e0 80 00 00 00 00 00 00 00
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 80 f8 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: 80 0e 98 b4 ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 9c 3c ff ff 14 ff ff ff ff ff ff ff ff ff ff ff
> 70: 00 36 00 00 00 36 ff ff ff ff ff ff ff ff ff ff
> 80: 94 26 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: ff ff 02 ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: 00 27 ff ff ff ff ff ff 00 00 ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: a8 64 b7 f8 a2 f9 10 23 54 20 a5 6d 7b a8 a0 b8
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> P.S. I don't know what I have changed, but now the sensors-detect detect
> properly ITE IT8712F sensors chip (and also misdetect it as LM78 chip).
> The only error is that sensors-detect claims that one should use LM87
> (instead of looking on the motherboard or motherboard/chipset website for
> the sensors chip used) even though both chips have _the same_ confidence.
> It is also strange that the summary for LM78 and IT87 chips is
> inconsistient: it differs in form.
> 
> The shortened log follows:
> 
> [root@localhost root]# modprobe i2c-viapro i2c-dev i2c-isa
> [root@localhost root]# modprobe it87 ignore=0,0x2d temp_type=0x38
> [root@localhost root]# lsmod
> Module                  Size  Used by
> it87                    6704   0  (unused)
> i2c-proc                6128   0  [it87]
> i2c-dev                 3616   0  (unused)
> i2c-isa                 1152   0  (unused)
> i2c-viapro              3648   0  (unused)
> i2c-core               13248   0  [it87 i2c-proc i2c-dev i2c-isa i2c-viapro]
> [...]
> [root@localhost root]# sensors -s
> [root@localhost root]# sensors-detect
> [...]
> Next adapter: SMBus Via Pro adapter at 5000 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x2d
> Probing for 'National Semiconductor LM78'... Success!
>     (confidence 7, driver 'lm78')
> Probing for  'ITE IT8705F / IT8712F / SiS 950'... Success!
>     (confidence 7, driver 'it87')
> Client found at address 0x50
> Probing for 'Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver 'eeprom')
> Client found at address 0x69
> 
>  Some chips are also accessible through the ISA bus. ISA probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan the ISA bus? (YES/no):
> Probing for 'National Semiconductor LM78'
>   Trying address 0x0290... Success!
>     (confidence 7, driver 'lm78')
>     Alias of the chip on I2C bus 'SMBus Via Pro adapter at 5000', address 0x002d
> Probing for 'ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Success!
>     (confidence 7, driver 'it87')
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
> 
> Driver `lm78' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x2d
>     ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `National Semiconductor LM78' (confidence: 7)
> 
> Driver `it87' (may not be inserted):
>   Misdetects:
>   * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x2d
>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 7)
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 7)
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x50
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
> 
> --
> Jakub Nar?bski
>     Poland

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 05 Apr 2006 07:50:50 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <443376DA.3060504@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c657ef$bd81d2c0$937ba8c0@genesis>
In-Reply-To: <000001c657ef$bd81d2c0$937ba8c0@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> /Module                  Size  Used by/
> /i2c_dev                 9968  0/
> /w83627hf               28394  0/
> /hwmon_vid               2475  1 w83627hf/
> /eeprom                  6884  0/
> /i2c_isa                 4548  1 w83627hf/
> /i2c_ali1563             6992  0/
> /i2c_core               19325  5
> i2c_dev,w83627hf,eeprom,i2c_isa,i2c_ali1563/

> 
> /i2c-0   smbus           SMBus ALi 1563 Adapter @ 0400           Non-I2C
> SMBus adapter/
> 

> /     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f/
> /00:          XX XX XX XX XX XX XX XX XX XX XX XX XX/
> /10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX/
> /20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX/
> /30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX/
> /40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX/
> /50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX/
> /60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX/
> /70: XX XX XX XX XX XX XX XX/

> *Relevant sensors detect output:*
> 
> / /
> 
> /We will now try to load each adapter module in turn.
> Load `i2c-ali1563' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
> Load `rivatv' (say NO if built into your kernel)? (YES/no):
> FATAL: Module rivatv not found.
> Loading failed... skipping.
> ** Note: rivatv module is available at //http://rivatv.sourceforge.net///
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
> To continue, we need module `i2c-dev' to be loaded.
> If it is built-in into your kernel, you can safely skip this.
> i2c-dev is already loaded.
> 
> We are now going to do the adapter probings. Some adapters may hang halfway
> through; we can't really help that. Also, some chips will be double
> detected;
> we choose the one with the highest confidence value in that case.
> If you found that the adapter hung after probing a certain address, you can
> specify that address to remain unprobed. That often
> includes address 0x69 (clock chip).
> 
> Next adapter: SMBus ALi 1563 Adapter @ 0400
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
> (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x51
> Probing for `SPD EEPROM'... Success!
> (confidence 8, driver `eeprom')
> Client found at address 0x69
> 
> Some chips are also accessible through the ISA bus. ISA probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 


You have no sensor on i2c bus.

> Do you want to scan the ISA bus? (YES/no):
> 
> Probing for `Winbond W83627HF'
> Trying address 0x0290... Success!
> (confidence 8, driver `w83781d')
>
> Some Super I/O chips may also contain sensors. Super I/O probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `Winbond W83627HF Super IO Sensors'
> Success... found at address 0x0290/

Please can you provide dump of:

isadump 0x295 0x296

Thanks,

Regards
Rudolf



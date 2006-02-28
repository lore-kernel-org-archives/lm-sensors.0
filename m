From: poulerik@pea.dk (Poul-Erik Andreasen)
Date: Tue, 28 Feb 2006 14:34:08 +0000
Subject: [lm-sensors] No sensors detected on the ASUS K8V-MX motherboard
Message-Id: <44045F60.6050003@pea.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <3c456d310602280419w5f5aa2d0qeea498e936814892@mail.gmail.com>
In-Reply-To: <3c456d310602280419w5f5aa2d0qeea498e936814892@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi David,
>
>On 2006-02-28, David Wu wrote:
>  
>
>>I am hoping someone can help me to either get the lm_sensors running
>>or at least give me a explanation as why I can't find any sensor chip
>>on the ASUS K8V-MX motherboard with VIA VT8237R chip. I have included
>>the necessary information below. I have the AMD socket 754 AMD Sempron
>>2500+ running at 1.4GHz.
>>    
>>
>
>According to the Asus documentation for this board, it does indeed have
>hardware monitoring features, so it's really only a matter of finding
>the right chip, driver and configuration.
>
>Note that the VT8237R chip is not a hardware monitoring chip by itself,
>although it may be used to access such chips (if they use an I2C/SMBus
>interface.)
>
>  
>
>>Next adapter: SMBus Via Pro adapter at 0400
>>Do you want to scan it? (YES/no/selectively): YES
>>Client found at address 0x50
>>Probing for `SPD EEPROM'... Success!
>>    (confidence 8, driver `eeprom')
>>Probing for `DDC monitor'... Failed!
>>Probing for `Maxim MAX6900'... Failed!
>>Client found at address 0x69
>>    
>>
>
>No hardware monitoring chip on the SMBus (or it is hidden, happens with
>Asus boards sometimes).
>
>  
>
>>Probing for `Winbond W83627EHF Super IO Sensors'
>>  Success... found at address 0x0290
>>    
>>
>
>This is most probably your hardware monitoring chip.
>
>  
>
>># no driver for Winbond W83627EHF Super IO Sensors yet
>>    
>>
>
>You must use an old version of the sensors-detect script, as a driver now
>exists (unsurprisingly named w83627ehf.)
>
>If you have a 2.6.13 or better kernel, you probably have that driver
>already, so just load it ("modprobe w83627ehf" as root) and it should
>work. You will most certainly need to upgrade lm_sensors (to 2.9.1 or
>better) for the "sensors" command to work though, as your version
>seems to predate the writing of the driver and associated user-space
>support.
>
>  
>
>>So it appears that it detect the SMBus controller, the VIA 8237R, fine
>>and loaded the proper i2c adapter bus driver. But there is no sensor
>>chip found!???  No even the AMD CPU sensor??!!!
>>    
>>
>
>It did find the chip, but just didn't know what driver to load. Now you
>know.
>
>As an adidtional note, what you call "AMD CPU sensor" is really only a
>sensor (most likely a thermal diode), not a hardware monitoring chip. As
>such, it is useless until it is wired to a hardware monitoring chip,
>such as the W83627EHF you have on your motherboard.
>
>--
>Jean Delvare  
>
When kan we expect at update on the W83627EHF to include som fancontrol
and some of the other advanced fetures of the chip. I am sitting with a machine
suited with some nice 120 mm fans, but the minimum-setting on the fanspeed
is way to high, an it can not be altered in the BIOS.  

Unfortunatly i am lousy in C in general and i do not know anything about
kernel-development, so i cannot realy paticipate, in development. 
But maybe you can use mee as a  beta tester.

--
Poul-Erik Andreasen

poulerik at pea.dk



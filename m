From: adobin@gmail.com (Alexander Dobin)
Date: Wed, 01 Feb 2006 00:12:59 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m - SUCCESS
Message-Id: <aaa5cd0c0601311612u3320669ewcc9e9d39b1a56b7a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43DA95AC.70504@sh.cvut.cz>
In-Reply-To: <43DA95AC.70504@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Jean and Rudolf,

I have flashed the BIOS with most recent ASUS update 0204
(of Jan 25) and lm_sensors immediatly detected the w83792d chip,
and I am getting out good numbers!

Thank you very much for this solution!
I am sorry I had you spend time on the EHF chip which apparently
does not work.
I actually had my BIOS flashed before I started this work (it was 0203), but
it looks like ASUS just put in the right updates. What are the chances of
that?

I am very happy with the results, but
please let me know if you need me to do anything else,
Again, thanks a lot for your help,
Alex

From sensors:

w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
VCoreA:    +1.24 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VCoreB:    +1.24 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VIN0:      +3.39 V  (min =  +3.20 V, max =  +3.39 V)
VIN1:      +3.14 V  (min =  +3.09 V, max =  +3.30 V)
VIN2:      +1.48 V  (min =  +1.39 V, max =  +1.49 V)
VIN3:      +1.79 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
5VCC:      +5.12 V  (min =  +4.73 V, max =  +5.23 V)
5VSB:      +4.99 V  (min =  +4.73 V, max =  +5.23 V)
VBAT:      +3.04 V  (min =  +2.85 V, max =  +3.14 V)
Fan1:        0 RPM  (min =    0 RPM, div = 32)
Fan2:     2678 RPM  (min =    0 RPM, div = 4)
Fan3:     2280 RPM  (min =    0 RPM, div = 4)
Fan4:        0 RPM  (min =    0 RPM, div = 32)
Fan5:        0 RPM  (min =    0 RPM, div = 32)
Fan6:        0 RPM  (min =    0 RPM, div = 2)
Fan7:        0 RPM  (min =    0 RPM, div = 32)
Temp1:     +30.0?C  (high = +127.0?C, hyst =  +0.0?C)
Temp2:     +32.5?C  (high = +80.0?C, hyst = +75.0?C)
Temp3:    +127.0?C  (high = +80.0?C, hyst = +75.0?C)   ALARM
chassis:  Chassis intrusion detection                  ALARM

From sensors-detect:
Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Success!
    (confidence 7, driver `w83792d'), other addresses: 0x4b 0x4f
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8712F'... Failed!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x4b
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x4f
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x71

On 1/31/06, Jean Delvare <khali at linux-fr.org> wrote:
>
> Hi Alexander,
>
> > you are right  - there is w83792ad chip on board.
> > I am sorry I did not see it  - but the lm_sensors did not even probe
> > for it (see below). Please let me know if I am doing something wrong.
>
> Asus has the habit to hide the W83792D/AD chip on their boards by
> multiplexing the SMBus using arbitrary GPIO pins. This is why
> sensors-detect fails to even see the chip.
>
> We need additional information from Asus to work it out. They helped
> Rudolf Marek a few times before already, so hopefully they'll help
> again.
>
> Thanks,
> --
> Jean Delvare
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060201/b1cc115e/attachment.html

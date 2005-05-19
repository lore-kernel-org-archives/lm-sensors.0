From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: [Fwd: i850 && lm_sensors] (long)
Message-Id: <200307261433.28061.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne po 21. ?ervence 2003 14:37 jste napsal(a):
> > i2cdetect 0:
> >
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
> > 30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> > 50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>
> OK. 0x50 and 0x51 are your memory chip EEPROMs. 0x30 and 0x31 are likely
> to be "ghost images" of these EEPROMs, don't care about them. 0x2d is
> used very often by sensor chips, I think your chip is there. 0x44 isn't
> used by any chip we know of, but it could be a subaddress for the chip
> at 0x2d.
>
> The sensors-detect script didn't find what the chip at 0x2d is, so
> whatever it is, it's likely to be unsupported for now. However, it may
> be similar enough to a chip we know to either direclty work with another
> driver, or be possibly added to a driver.
>
> I would like you to run "i2cdump 0 0x2d" and tell us what it says.
> Additionally, the output of "i2cdump 0 0x44" would be welcome.

all right, output of "i2cdump 0 0x2d":

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX 04 XX XX XX XX XX XX XX XX XX XX    XXXXX?XXXXXXXXXX
20: bf 7d c2 c1 00 be 29 29 XX XX XX 00 00 00 00 00    ?}??.?))XXX.....
30: 00 00 00 00 00 00 00 00 00 00 00 XX XX XX a1 21    ...........XXX?!
40: 29 3f 02 XX XX XX XX 0e XX 80 XX XX XX XX XX XX    )??XXXX?X?XXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

i2cdump 0 0x44:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 0f 3f 00 00 02 00 50 00 00 00 00 00 00 00    ..??..?.P.......
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

> > on Intel's Express Installer CD is "Intel Active Monitor" (windows
> > version of course ;-( and it works perfectly. It works with Intel
> > SMBus driver, so one of this chips is on my motherboard:
> >
> > Intel(R) 82801AA  I/O Controller Hub (ICH)
> > Intel(R) 82801AB  I/O Controller Hub (ICH0)
> > Intel(R) 82801BA  I/O Controller Hub (ICH2)
> > Intel(R) 82801CAM I/O Controller Hub (ICH3M)
> > Intel(R) 82801DB  I/O Controller Hub (ICH4)
> >
> > Manual of iD850EMD2 && iD850EMV2 talks about Intel 82801BA I/O
> > Controller Hub (=ICH2), so this is "problem" chip.
>
> I don't think the bus chip cause any problem. It is detected and seem to
> work. The sensor chip is the problem.
>
> Could you use the Windows software to try to find out what the sensor
> chip name is? That would help us a lot. 

I looked for it on intel developers page - http://developer.intel.com. 
Results:

(pdf document "Intel Desktop Board D850EMD2/D850EMV2 Technical Product 
Specification")

1.13 Hardware Managment Subsystem

- compatibile with WfM

http://www.intel.com/labs/manage/wfm/wfmspecs.htm - WfM (Wired For Management 
Baseline - version 2.0)

- fan control and monitoring
- thermal  and voltage monitoring

1.13.1 Hardware Monitoring ASICs

- D850EMV2/D850EMD2 provide one of the following:
(1) a hardware monitoring ASIC (Analog Devices ADM1025, Philips Semiconductor 
NE1619, or equivalent) include:

-- internal ambient temperature sensor
-- remote thermal diode sensor for direct monitoring of processor temperature
-- power supply monitoring of four voltages to detect levels above or below 
acceptable values
-- SMBus interface (SMBus support to access sensor data on the board like in 
(2))

The Analog Devices ADM1025 -> http://www.analogdevices.com
The Philips Semiconductor NE1619 -> http://www.philipssemiconductor.com

(2) hardware monitoring and fan control ASIC (Analog Devieces ADM1027, 
National Semiconductor LM85, Standart Microsystems SMSC EMC6D101, or 
equivalent) include:

-- internal ambient temperature sensor
-- two remote thermal diode sensors for direct monitoring of processor 
temperature and ambient temperature sensing
-- power supply monitoring of five voltages to detect levels above or below 
acceptable values
-- fan monitoring for all fans 
-- thermally monitored closed-loop fan control, or all three fans, that can 
adjust the fan speed or switch the fans on or off as needed
-- SMBus interface

The Analog Devicecs ADM1027 -> http://www.analogdevices.com
The National Semiconductor LM85 -> http://www.national.com
The Standart Microsystems SMSC EMC6D101 -> http://www.smsc.com

>If you could tell us how many
> values and of what kind it returns, it would help too (how many
> voltages, temperatures, can you set a low limit, a high limit,
> hysteresis values, and so on). Maybe you could find info in the
> motherboard manual too.

OK, "System Information Report" (all, btw: system had 0% idle)


                I N T E L (R)   A C T I V E   M O N I T O R
 
                         System Information Report
                            26.7.2003 12:12:38
 
***************************************************************************
                            General Information
***************************************************************************
Product name        Genuine Intel(R) Pentium(R) 4 processor based system
Board model         Genuine Intel(R) D850EMV2 system board
OS version          Windows* 98 SE version 4.10  build 2222
OS memory           523 496 KB RAM
 
***************************************************************************
                                 Processor
***************************************************************************
Processor           Genuine Intel(R) Pentium(R) 4 processor
Processor speed     Unknown
Bus speed           400 MHz
L1 cache            Data Cache 8KB, Execution Trace Cache 12K Micro-ops
L2 cache            Advanced Transfer Cache 512 KB
Form factor         ZIF Socket
Stepping            4
 
***************************************************************************
                                  System
***************************************************************************
Physical memory     512 MB RAM
Memory speed        PC800
Memory type         Other, RAMBUS
Form factor         RIMM
BIOS date           03/28/2002
BIOS size           512 KB
BIOS version        P10 (MV85010A.86A.0025.P10.0203282158)
 
***************************************************************************
                                  Sensors
***************************************************************************
Sensor Name         System Fan 1
Current Value       3 840
Upper Threshold     not applicable
Lower Threshold     500
 
Sensor Name         Processor Zone
Current Value       51
Upper Threshold     70
Lower Threshold     not applicable
 
Sensor Name         System Zone 1
Current Value       45
Upper Threshold     50
Lower Threshold     not applicable
 
Sensor Name         +3.3 V standby
Nominal Value       3,300
Current Value       3,266
Upper Threshold     4,500
Lower Threshold     2,100
 
Sensor Name         +5 V
Nominal Value       5,000
Current Value       5,026
Upper Threshold     6,000
Lower Threshold     4,000
 
Sensor Name         +3.3 V
Nominal Value       3,300
Current Value       3,317
Upper Threshold     4,300
Lower Threshold     2,300
 
Sensor Name         CPU Core (+1.5 V)
Nominal Value       1,500
Current Value       1,447
Upper Threshold     2,300
Lower Threshold     0,700
 
Sensor Name         Memory (+2.5 V)
Nominal Value       2,500
Current Value       2,487
Upper Threshold     3,300
Lower Threshold     1,700
 
 
***************************************************************************
                               End of Report
***************************************************************************
 
*Third-party brands and names are the property of their respective owners.
 
I tried to something else - sensors-detect with module "i2c-philips-par":

Next adapter: Philips Parallel port adapter (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x00
Client found at address 0x01
Client found at address 0x02
Client found at address 0x03
Client found at address 0x04
Client found at address 0x05
Client found at address 0x06
Client found at address 0x07
Client found at address 0x08
Client found at address 0x09
Client found at address 0x0a
Client found at address 0x0b
Probing for `Smart Battery'... Failed!
Client found at address 0x0c
Client found at address 0x0d
Client found at address 0x0e
Client found at address 0x0f
Client found at address 0x10
Client found at address 0x11
Client found at address 0x12
Client found at address 0x13
Client found at address 0x14
Client found at address 0x15
Client found at address 0x16
Client found at address 0x17
Client found at address 0x18
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x19
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x1a
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x1b
Client found at address 0x1c
Client found at address 0x1d
Client found at address 0x1e
Client found at address 0x1f
Client found at address 0x20
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x21
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x23
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x24
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x25
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x26
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x27
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x28
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x29
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2a
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2b
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2c
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Winbond W83L785TS'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x31
Client found at address 0x32
Client found at address 0x33
Client found at address 0x34
Client found at address 0x35
Client found at address 0x36
Client found at address 0x37
Client found at address 0x38
Client found at address 0x39
Client found at address 0x3a
Client found at address 0x3b
Client found at address 0x3c
Client found at address 0x3d
Client found at address 0x3e
Client found at address 0x3f
Client found at address 0x40
Client found at address 0x41
Client found at address 0x42
Client found at address 0x43
Client found at address 0x44
Client found at address 0x45
Client found at address 0x46
Client found at address 0x47
Client found at address 0x48
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4a
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4b
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4c
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `National Semiconductor LM90'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4d
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4f
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x56
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x58
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x59
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5a
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5b
Client found at address 0x5c
Client found at address 0x5d
Client found at address 0x5e
Client found at address 0x5f
Client found at address 0x60
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x62
Client found at address 0x63
Client found at address 0x64
Client found at address 0x65
Client found at address 0x66
Client found at address 0x67
Client found at address 0x68
Client found at address 0x69
Client found at address 0x6a
Client found at address 0x6b
Client found at address 0x6c
Client found at address 0x6d
Client found at address 0x6e
Client found at address 0x6f
Client found at address 0x70
Client found at address 0x71
Client found at address 0x72
Client found at address 0x73
Probing for `FSC poseidon chip'... Failed!
Probing for `FSC Scylla chip'... Failed!
Client found at address 0x74
Client found at address 0x75
Client found at address 0x76
Client found at address 0x77
Client found at address 0x78
Client found at address 0x79
Client found at address 0x7a
Client found at address 0x7b
Client found at address 0x7c
Client found at address 0x7d
Client found at address 0x7e
Client found at address 0x7f

but output of sensors:

lm84-i2c-1-18
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-19
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-1a
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-29
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-2a
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-2b
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-4c
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-4d
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm84-i2c-1-4e
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

the same output:

Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm80-i2c-1-20
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-21
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-22
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-23
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-24
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-25
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-26
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-27
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-28
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-29
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

lm80-i2c-1-2a
Adapter: Philips Parallel port adapter
Algorithm: Bit-shift algorithm

the same output:

+5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
VTT:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
fan1:       -1 RPM  (min =   -1 RPM, div = 1)
fan2:       -1 RPM  (min =   -1 RPM, div = 1)
temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
         (os: limit =  +0?C,  hysteresis =  +0?C)

> > btw: unfortunately, I'll go to holiday next week, so I won't be able
> > to reply mails :-(
>
> That ain't unfortunate. Holidays are great :)

yes, that's right. Long week (almost) without computers, monitors, keybords 
.. really great ;-)

-- 
Ondrej Cecak


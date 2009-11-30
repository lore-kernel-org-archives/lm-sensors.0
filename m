From: Sean Fidler <fidlersean@gmail.com>
Date: Mon, 30 Nov 2009 23:08:46 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <alpine.OSX.2.00.0911301803270.346@blackbird.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your assistance.

Please find the requested information below: output of sensors-detect,
/proc/ioports and the kernel log entry after attempting to load smsc47m1

##############################
#sensors-detect revision 5249# 
##############################

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801DB ICH4

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 1880 (i2c-0)
Do you want to scan it? (YES/no/selectively): Client found at address 0x2d
Handled by driver `smsc47m192' (already loaded), chip type `smsc47m192'
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Next adapter: intel drm CRTDDC_A (i2c-1)
Do you want to scan it? (YES/no/selectively): Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
     (confidence 8, not a hardware monitoring chip)

Next adapter: bt878 #0 [sw] (i2c-2)
Do you want to scan it? (YES/no/selectively): Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC LPC47M15x/192/997 Super IO Fan Sensors'
     (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 
Driver `smsc47m192' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at 1880'
     Busdriver `i2c-i801', I2C address 0x2d
     Chip `smsc47m192' (confidence: 6)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 
To load everything that is needed, add this to /etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
smsc47m192
#----cut here----

Do you want to add these lines automatically? (yes/NO)

################
# /proc/ioports#
################

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:1f.1
   0170-0177 : ata_piix
01f0-01f7 : 0000:00:1f.1
   01f0-01f7 : ata_piix
0376-0376 : 0000:00:1f.1
   0376-0376 : ata_piix
0378-037a : parport0
03c0-03df : vga+
03f2-03f2 : floppy
03f4-03f5 : floppy
03f6-03f6 : 0000:00:1f.1
   03f6-03f6 : ata_piix
03f7-03f7 : floppy
03f8-03ff : serial
04d0-04d1 : pnp 00:01
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
   1000-107f : pnp 00:01
     1000-1003 : ACPI PM1a_EVT_BLK
     1004-1005 : ACPI PM1a_CNT_BLK
     1008-100b : ACPI PM_TMR
     1010-1015 : ACPI CPU throttle
     1020-1020 : ACPI PM2_CNT_BLK
     1028-102f : ACPI GPE0_BLK
1180-11bf : 0000:00:1f.0
   1180-11bf : pnp 00:01
1800-181f : 0000:00:1d.0
   1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
   1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
   1840-185f : uhci_hcd
1860-186f : 0000:00:1f.1
   1860-186f : ata_piix
1880-189f : 0000:00:1f.3
   1880-189f : i801_smbus
2000-2fff : PCI Bus 0000:02
   2000-20ff : 0000:02:02.0
     2000-20ff : 8139too
fe00-fe00 : pnp 00:01

############
#kernal log#
############

Nov 30 17:44:21 ubuntu kernel: [  728.046978] smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
Nov 30 17:44:21 ubuntu kernel: [  728.046997] smsc47m1: Device is disabled, will not use

On Mon, 30 Nov 2009, Jean Delvare wrote:

> Hi Sean,
>
> On Mon, 30 Nov 2009 16:30:42 -0500 (EST), Sean Fidler wrote:
>> I recently installed Ubuntu Server 9.10 on a Compaq Presario
>> S4000NX. Sensor info: chip is LPC47M192-NC and the bus is
>> bus "i2c-2" "SMBus I801 adapter at 1880"
>>
>> When running "sensors" no information is shown for the CPU fan (there
>> are no entries for fans at all.) Only entries for voltages and
>> temperatures are available.
>>
>> pwmconfig states that there are no modules installed. Am I out of luck
>> with trying to control the CPU fan speed? Thanks!
>
> Full output of sensors-detect please. The SMSC LPC47M192 is supported
> by two drivers: smsc47m1 for the fans and smsc47m192 for the voltages
> and temperatures. Make sure both are loaded. If it still doesn't work,
> please also provide the contents of /proc/ioports and check for error
> messages in your kernel logs when loading the smsc47m1 driver.
>
> -- 
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

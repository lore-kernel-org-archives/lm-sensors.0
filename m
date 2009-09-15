From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
Date: Tue, 15 Sep 2009 13:11:39 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <4AAF928B.7030902@ribosome.natur.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Hi Martin,
> 
> Please keep the list in Cc or I am no longer replying.

sorry for that.

> 
> On Tue, 15 Sep 2009 00:53:41 +0200, Martin MOKREJŠ wrote:
>> Hi Jean,
>>   yes, on 2.6.30.4 it "works" (probably in the broken way):
> 
> This is exactly the symptom described in the blog post I sent you to.
> http://hansdegoede.livejournal.com/7932.html
> Did you read it?

I did and therefore it seemed to me the problem is with the driver.
I haven't figured out I am using a wrong one. :( So I should probably
go and read the FAQ again. ;-)

> 
>> $ dmesg
>> [cut]
>> i801_smbus 0000:00:1f.3: PCI INT B -> Link[LNKB] -> GSI 11 (level, low) -> IRQ 11
>> [cut]
>>
>> $ sensors
>> ds1621-i2c-4-4c
>> Adapter: SMBus I801 adapter at e800
>> temp:     +51.00°C  (low  = +51.0°C, high = +51.0°C)  ALARM (LOW)
> 
> You don't really have a DS162x chip on your system, do you? The output
> above is rather suspicious. Does the temperature value ever changes?

At the moment I have under 2.6.30.6:

# sensors
ds1621-i2c-4-4c
Adapter: SMBus I801 adapter at e800
temp:     +64.00°C  (low  = +64.0°C, high = +64.0°C)  ALARM (HIGH)

# lspci
00:00.0 Host bridge: Intel Corporation 82845 845 [Brookdale] Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corporation 82845 845 [Brookdale] Chipset AGP Bridge (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB Controller #2 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corporation 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801CA/CAM AC'97 Audio Controller (rev 02)
00:1f.6 Modem: Intel Corporation 82801CA/CAM AC'97 Modem Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
#
> 
> This chip is very difficult to detect and misdetections are very
> frequent. We should probably even disable it altogether. So if that's
> all you had with kernel 2.6.30.4, it hardly qualifies as "worked".

The below is probably useless to you as long as the driver is statically included in the kernel,
right?

# sensors-detect 
# sensors-detect revision $Revision$
# Board: ASUSTeK Computer INC. P4_L3C

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): 
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8739x Super IO'                         
    (no hardware monitoring capabilities)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): 
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): 
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801CA/CAM ICH3
WARNING: Deprecated config file /etc/modprobe.conf, all config files belong into /etc/modprobe.d/.
WARNING: All config files need .conf: /etc/modprobe.d/ath_pci, it will be ignored in a future release.
WARNING: All config files need .conf: /etc/modprobe.d/slmodem, it will be ignored in a future release.
FATAL: Module i2c_i801 not found.
Failed to load module i2c-i801.

Next adapter: radeonfb monid (i2c-0)
Do you want to scan it? (YES/no/selectively): 

Next adapter: radeonfb dvi (i2c-1)
Do you want to scan it? (YES/no/selectively): 

Next adapter: radeonfb vga (i2c-2)
Do you want to scan it? (YES/no/selectively): 

Next adapter: radeonfb crt2 (i2c-3)
Do you want to scan it? (YES/no/selectively): 

Next adapter: SMBus I801 adapter at e800 (i2c-4)
Do you want to scan it? (YES/no/selectively): 
Client at address 0x4c can not be probed - unload all client drivers first!
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

Sorry, no sensors were detected.
Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.
#

Hmm, but when I had compiled all the available drivers as a module the driver
I use now was the one proposed.


Once again, it is ASUS L3C/S laptop.

Thanks,
M.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

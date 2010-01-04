From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, 04 Jan 2010 16:51:23 +0000
Subject: Re: [lm-sensors] SMSC SCH5147-NW not detected / supported
Message-Id: <191fb4ca1001040851l9a6f553n7aabda53678223c4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4cb1b6761001031453g147d8dcbj413a3e74d15c372@mail.gmail.com>
In-Reply-To: <4cb1b6761001031453g147d8dcbj413a3e74d15c372@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Marcus,


>> Hi guys,
>>
>> I have a HP EX490 and it has a SMSC SCH5147-NW for monitoring (found
>> via visual inspection of the board).  The vendor URL for this chip is
>> http://www.smsc.com/index.php?tid%4&pid1
>>
>> This does not appear to be detected or supported via lm-sensors -
>> though it does identify that there is a Super I/O SMSC device - the
>> trimmed information from sensors-detect is as follows:
>>
>>       Probing for Super-I/O at 0x2e/0x2f
>>       Trying family `SMSC'...                                     Yes
>>       Found unknown chip with ID 0xc101
>>
>> Unfortunately, google does not appear to be able to find the data
>> sheet for this chip and the only other references are for some Lenovo
>> gear that use them.
>>
>> Any ideas on how I'd progress with this?  I'm happy to do testing and
>> a bit of coding.
>
> I'll ask my contact at SMSC if he can provide a datasheet.

The chip seems to be close to a SCH311x. Try loading the dme1737
module with 'force_id=0x7c' module load parameter and report your
results.

...juerg


> ...juerg
>
>
>
>> Cheers,
>>
>> -I.
>>
>> --------------------------------------------------------------------------------------
>>
>> root@ythekshri:~# uname -a
>> Linux ythekshri 2.6.31-16-generic-pae #53-Ubuntu SMP Tue Dec 8
>> 05:20:21 UTC 2009 i686 GNU/Linux
>>
>> root@ythekshri:~# perl ./sensors-detect-20100102.pl
>> # sensors-detect revision 5814 (2009-12-20 18:11:48 +0100)
>> # System: HP MediaSmart Server
>> # Board: Wistron 532837-ZH1
>>
>> This program will help you determine which kernel modules you need
>> to load to use lm_sensors most effectively. It is generally safe
>> and recommended to accept the default answers to all questions,
>> unless you know what you're doing.
>>
>> Some south bridges, CPUs or memory controllers contain embedded sensors.
>> Do you want to scan for them? This is totally safe. (YES/no):
>> Silicon Integrated Systems SIS5595...                       No
>> VIA VT82C686 Integrated Sensors...                          No
>> VIA VT8231 Integrated Sensors...                            No
>> AMD K8 thermal sensors...                                   No
>> AMD Family 10h thermal sensors...                           No
>> AMD Family 11h thermal sensors...                           No
>> Intel Core family thermal sensor...                         Success!
>>    (driver `coretemp')
>> Intel Atom thermal sensor...                                No
>> Intel AMB FB-DIMM thermal sensor...                         No
>> VIA C7 thermal sensor...                                    No
>> VIA Nano thermal sensor...                                  No
>>
>> Some Super I/O chips contain embedded sensors. We have to write to
>> standard I/O ports to probe them. This is usually safe.
>> Do you want to scan for Super I/O sensors? (YES/no):
>> Probing for Super-I/O at 0x2e/0x2f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     Yes
>> Found unknown chip with ID 0xc101
>>                   <------ Unknown detected here.
>> Probing for Super-I/O at 0x4e/0x4f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     No
>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
>> Trying family `ITE'...                                      No
>>
>> Some systems (mainly servers) implement IPMI, a set of common interfaces
>> through which system health data may be retrieved, amongst other things.
>> We first try to get the information from SMBIOS. If we don't find it
>> there, we have to read from arbitrary I/O ports to probe for such
>> interfaces. This is normally safe. Do you want to scan for IPMI
>> interfaces? (YES/no):
>> Probing for `IPMI BMC KCS' at 0xca0...                      No
>> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>>
>> Some hardware monitoring chips are accessible through the ISA I/O ports.
>> We have to write to arbitrary I/O ports to probe them. This is usually
>> safe though. Yes, you do have ISA I/O ports even if you do not have any
>> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
>> Probing for `National Semiconductor LM78' at 0x290...       No
>> Probing for `National Semiconductor LM79' at 0x290...       No
>> Probing for `Winbond W83781D' at 0x290...                   No
>> Probing for `Winbond W83782D' at 0x290...                   No
>>
>> Lastly, we can probe the I2C/SMBus adapters for connected hardware
>> monitoring devices. This is the most risky part, and while it works
>> reasonably well on most systems, it has been reported to cause trouble
>> on some systems.
>> Do you want to probe the I2C/SMBus adapters now? (YES/no):
>> Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9
>>
>> Next adapter: intel drm CRTDDC_A (i2c-0)
>> Do you want to scan it? (YES/no/selectively):
>>
>> Next adapter: SMBus I801 adapter at 0400 (i2c-1)
>> Do you want to scan it? (YES/no/selectively):
>> Client found at address 0x50
>> Probing for `Analog Devices ADM1033'...                     No
>> Probing for `Analog Devices ADM1034'...                     No
>> Probing for `SPD EEPROM'...
>> Yes
>>    (confidence 8, not a hardware monitoring chip)
>> Probing for `EDID EEPROM'...                                No
>>
>> Now follows a summary of the probes I have just done.
>> Just press ENTER to continue:
>> Driver `coretemp':
>>  * Chip `Intel Core family thermal sensor' (confidence: 9)
>>
>> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
>> To load everything that is needed, add this to one of the system
>> initialization scripts (e.g. /etc/rc.d/rc.local):
>>
>> #----cut here----
>> # Chip drivers
>> modprobe coretemp
>> /usr/bin/sensors -s
>> #----cut here----
>>
>> If you have some drivers built into your kernel, the list above will
>> contain too many modules. Skip the appropriate ones! You really
>> should try these commands right now to make sure everything is
>> working properly. Monitoring programs won't work until the needed
>> modules are loaded.
>>
>> root@ythekshri:~# lspci
>> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM
>> Controller (rev 02)
>> 00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express
>> Integrated Graphics Controller (rev 02)
>> 00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB
>> UHCI Controller #4 (rev 02)
>> 00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB
>> UHCI Controller #5 (rev 02)
>> 00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB
>> UHCI Controller #6 (rev 02)
>> 00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2
>> EHCI Controller #2 (rev 02)
>> 00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
>> Port 1 (rev 02)
>> 00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
>> Port 3 (rev 02)
>> 00:1c.5 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express
>> Port 6 (rev 02)
>> 00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB
>> UHCI Controller #1 (rev 02)
>> 00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB
>> UHCI Controller #2 (rev 02)
>> 00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB
>> UHCI Controller #3 (rev 02)
>> 00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2
>> EHCI Controller #1 (rev 02)
>> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
>> 00:1f.0 ISA bridge: Intel Corporation 82801IR (ICH9R) LPC Interface
>> Controller (rev 02)
>> 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH)
>> 6 port SATA AHCI Controller (rev 02)
>> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
>> 02:00.0 Mass storage controller: Silicon Image, Inc. Sil 3531
>> [SATALink/SATARaid] Serial ATA Controller (rev 01)
>> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>> RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
>>
>> root@ythekshri:~# cat /proc/ioports
>> 0000-001f : dma1
>> 0020-0021 : pic1
>> 0040-0043 : timer0
>> 0050-0053 : timer1
>> 0060-0060 : keyboard
>> 0064-0064 : keyboard
>> 0070-0071 : rtc0
>> 0080-008f : dma page reg
>> 00a0-00a1 : pic2
>> 00c0-00df : dma2
>> 00f0-00ff : fpu
>> 02f8-02ff : serial
>> 0378-037a : parport0
>> 037b-037f : parport0
>> 03c0-03df : vga+
>> 03f8-03ff : serial
>> 0400-041f : 0000:00:1f.3
>>  0400-041f : i801_smbus
>> 0480-04bf : 0000:00:1f.0
>>  0480-04bf : pnp 00:0a
>> 04d0-04d1 : pnp 00:0a
>> 0800-087f : 0000:00:1f.0
>>  0800-087f : pnp 00:0a
>>    0800-0803 : ACPI PM1a_EVT_BLK
>>    0804-0805 : ACPI PM1a_CNT_BLK
>>    0808-080b : ACPI PM_TMR
>>    0810-0815 : ACPI CPU throttle
>>    0820-082f : ACPI GPE0_BLK
>> 0a00-0a7f : pnp 00:09
>> 0cf8-0cff : PCI conf1
>> b400-b41f : 0000:00:1f.2
>>  b400-b41f : ahci
>> b480-b483 : 0000:00:1f.2
>>  b480-b483 : ahci
>> b800-b807 : 0000:00:1f.2
>>  b800-b807 : ahci
>> b880-b883 : 0000:00:1f.2
>>  b880-b883 : ahci
>> bc00-bc07 : 0000:00:1f.2
>>  bc00-bc07 : ahci
>> c000-c01f : 0000:00:1d.2
>>  c000-c01f : uhci_hcd
>> c080-c09f : 0000:00:1d.1
>>  c080-c09f : uhci_hcd
>> c400-c41f : 0000:00:1d.0
>>  c400-c41f : uhci_hcd
>> c480-c49f : 0000:00:1a.2
>>  c480-c49f : uhci_hcd
>> c800-c81f : 0000:00:1a.1
>>  c800-c81f : uhci_hcd
>> c880-c89f : 0000:00:1a.0
>>  c880-c89f : uhci_hcd
>> cc00-cc07 : 0000:00:02.0
>> d000-dfff : PCI Bus 0000:02
>>  dc00-dc7f : 0000:02:00.0
>> e000-efff : PCI Bus 0000:03
>>  e800-e8ff : 0000:03:00.0
>>    e800-e8ff : r8169
>> root@ythekshri:~#
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

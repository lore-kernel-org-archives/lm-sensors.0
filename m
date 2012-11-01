From: Logan Freijo <loganfreijo@embarqmail.com>
Date: Thu, 01 Nov 2012 16:38:21 +0000
Subject: Re: [lm-sensors] f71882fg not showing motherboard temps
Message-Id: <5092A57D.8040808@embarqmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5091A80D.3090101@embarqmail.com>
In-Reply-To: <5091A80D.3090101@embarqmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/1/2012 12:19 PM, Hans de Goede wrote:
> Hi,
>
> On 11/01/2012 05:03 PM, Logan Freijo wrote:
>> On 11/1/2012 12:49 AM, Guenter Roeck wrote:
>>> On Wed, Oct 31, 2012 at 06:37:01PM -0400, Logan Freijo wrote:
>>>> **Hello. I have a system running Ubuntu Server 12.04.1 on a Jetway
>>>> motherboard. Sensors-detect finds my AMD cpu temp and a chip for the
>>>> motherboard (f71882fg). However, after adding the suggested line to
>>>> /etc/modules and rebooting, only the cpu temp shows up using the
>>>> sensors command. I have tried acpi-enforce-resources=lax with no
>>>> effect. I have tried searching the internet for an answer and I find
>>>> none. Below is the information requested in the FAQ.  I would like
>>>> to note that this is not a new problem, it has been ongoing since I
>>>> bought the motherboard in Jan 2011.
>>>>
>>>> Any help would be appreciated.
>>>>
>>>> Logan
>>>>
>>>>
>>>> *
>>>>
>>>> Motherboard vendor and model*
>>>>      JetWay JHZ03-GT-LF
>>>>
>>>> *Lm_sensors and kernel versions*
>>>>      sensors version 3.3.1 with libsensors version 3.3.1
>>>>      3.2.0-32-generic #51-Ubuntu SMP Wed Sep 26 21:33:09 UTC 2012
>>>> x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>> *The output of sensors*
>>>>      k10temp-pci-00c3
>>>>      Adapter: PCI adapter
>>>>      CPU Temp:     +26.0 C  (high = +70.0 C)
>>>>
>>>> *The dmesg or syslog output if applicable*
>>>>      kernel: [    8.795196] f71882fg: Found f71882fg chip at 0x220,
>>>> revision 32
>>>>      kernel: [    8.795228] f71882fg.544: failed to claim resource 0
>>>>      kernel: [    8.795233] f71882fg: Device addition failed
>>>>
>>> Hi,
>>>
>>> An old post suggests that you may be able to work around the problem 
>>> by booting
>>> with "pnpacpi=off", and that the problem might be due to a BIOS 
>>> problem.
>>> See 
>>> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025175.html
>>> and subsequent posts for additional details.
>>>
>>> Might be worth a try.
>>>
>>> Guenter
>>>
>>>> *The output of (as root) sensors-detect*
>>>> # sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
>>>> # System: To Be Filled By O.E.M. To Be Filled By O.E.M.
>>>> # Board: JETWAY HZ03-GT
>>>>
>>>> This program will help you determine which kernel modules you need
>>>> to load to use lm_sensors most effectively. It is generally safe
>>>> and recommended to accept the default answers to all questions,
>>>> unless you know what you're doing.
>>>>
>>>> Some south bridges, CPUs or memory controllers contain embedded 
>>>> sensors.
>>>> Do you want to scan for them? This is totally safe. (YES/no):
>>>> Module cpuid loaded successfully.
>>>> Silicon Integrated Systems SIS5595... No
>>>> VIA VT82C686 Integrated Sensors... No
>>>> VIA VT8231 Integrated Sensors... No
>>>> AMD K8 thermal sensors... No
>>>> AMD Family 10h thermal sensors... Success!
>>>>      (driver `k10temp')
>>>> AMD Family 11h thermal sensors... No
>>>> AMD Family 12h and 14h thermal sensors... No
>>>> AMD Family 15h thermal sensors... No
>>>> AMD Family 15h power sensors... No
>>>> Intel digital thermal sensor... No
>>>> Intel AMB FB-DIMM thermal sensor... No
>>>> VIA C7 thermal sensor... No
>>>> VIA Nano thermal sensor... No
>>>>
>>>> Some Super I/O chips contain embedded sensors. We have to write to
>>>> standard I/O ports to probe them. This is usually safe.
>>>> Do you want to scan for Super I/O sensors? (YES/no):
>>>> Probing for Super-I/O at 0x2e/0x2f
>>>> Trying family `National Semiconductor/ITE'... No
>>>> Trying family `SMSC'... No
>>>> Trying family `VIA/Winbond/Nuvoton/Fintek'... Yes
>>>> Found `Fintek F71882FG/F71883FG Super IO Sensors' Success!
>>>>      (address 0x225, driver `f71882fg')
>>>> Probing for Super-I/O at 0x4e/0x4f
>>>> Trying family `National Semiconductor/ITE'... No
>>>> Trying family `SMSC'... No
>>>> Trying family `VIA/Winbond/Nuvoton/Fintek'... No
>>>> Trying family `ITE'... No
>>>>
>>>> Some systems (mainly servers) implement IPMI, a set of common 
>>>> interfaces
>>>> through which system health data may be retrieved, amongst other 
>>>> things.
>>>> We first try to get the information from SMBIOS. If we don't find it
>>>> there, we have to read from arbitrary I/O ports to probe for such
>>>> interfaces. This is normally safe. Do you want to scan for IPMI
>>>> interfaces? (YES/no):
>>>> Probing for `IPMI BMC KCS' at 0xca0... No
>>>> Probing for `IPMI BMC SMIC' at 0xca8... No
>>>>
>>>> Some hardware monitoring chips are accessible through the ISA I/O 
>>>> ports.
>>>> We have to write to arbitrary I/O ports to probe them. This is usually
>>>> safe though. Yes, you do have ISA I/O ports even if you do not have 
>>>> any
>>>> ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):
>>>>
>>>> Lastly, we can probe the I2C/SMBus adapters for connected hardware
>>>> monitoring devices. This is the most risky part, and while it works
>>>> reasonably well on most systems, it has been reported to cause trouble
>>>> on some systems.
>>>> Do you want to probe the I2C/SMBus adapters now? (YES/no):
>>>> Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies
>>>> Inc SB600/SB700/SB800 SMBus
>>>> Module i2c-dev loaded successfully.
>>>>
>>>> Next adapter: Radeon i2c bit bus 0x90 (i2c-0)
>>>> Do you want to scan it? (YES/no/selectively):
>>>> Client found at address 0x50
>>>> Probing for `Analog Devices ADM1033'... No
>>>> Probing for `Analog Devices ADM1034'... No
>>>> Probing for `SPD EEPROM'... No
>>>> Probing for `EDID EEPROM'... Yes
>>>>      (confidence 8, not a hardware monitoring chip)
>>>>
>>>> Next adapter: Radeon i2c bit bus 0x91 (i2c-1)
>>>> Do you want to scan it? (YES/no/selectively):
>>>>
>>>> Next adapter: Radeon i2c bit bus 0x92 (i2c-2)
>>>> Do you want to scan it? (YES/no/selectively):
>>>>
>>>> Next adapter: Radeon i2c bit bus 0x93 (i2c-3)
>>>> Do you want to scan it? (YES/no/selectively):
>>>>
>>>> Next adapter: Radeon i2c bit bus 0x14 (i2c-4)
>>>> Do you want to scan it? (YES/no/selectively):
>>>>
>>>> Now follows a summary of the probes I have just done.
>>>> Just press ENTER to continue:
>>>>
>>>> Driver `k10temp' (autoloaded):
>>>>    * Chip `AMD Family 10h thermal sensors' (confidence: 9)
>>>>
>>>> Driver `f71882fg':
>>>>    * ISA bus, address 0x225
>>>>      Chip `Fintek F71882FG/F71883FG Super IO Sensors' (confidence: 9)
>>>>
>>>> To load everything that is needed, add this to /etc/modules:
>>>> #----cut here----
>>>> # Chip drivers
>>>> f71882fg
>>>> #----cut here----
>>>> If you have some drivers built into your kernel, the list above will
>>>> contain too many modules. Skip the appropriate ones!
>>>>
>>>> Do you want to add these lines automatically to /etc/modules? 
>>>> (yes/NO)n
>>>>
>>>> Unloading i2c-dev... OK
>>>> Unloading cpuid... OK
>>>>
>>>> *The output of lsmod*
>>>>
>>>> Module                  Size  Used by
>>>> cifs                  287317  0
>>>> ext2                   73795  1
>>>> dm_multipath           23230  0
>>>> psmouse                97443  0
>>>> edac_core              53746  0
>>>> radeon                804460  1
>>>> serio_raw              13211  0
>>>> k10temp                13166  0
>>>> edac_mce_amd           23709  0
>>>> ttm                    76949  1 radeon
>>>> sp5100_tco             13791  0
>>>> drm_kms_helper         46978  1 radeon
>>>> joydev                 17693  0
>>>> i2c_piix4              13301  0
>>>> drm                   241921  3 radeon,ttm,drm_kms_helper
>>>> i2c_algo_bit           13423  1 radeon
>>>> mac_hid                13253  0
>>>> shpchp                 37277  0
>>>> wmi                    19256  0
>>>> lp                     17799  0
>>>> parport                46562  1 lp
>>>> usbhid                 47199  1
>>>> hid                    99559  1 usbhid
>>>> r8169                  62099  0
>>>> pata_atiixp            13204  4
>>>> dm_raid45              78155  0
>>>> xor                    12894  1 dm_raid45
>>>> dm_mirror              22203  0
>>>> dm_region_hash         20918  1 dm_mirror
>>>> dm_log                 18564  3 dm_raid45,dm_mirror,dm_region_hash
>>>>
>>>> _______________________________________________
>>>> lm-sensors mailing list
>>>> lm-sensors@lm-sensors.org
>>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>>>
>> Thanks for the suggestion Guenter. I did see that post. I added 
>> pnpacpi=off to the boot options and it had no effect. I also tried 
>> pnpbios=off and pnp_reserve_io with no effect. The temperatures and 
>> voltages are displayed in bios and could also be read by several 
>> popular windows 7 programs. I am not planing on switch back to 
>> windows, but I would like to monitor the temps.
>
> Can you do a "cat /proc/ioports" and send us the output?
>
> That may help to figure out what is causing the io conflict.
>
> Regards,
>
> Hans
>
Here you go:

0000-0cf7 : PCI Bus 0000:00
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
   0170-0177 : 0000:00:14.1
     0170-0177 : pata_atiixp
   01f0-01f7 : 0000:00:14.1
     01f0-01f7 : pata_atiixp
   0225-0244 : pnp 00:09
   0376-0376 : 0000:00:14.1
     0376-0376 : pata_atiixp
   03f6-03f6 : 0000:00:14.1
     03f6-03f6 : pata_atiixp
   040b-040b : pnp 00:08
   04d0-04d1 : pnp 00:08
   04d6-04d6 : pnp 00:08
   0800-089f : pnp 00:08
     0800-0803 : ACPI PM1a_EVT_BLK
     0804-0805 : ACPI PM1a_CNT_BLK
     0808-080b : ACPI PM_TMR
     0810-0815 : ACPI CPU throttle
     0820-0827 : ACPI GPE0_BLK
   0900-090f : pnp 00:08
   0910-091f : pnp 00:08
   0ae0-0aef : pnp 00:09
   0b00-0b0f : pnp 00:08
   0b20-0b3f : pnp 00:08
   0c00-0c01 : pnp 00:08
   0c14-0c14 : pnp 00:08
   0c50-0c51 : pnp 00:08
   0c52-0c52 : pnp 00:08
   0c6c-0c6c : pnp 00:08
   0c6f-0c6f : pnp 00:08
   0cd0-0cd1 : pnp 00:08
   0cd2-0cd3 : pnp 00:08
   0cd4-0cd5 : pnp 00:08
   0cd6-0cd7 : pnp 00:08
   0cd8-0cdf : pnp 00:08
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   8000-800f : 0000:00:11.0
     8000-800f : ahci
   9000-9003 : 0000:00:11.0
     9000-9003 : ahci
   a000-a007 : 0000:00:11.0
     a000-a007 : ahci
   b000-b003 : 0000:00:11.0
     b000-b003 : ahci
   c000-c007 : 0000:00:11.0
     c000-c007 : ahci
   d000-dfff : PCI Bus 0000:01
     d000-d0ff : 0000:01:05.0
   e000-efff : PCI Bus 0000:02
     e800-e8ff : 0000:02:00.0
       e800-e8ff : r8169
   fe00-fefe : pnp 00:08
   ff00-ff0f : 0000:00:14.1
     ff00-ff0f : pata_atiixp

Thanks,

Logan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

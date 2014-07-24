From: Pietro Sammarco <kernel.panic007@gmail.com>
Date: Thu, 24 Jul 2014 22:53:50 +0000
Subject: [lm-sensors] not fan detected chromebook c720
Message-Id: <53D18E7E.4020308@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello people,

I have recently bought a brand new Acer chromebook c720 which I am using 
with ArchLinux. Ever since I wiped out ChromeOS to install ArchLinux I 
realized a smell of electronic burning coming from it. Digging around I 
have realized lm-sensors does not detect the fan.

The chipset is a Lynx Point (PCH), therefore as according the wiki it 
should work with the i2c-i801.

I am going to attach a bit of informations below.

Linux chromebookC720 3.16.0-1-mainline-chromebook #1 SMP PREEMPT Mon Jul 
14 22:04:51 NZST 2014 x86_64 GNU/Linux

[latrina@chromebookC720 ~]$ sudo i2cdetect -l
i2c-0    i2c           i2c-designware-pci                  I2C adapter
i2c-1    i2c           i2c-designware-pci                  I2C adapter
i2c-2    smbus         SMBus I801 adapter at 0400          SMBus adapter
i2c-3    i2c           i915 gmbus ssc                      I2C adapter
i2c-4    i2c           i915 gmbus vga                      I2C adapter
i2c-5    i2c           i915 gmbus panel                    I2C adapter
i2c-6    i2c           i915 gmbus dpc                      I2C adapter
i2c-7    i2c           i915 gmbus dpb                      I2C adapter
i2c-8    i2c           i915 gmbus dpd                      I2C adapter
i2c-9    i2c           DPDDC-A                             I2C adapter

[latrina@chromebookC720 ~]$ sudo lspci -nn |grep SMBus
00:1f.3 SMBus [0c05]: Intel Corporation 8 Series SMBus Controller 
[8086:9c22] (rev 04)

[latrina@chromebookC720 ~]$ sudo lsmod |grep i2c
i2c_dev                 6953  0
i2c_i801               11301  0
i2c_designware_platform     3325  0
i2c_designware_pci      3931  0
i2c_designware_core     7013  2 i2c_designware_pci,i2c_designware_platform
i2c_algo_bit            5480  1 i915
i2c_core               41648  12 
drm,i2c_designware_pci,i915,i2c_i801,i2c_dev,cyapa,i2c_designware_platform,drm_kms_helper,i2c_algo_bit,v4l2_common,chromeos_laptop,videodev

[latrina@chromebookC720 ~]$ sensors -u
coretemp-isa-0000
Adapter: ISA adapter
Core 0:
   temp1_input: 46.000
   temp1_max: 100.000
   temp1_crit: 100.000
   temp1_crit_alarm: 0.000
Core 1:
   temp2_input: 46.000
   temp2_max: 100.000
   temp2_crit: 100.000
   temp2_crit_alarm: 0.000
Core 2:
   temp3_input: 46.000
   temp3_max: 100.000
   temp3_crit: 100.000
   temp3_crit_alarm: 0.000


[latrina@chromebookC720 ~]$ sudo sensors-detect
# sensors-detect revision 6209 (2014-01-14 22:51:58 +0100)
# System: Acer Peppy [1.0]

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             Success!
     (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
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
Found unknown SMBus adapter 8086:9c22 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found.

Next adapter: i2c-designware-pci (i2c-0)
Do you want to scan it? (YES/no/selectively):
Adapter doesn't support all probing functions.
Some addresses won't be probed.

Next adapter: i2c-designware-pci (i2c-1)
Do you want to scan it? (YES/no/selectively):
Adapter doesn't support all probing functions.
Some addresses won't be probed.

Next adapter: SMBus I801 adapter at 0400 (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: i915 gmbus ssc (i2c-3)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus vga (i2c-4)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus panel (i2c-5)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpc (i2c-6)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpb (i2c-7)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpd (i2c-8)
Do you want to scan it? (yes/NO/selectively):

Next adapter: DPDDC-A (i2c-9)
Do you want to scan it? (yes/NO/selectively):


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
   * Chip `Intel digital thermal sensor' (confidence: 9)

Do you want to generate /etc/conf.d/lm_sensors? (YES/no):
Unloading cpuid... OK

-------------------------------------------------------------------------------------------

Hopefully someone will able to tell me what I am doing wrong.

Thanks,
Pietro


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

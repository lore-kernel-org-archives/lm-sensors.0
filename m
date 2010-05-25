From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, 25 May 2010 15:45:45 +0000
Subject: Re: [lm-sensors] Add sch5127 support - Testing Feedback - Part 2
Message-Id: <AANLkTilw2X6txp8ZSHHX8RBbWeRwPd8NqoaFIV9P87hQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

Does your BIOS show any voltage or RPM values that would help confirm
that the numbers are in the right ballpark?

Thanks for doing this, I appreciate it.

...juerg


On Fri, May 21, 2010 at 11:34 PM, Jeff Rickman <jrickman@myamigos.us> wrote:
> Hello Juerg,
>
> I built a Fedora Core 13 Beta system on a spare hard disk in my Acer
> Easystore H340 NAS server. Once the system was built I ran "yum update".
> The kernel version updated to 2.6.33.4-95.fc13.x86_64
>
> [root@acertest sensors]# uname -a
> Linux acertest.my.home 2.6.33.4-95.fc13.x86_64 #1 SMP Thu May 13 05:16:23
> UTC 2010 x86_64 x86_64 x86_64 GNU/Linux
>
> I pulled down the 'src.rpm" file for this kernel. Then I followed the
> steps at the Fedora URL for building custom kernels. I stopped short of
> building a custom kernel and skipped down to compiling a kernel module.
>
> [root@acertest sensors]# make -C /lib/modules/`uname -r`/build M=`pwd`
> modules
> make: Entering directory `/usr/src/kernels/2.6.33.4-95.fc13.x86_64'
>  CC [M]  /root/sensors/dme1737.o
>  Building modules, stage 2.
>  MODPOST 1 modules
>  CC      /root/sensors/dme1737.mod.o
>  LD [M]  /root/sensors/dme1737.ko
> make: Leaving directory `/usr/src/kernels/2.6.33.4-95.fc13.x86_64'
> [root@acertest sensors]# ls -al
> total 992
> drwxr-xr-x  3 root root   4096 May 22 06:21 .
> dr-xr-x---. 4 root root   4096 May 22 06:15 ..
> -rw-r--r--  1 root root  78980 May 20 23:47 dme1737.c
> -rw-r--r--  1 root root 411679 May 22 06:21 dme1737.ko
> -rw-r--r--  1 root root    213 May 22 06:21 .dme1737.ko.cmd
> -rw-r--r--  1 root root    573 May 22 06:21 dme1737.mod.c
> -rw-rw-r--  1 root root  55368 May 22 06:21 dme1737.mod.o
> -rw-r--r--  1 root root  23821 May 22 06:21 .dme1737.mod.o.cmd
> -rw-rw-r--  1 root root 358096 May 22 06:21 dme1737.o
> -rw-r--r--  1 root root  32645 May 22 06:21 .dme1737.o.cmd
> -rw-r--r--  1 root root    135 May 22 06:16 Makefile
> -rw-r--r--  1 root root     32 May 22 06:21 modules.order
> -rw-r--r--  1 root root      0 May 22 06:21 Module.symvers
> drwxr-xr-x  2 root root   4096 May 22 06:21 .tmp_versions
>
> I copied the kernel module over to the appropriate place in "/lib/modules..."
>
> Then I restarted the "lm_sensors" service. The following is from
> "/var/log/messages" (time is UTC):
>
> May 22 06:23:00 acertest kernel: dme1737 dme1737.2160: Found a SCH5127
> chip at 0x0870
> May 22 06:23:00 acertest kernel: dme1737 dme1737.2160: Optional features:
> pwm3=yes, pwm5=no, pwm6=no, fan3=yes, fan4=no, fan5=no, fan6=no.
>
> [root@acertest sensors]# service lm_sensors status
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +16.0°C  (crit = +90.0°C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +16.0°C  (crit = +90.0°C)
>
> sch5127-isa-0870
> Adapter: ISA adapter
> in0:         +1.78 V  (min =  +0.00 V, max =  +3.32 V)
> in1:         +1.19 V  (min =  +0.00 V, max =  +2.99 V)
> in2:         +3.31 V  (min =  +0.00 V, max =  +4.38 V)
> in3:         +1.13 V  (min =  +0.00 V, max =  +1.49 V)
> in4:         +1.48 V  (min =  +0.00 V, max =  +1.49 V)
> in5:         +3.33 V  (min =  +0.00 V, max =  +4.38 V)
> in6:         +0.00 V  (min =  +0.00 V, max =  +4.38 V)
> fan1:       1914 RPM  (min =    0 RPM)  ALARM
> fan2:       5079 RPM  (min =    0 RPM)
> fan3:          0 RPM  (min =    0 RPM)  ALARM
> temp1:       +43.6°C  (low  = -127.0°C, high = +127.0°C)
> temp2:      +117.0°C  (low  = -127.0°C, high = +127.0°C)
> temp3:       +37.9°C  (low  = -127.0°C, high = +127.0°C)
>
>
> I repeated "sensors-detect" to ensure the chip would be detected, etc.
>
> [root@acertest sensors]# service lm_sensors stop
> Stopping lm_sensors:                                       [  OK  ]
> [root@acertest sensors]# sensors-detect
> # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
> # System: Acer Aspire easyStore H340
> # Board: Acer WG945GCM
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): yes
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> Intel Core family thermal sensor...                         No
> Intel Atom thermal sensor...                                Success!
>    (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    No
> VIA Nano thermal sensor...                                  No
>
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): yes
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found `SMSC SCH5127 Super IO'                               Success!
>    (address 0x800, driver `dme1737')
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
>
> Some systems (mainly servers) implement IPMI, a set of common interfaces
> through which system health data may be retrieved, amongst other things.
> We first try to get the information from SMBIOS. If we don't find it
> there, we have to read from arbitrary I/O ports to probe for such
> interfaces. This is normally safe. Do you want to scan for IPMI
> interfaces? (YES/no): yes
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
>
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): yes
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
> Module i2c-dev loaded successfully.
>
> Next adapter: SMBus I801 adapter at 18a0 (i2c-0)
> Do you want to scan it? (yes/NO/selectively): yes
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>    (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `coretemp':
>  * Chip `Intel Atom thermal sensor' (confidence: 9)
>
> Driver `dme1737':
>  * ISA bus, address 0x800
>    Chip `SMSC SCH5127 Super IO' (confidence: 9)
>
> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes
> Starting lm_sensors: loading module coretemp dme1737       [  OK  ]
> Unloading i2c-dev... OK
>
> [root@acertest sensors]# service lm_sensors status
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +16.0°C  (crit = +90.0°C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +16.0°C  (crit = +90.0°C)
>
> sch5127-isa-0870
> Adapter: ISA adapter
> in0:         +1.78 V  (min =  +0.00 V, max =  +3.32 V)
> in1:         +1.19 V  (min =  +0.00 V, max =  +2.99 V)
> in2:         +3.31 V  (min =  +0.00 V, max =  +4.38 V)
> in3:         +1.13 V  (min =  +0.00 V, max =  +1.49 V)
> in4:         +1.48 V  (min =  +0.00 V, max =  +1.49 V)
> in5:         +3.33 V  (min =  +0.00 V, max =  +4.38 V)
> in6:         +3.25 V  (min =  +0.00 V, max =  +4.38 V)
> fan1:       1912 RPM  (min =    0 RPM)  ALARM
> fan2:       5070 RPM  (min =    0 RPM)
> fan3:          0 RPM  (min =    0 RPM)  ALARM
> temp1:       +43.5°C  (low  = -127.0°C, high = +127.0°C)
> temp2:      +115.6°C  (low  = -127.0°C, high = +127.0°C)
> temp3:       +38.0°C  (low  = -127.0°C, high = +127.0°C)
>
>
> Is there any more testing that I can do for you? If "yes", please let me
> know very soon. If "no", then please accept:
>
> Tested By: jrickman@myamigos.us
>
>
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

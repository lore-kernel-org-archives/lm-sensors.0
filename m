From: "didy45@libero.it" <didy45@libero.it>
Date: Tue, 16 Mar 2010 11:22:17 +0000
Subject: [lm-sensors] R: Re:  R: Re: R: Re: sensors not found INTEL i7
Message-Id: <1481904.443811268738537714.JavaMail.defaultUser@defaultHost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I write that you say but when i digit:
fabio@fabio-laptop:~/lm-sensors/prog/detect$ sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

and....

fabio@fabio-laptop:~/lm-sensors/prog/detect$ sudo ./sensors-detect 
# sensors-detect revision 5825 (2010-02-19 13:23:31 +0100)
# System: Hewlett-Packard HP Pavilion dv6 Notebook PC (laptop)
# Board: Hewlett-Packard 3659

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): YES
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): YES
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 3400/5 Series (PCH)
WARNING: All config files need .conf: /etc/modprobe.d/sound, it will be 
ignored in a future release.
WARNING: All config files need .conf: /etc/modprobe.d/alsa-base, it will be 
ignored in a future release.
Module i2c-i801 loaded successfully.

Next adapter: NVIDIA i2c adapter  (i2c-0)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter  (i2c-3)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-4)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-5)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-6)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-7)
Do you want to scan it? (YES/no/selectively): YES

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): YES
insserv: warning: script 'K20acpi-support' missing LSB tags and overrides
insserv: warning: script 'S47lm-sensors' missing LSB tags and overrides
insserv: warning: script 'lm_sensors' missing LSB tags and overrides
insserv: warning: script 'anacron' missing LSB tags and overrides
insserv: warning: script 'cron' missing LSB tags and overrides
insserv: warning: script 'apport' missing LSB tags and overrides
insserv: warning: script 'udev-finish' missing LSB tags and overrides
insserv: warning: script 'gdm' missing LSB tags and overrides
insserv: warning: script 'usplash' missing LSB tags and overrides
insserv: warning: script 'dmesg' missing LSB tags and overrides
insserv: warning: script 'module-init-tools' missing LSB tags and overrides
insserv: warning: script 'lm-sensors' missing LSB tags and overrides
insserv: warning: script 'failsafe-x' missing LSB tags and overrides
insserv: warning: script 'udevmonitor' missing LSB tags and overrides
insserv: warning: script 'avahi-daemon' missing LSB tags and overrides
insserv: warning: script 'acpid' missing LSB tags and overrides
insserv: warning: current start runlevel(s) (0 6) of script `umountnfs.sh' 
overwrites defaults (empty).
insserv: warning: script 'ufw' missing LSB tags and overrides
insserv: warning: current start runlevel(s) (0 6) of script `wpa-ifupdown' 
overwrites defaults (empty).
insserv: warning: current start runlevel(s) (0 6) of script `networking' 
overwrites defaults (empty).
insserv: warning: current start runlevel(s) (0 6) of script `umountfs' 
overwrites defaults (empty).
insserv: warning: script 'dbus' missing LSB tags and overrides
insserv: warning: script 'rsyslog' missing LSB tags and overrides
insserv: warning: script 'hal' missing LSB tags and overrides
insserv: warning: current start runlevel(s) (0 6) of script `sendsigs' 
overwrites defaults (empty).
insserv: warning: script 'procps' missing LSB tags and overrides
insserv: warning: script 'hwclock' missing LSB tags and overrides
insserv: warning: script 'udev' missing LSB tags and overrides
insserv: warning: script 'rsyslog-kmsg' missing LSB tags and overrides
insserv: warning: script 'atd' missing LSB tags and overrides
insserv: warning: current start runlevel(s) (0 6) of script `umountroot' 
overwrites defaults (empty).
insserv: warning: script 'hwclock-save' missing LSB tags and overrides
insserv: warning: script 'udevtrigger' missing LSB tags and overrides
insserv: warning: current start runlevel(s) (6) of script `reboot' overwrites 
defaults (empty).
insserv: warning: current start runlevel(s) (0) of script `halt' overwrites 
defaults (empty).
insserv: warning: script 'acpi-support' missing LSB tags and overrides
insserv: There is a loop between service rsyslog and pulseaudio if stopped
insserv:  loop involving service pulseaudio at depth 3
insserv:  loop involving service rsyslog at depth 2
insserv:  loop involving service udev at depth 1
insserv: There is a loop between service pulseaudio and rsyslog if stopped
insserv: exiting without changing boot order!
Unloading i2c-i801... OK

What do i do??????

>----Messaggio originale----
>Da: anothersname@googlemail.com
>Data: 15/03/2010 18.37
>A: "didy45@libero.it"<didy45@libero.it>
>Ogg: Re: [lm-sensors] R: Re: R: Re: sensors not found INTEL i7
>
>On 15 March 2010 14:00, didy45@libero.it <didy45@libero.it> wrote:
>> My ubuntu is:
>> Ubuntu 9.10 - Karmic Koala
>>
>> My kernel version is:
>> 2.6.31-20-generic
>>
>>
>>>----Messaggio originale----
>>>Da: anothersname@googlemail.com
>>>Data: 15/03/2010 12.26
>>>A: "didy45@libero.it"<didy45@libero.it>
>>>Ogg: Re: [lm-sensors] R: Re: sensors not found INTEL i7
>>>
>>>On 15 March 2010 10:29, didy45@libero.it <didy45@libero.it> wrote:
>>>> This is the answer to sensor -s and sensors-detect:
>>>>
>>>> fabio@fabio-laptop:~$ sensors -s
>>>> No sensors found!
>>>> Make sure you loaded all the kernel drivers you need.
>>>> Try sensors-detect to find out which these are.
>>>>
>>>> fabio@fabio-laptop:~$ sudo sensors-detect
>>>> [sudo] password for fabio:
>>>> # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
>>>> # System: Hewlett-Packard HP Pavilion dv6 Notebook PC (laptop)
>>>> # Board: Hewlett-Packard 3659
>>>>
>>>> This program will help you determine which kernel modules you need
>>>> to load to use lm_sensors most effectively. It is generally safe
>>>> and recommended to accept the default answers to all questions,
>>>> unless you know what you're doing.
>>>>
>>>> Some south bridges, CPUs or memory controllers contain embedded sensors.
>>>> Do you want to scan for them? This is totally safe. (YES/no): YES
>>>> Silicon Integrated Systems SIS5595...                       No
>>>> VIA VT82C686 Integrated Sensors...                          No
>>>> VIA VT8231 Integrated Sensors...                            No
>>>> AMD K8 thermal sensors...                                   No
>>>> AMD Family 10h thermal sensors...                           No
>>>> AMD Family 11h thermal sensors...                           No
>>>> Intel Core family thermal sensor...                         No
>>>> Intel Atom thermal sensor...                                No
>>>> Intel AMB FB-DIMM thermal sensor...                         No
>>>> VIA C7 thermal sensor...                                    No
>>>> VIA Nano thermal sensor...                                  No
>>>>
>>>> Some Super I/O chips contain embedded sensors. We have to write to
>>>> standard I/O ports to probe them. This is usually safe.
>>>> Do you want to scan for Super I/O sensors? (YES/no): YES
>>>> Probing for Super-I/O at 0x2e/0x2f
>>>> Trying family `National Semiconductor'...                   No
>>>> Trying family `SMSC'...                                     No
>>>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
>>>> Trying family `ITE'...                                      No
>>>> Probing for Super-I/O at 0x4e/0x4f
>>>> Trying family `National Semiconductor'...                   No
>>>> Trying family `SMSC'...                                     No
>>>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
>>>> Trying family `ITE'...                                      No
>>>>
>>>> Some hardware monitoring chips are accessible through the ISA I/O ports.
>>>> We have to write to arbitrary I/O ports to probe them. This is usually
>>>> safe though. Yes, you do have ISA I/O ports even if you do not have any
>>>> ISA slots! Do you want to scan the ISA I/O ports? (YES/no): YES
>>>> Probing for `National Semiconductor LM78' at 0x290...       No
>>>> Probing for `National Semiconductor LM79' at 0x290...       No
>>>> Probing for `Winbond W83781D' at 0x290...                   No
>>>> Probing for `Winbond W83782D' at 0x290...                   No
>>>>
>>>> Lastly, we can probe the I2C/SMBus adapters for connected hardware
>>>> monitoring devices. This is the most risky part, and while it works
>>>> reasonably well on most systems, it has been reported to cause trouble
>>>> on some systems.
>>>> Do you want to probe the I2C/SMBus adapters now? (YES/no): YES
>>>> Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
>>>> Sorry, no supported PCI bus adapters found.
>>>> WARNING: All config files need .conf: /etc/modprobe.d/sound, it will be
>>>> ignored in a future release.
>>>> WARNING: All config files need .conf: /etc/modprobe.d/alsa-base, it will 
be
>>>> ignored in a future release.
>>>> Module i2c-dev loaded successfully.
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-0)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-1)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-2)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>> Client found at address 0x50
>>>> Probing for `Analog Devices ADM1033'...                     No
>>>> Probing for `Analog Devices ADM1034'...                     No
>>>> Probing for `SPD EEPROM'...                                 No
>>>> Probing for `EDID EEPROM'...                                Yes
>>>>    (confidence 8, not a hardware monitoring chip)
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-3)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-4)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-5)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-6)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>>
>>>> Next adapter: NVIDIA i2c adapter  (i2c-7)
>>>> Do you want to scan it? (YES/no/selectively): YES
>>>>
>>>> Sorry, no sensors were detected.
>>>> This is relatively common on laptops, where thermal management is
>>>> handled by ACPI rather than the OS.
>>>>
>>>> What do i do?
>>>> Help me, please!
>>>>
>>>>
>>>>>----Messaggio originale----
>>>>>Da: anothersname@googlemail.com
>>>>>Data: 15/03/2010 3.36
>>>>>A: "didy45@libero.it"<didy45@libero.it>
>>>>>Ogg: Re: [lm-sensors] sensors not found INTEL i7
>>>>>
>>>>>On 14 March 2010 16:09, didy45@libero.it <didy45@libero.it> wrote:
>>>>>> Do not function lm-sensors on hp pavillon dv6 2153el
>>>>>> with cpu intel i7.
>>>>>> After i install lmsensors and i start the sensors.
>>>>>> the answer is
>>>>>> no sensors found!
>>>>>> What do i do?
>>>>>> Can you help me?
>>>>>> thanks!
>>>>>>
>>>>>> _______________________________________________
>>>>>> lm-sensors mailing list
>>>>>> lm-sensors@lm-sensors.org
>>>>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>>>>>
>>>>>
>>>>>Did you run sensors-detect?
>>>>>
>>>>>What did it report?
>>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> lm-sensors mailing list
>>>> lm-sensors@lm-sensors.org
>>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>>>
>>>
>>>Which version of the Kernel are you using?
>>>
>>>Which flavour of Linux?
>>>
>>
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>OK
>
>I'm not familiar with Ubuntu's file layout.....
>
>You should have a file lm_sensors probably in /etc/sysconfig
>
>In that file add the following 2 lines
>
>---------------------------
>
>HWMON_MODULES="coretemp"
>
>MODULE_0=coretemp
>
>-----------------------------
>
>Once you've done that restart your lm_sensors service and let me know
>what happens
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

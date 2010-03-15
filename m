From: "didy45@libero.it" <didy45@libero.it>
Date: Mon, 15 Mar 2010 10:29:32 +0000
Subject: [lm-sensors] R: Re:  sensors not found INTEL i7
Message-Id: <7482707.328021268648972405.JavaMail.defaultUser@defaultHost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is the answer to sensor -s and sensors-detect:

fabio@fabio-laptop:~$ sensors -s
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

fabio@fabio-laptop:~$ sudo sensors-detect
[sudo] password for fabio: 
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
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
Intel Core family thermal sensor...                         No
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
Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found.
WARNING: All config files need .conf: /etc/modprobe.d/sound, it will be 
ignored in a future release.
WARNING: All config files need .conf: /etc/modprobe.d/alsa-base, it will be 
ignored in a future release.
Module i2c-dev loaded successfully.

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

Sorry, no sensors were detected.
This is relatively common on laptops, where thermal management is
handled by ACPI rather than the OS.
 
What do i do?
Help me, please!


>----Messaggio originale----
>Da: anothersname@googlemail.com
>Data: 15/03/2010 3.36
>A: "didy45@libero.it"<didy45@libero.it>
>Ogg: Re: [lm-sensors] sensors not found INTEL i7
>
>On 14 March 2010 16:09, didy45@libero.it <didy45@libero.it> wrote:
>> Do not function lm-sensors on hp pavillon dv6 2153el
>> with cpu intel i7.
>> After i install lmsensors and i start the sensors.
>> the answer is
>> no sensors found!
>> What do i do?
>> Can you help me?
>> thanks!
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>
>Did you run sensors-detect?
>
>What did it report?
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

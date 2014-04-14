From: Bernd Bausch <berndbausch@gmail.com>
Date: Mon, 14 Apr 2014 03:17:41 +0000
Subject: [lm-sensors] Asus M5A88-M motherboard, "no pwm-capable sensor modules"
Message-Id: <534B5355.5090102@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would like to run my PC as silently under Linux as I can under
Windows. Unfortunately I am pretty ignorant about hardware monitoring
and control.

Asus provides a fan control utility that allows me to throttle the CPU
fan (not the case fan unfortunately), but I have been unable to do the
same using lm_sensors. pwmconfig reports that there are no pwm-capable
sensors.

So I wonder, does pwmconfig tell the truth? If yes, how can the CPU
fan be controlled (it obviously can)? What are my options apart from
leaving things as they are?

This is on Centos 6.5 with an unchanged kernel (2.6.32-431, 64 bit). I
use the standard lm_sensors packages but the newest version of
sensors-detect. I also tried the newest version of pwmconfig.
sensors-detect and pwmconfig output below.

Thanks for listening, and more thanks for replying :)

Bernd

--------------------------------------------

sudo /tmp/sensors-detect
Stopping lm_sensors:                                       [  OK  ]
# sensors-detect revision 6243 (2014-03-20 11:23:35 +0100)
# Board: ASUSTeK Computer INC. M5A88-M

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
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           Success!
    (driver `k10temp')
AMD Family 16h thermal sensors...                           No
AMD Family 15h power sensors...                             Success!
    (driver `fam15h_power')
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             No
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
Trying family `ITE'...                                      Yes
Found `ITE IT8721F/IT8758E Super IO Sensors'                Success!
    (address 0x290, driver `it87')
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
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600/SB700/SB800 SMBus
Module i2c-dev loaded successfully.


Next adapter: Radeon i2c bit bus 0x90 (i2c-0)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x91 (i2c-1)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x92 (i2c-2)
Do you want to scan it? (yes/NO/selectively): yes
yes

Next adapter: Radeon i2c bit bus 0x93 (i2c-3)
Do you want to scan it? (yes/NO/selectively):
Next adapter: Radeon i2c bit bus 0x14 (i2c-4)
Do you want to scan it? (yes/NO/selectively): yes


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87':
  * ISA bus, address 0x290
    Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)

Driver `fam15h_power' (autoloaded):
  * Chip `AMD Family 15h power sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Starting lm_sensors: loading module it87                   [  OK  ]
Unloading i2c-dev... OK

[bbausch@athlon64 LNXSYSTM:00]$ sudo pwmconfig
# pwmconfig revision 5630 (2009-01-29)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
[bbausch@athlon64 LNXSYSTM:00]$
/*
 * downloading and compiling lm_sensors 3.3.5
 */
$ sudo prog/pwm/pwmconfig
[sudo] password for bbausch:
# pwmconfig revision 6166 (2013-05-01)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

prog/pwm/pwmconfig: There are no pwm-capable sensor modules installed




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

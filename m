From: Herr Oswald <herr_oswald@gmx.de>
Date: Sat, 16 Nov 2019 16:49:52 +0000
Subject: Fujitsu-Siemens w380
Message-Id: <65968039de35e0807a32188c4f8791a2964ea5e7.camel@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello,

I hope these questions are not way too stupid, but I've now been
struggling for months, even the caretaker for linux at Siemens could
not help.
I'm at a Fujitsu-Siemens workstation Celsius w380 with ubuntu 18.04.


Status is:

sensors-detect finds:

#----cut here----
# Chip drivers
coretemp
jc42
sch5627
#----cut here----

Those are in /etc/modules. sensors can read the values:

$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +35.0°C  (high = +83.0°C, crit = +99.0°C)
Core 1:       +32.0°C  (high = +83.0°C, crit = +99.0°C)
Core 2:       +35.0°C  (high = +83.0°C, crit = +99.0°C)
Core 3:       +33.0°C  (high = +83.0°C, crit = +99.0°C)

sch5627-isa-0580
Adapter: ISA adapter
VCC:          +3.36 V
VTT:          +1.12 V
VBAT:         +3.05 V
VTR:          +3.33 V
in4:          +1.13 V
fan1:        1627 RPM  (min =    0 RPM)
fan2:           FAULT  (min =    0 RPM)
fan3:           FAULT  (min =    0 RPM)
fan4:           FAULT  (min =    0 RPM)
temp1:        +35.0°C  (high = +36.0°C, crit = +191.0°C)
temp2:        +33.6°C  (high = +36.0°C, crit = +191.0°C)
temp3:        +28.4°C  (high = +36.0°C, crit = +191.0°C)
temp4:          FAULT  (high = +36.0°C, crit = +191.0°C)
temp5:          FAULT  (high = +36.0°C, crit = +191.0°C)
temp6:        +26.6°C  (high = +36.0°C, crit = +191.0°C)
temp7:          FAULT  (high = +36.0°C, crit = +191.0°C)
temp8:          FAULT  (high = +36.0°C, crit = +191.0°C)


Fans2-4 not functional is correct - I disconnected them because they
are too noisy and not really necessary at my normal workload.


Now with
$ sudo pwmconfig

I got the result:
# pwmconfig revision 6243 (2014-03-20)
/usr/sbin/pwmconfig: There are no
pwm-capable sensor modules installed


What can I do, hints are highly appreciated.

Cheers,
Wolf



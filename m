From: Alexey Orishko <alexey.orishko@gmail.com>
Date: Tue, 06 Oct 2015 10:43:00 +0000
Subject: [lm-sensors] nct5573D missing fans
Message-Id: <CAL_Kpj0HDwHZ1bwQZXYWwV0-Acnoqjfe8hzZiGSzUkMBzcRD2A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys,

Asrock mobo C2550D4I has NCT5573D chip (at least they say in the mobo
manual) and here is sensors-detect output:
Found `Nuvoton NCT5577D/NCT6776F Super IO Sensors'          Success!
    (address 0x290, driver `nct6775')

Motherboard has 6 fan connectors cpu1&2, front 1&2 and rear 1&2, but if I
load nct6775 driver on ubuntu 14.04.3-64bit, I do see only fan1 and fan2
(and pwm1 and pwm2) and I have a trouble to control them (manual mode,
4-wire fan). If I use sensor monitoring in build-in BMC web interface, I
could at least see all 6 fans...

Is there anything that could be done in the config file or driver changes
are required to support this motherboard?

Regards,
Alexey

PS. do you have any info why lm-sensors.org is down?
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

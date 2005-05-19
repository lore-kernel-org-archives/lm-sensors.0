From: baileych@mail.med.upenn.edu (Charles Bailey)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Ticket 1288
Message-Id: <2147483647.1063731359@abrmsn288.med.upenn.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <2147483647.1056216687@abrmsn288.med.upenn.edu>
In-Reply-To: <2147483647.1056216687@abrmsn288.med.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks.  Changing the settings seems to help:
>
> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> [snip]
> fan1:        0 RPM  (min = 3000 RPM, div = 2)
> fan2:     4530 RPM  (min = 3000 RPM, div = 2)
> fan3:     5443 RPM  (min = 3000 RPM, div = 2)
> temp1:      +127C  (limit =  +60C)                       sensor > PII/Celeron diode   ALARM temp2:     +36.5C  (limit =  +60C, hysteresis > +50C) sensor = 3904 transistor temp3:     +42.0C  (limit =  +60C,
> hysteresis =  +50C) sensor = 3904 transistor


A bit of final followup:  Setting the temperature sensor types to
  temp1 = thermistor (3435 in sensors.conf)
  temp2 = 3904 transistor (2 in sensors.conf)
  temp3 = 3904 transistor (2 in sensors.conf)
yields temperature readings which appear to track, respectively, the BIOS's 
values for "System Temp", "CPU1 temp", and "CPU2 temp".  (I haven't seen 
"System Temp" vary from 25, so I don't know whether it's real or a dud.

The values for fan1, fan2, and fan3 also seem to track the BIOS's values 
for "SysFan speed" (always 0), "CPU1 fan speed", and "CPU2 fan speed".  I 
haven't looked carefully at the voltage sensors.

Once again, this is for a MicroStar K7D Master motherboard with dual 
Athlons and the BIOS on the board.

I hope this helps.

--
Regards,
Charles Bailey  < baileych _at_ mail _dot_ med _dot_ upenn _dot_ edu >
Fellow, Pediatric Hematology/Oncology
Children's Hospital of Philadelphia/University of Pennsylvania

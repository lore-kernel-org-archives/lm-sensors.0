From: baileych@mail.med.upenn.edu (Charles Bailey)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Ticket 1288
Message-Id: <4220000.1060894732@abrmsn274.med.upenn.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <2147483647.1056216687@abrmsn288.med.upenn.edu>
In-Reply-To: <2147483647.1056216687@abrmsn288.med.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--On Thursday, August 14, 2003 09:42:15 PM +0200 Jean Delvare 
<khali@linux-fr.org> wrote:

>> (snip)
>> temp1:       +25C  (limit =  +60C)                       sensor >> thermistor temp2:     +58.5C  (limit =  +60C, hysteresis =  +50C)
>> sensor = PII/Celeron diode   ALARM
>> temp3:     +60.0C  (limit =  +60C, hysteresis =  +50C) sensor >> PII/Celeron diode   ALARM
>
> I can see in the configuration file that the sensor types can be
> changed. Maybe the default configuration doesn't match your hardware.
> Did you try changing these values in the config file (section
> w83627hf-*, uncomment the lines), maybe it would give interesting
> results?

Thanks.  Changing the settings seems to help:

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
[snip]
fan1:        0 RPM  (min = 3000 RPM, div = 2)
fan2:     4530 RPM  (min = 3000 RPM, div = 2)
fan3:     5443 RPM  (min = 3000 RPM, div = 2)
temp1:      +127C  (limit =  +60C)                       sensor = 
PII/Celeron diode   ALARM
temp2:     +36.5C  (limit =  +60C, hysteresis =  +50C) sensor = 3904 
transistor
temp3:     +42.0C  (limit =  +60C, hysteresis =  +50C) sensor = 3904 
transistor

temp2 and temp3 look like they're in the range of the values the BIOS 
reported.  (I can't shut the machine down again until tomorrow to check the 
BIOS directly, but I'll let you know if there's a difference.) 
Interestingly, when sensor2 and sensor3 are set, sensor1 reports the high 
temperature above (+127) regardless of its setting.



--
Regards,
Charles Bailey  < baileych _at_ mail _dot_ med _dot_ upenn _dot_ edu >
Fellow, Pediatric Hematology/Oncology
Children's Hospital of Philadelphia/University of Pennsylvania

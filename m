From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 01 May 2014 10:07:44 +0000
Subject: [lm-sensors] New field in MSR_TEMPERATURE_TARGET
Message-Id: <20140501120744.1cddd118@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter and Ruik,

While checking the latest version of the Intel 64 and IA-32
Architectures Software Developer's Manual [1] in order to fix the recent
regression in the coretemp driver (and the same bug in the turbotstat
tool), I noticed that the most recent Intel processors (Silvermont
Microarchitecture) have a new field in MSR_TEMPERATURE_TARGET:

Bits 29:24
Target Offset (R/W)
Specifies an offset in degrees C to adjust the throttling and
PROCHOT# activation temperature from the default target
specified in TEMPERATURE_TARGET (bits 23:16).

As I understand it, it means two things:

1* We may be returning wrong tempN_crit values for these processors as
the coretemp driver currently does not read this field. Note that it
isn't clear to me if the field holds a signed or unsigned value. If
unsigned, it would mean that one can only set TjMax higher than it's
default value.

2* On these CPUs, we could make tempN_crit writable by the user. I
don't know if it is a good idea, what do you think about it? It could
be argued that this value should be set at boot time by the firmware,
I'm not sure.

If we want to do it, we will need a way to identify Silvermont CPUs so
that we don't make the attributes writable when the Target Offset field
does not exist. Does anyone know how we can identify these CPUs?

[1] http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-system-programming-manual-325384.pdf

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 12:28:56 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m
Message-Id: <20060118132856.6033fef7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
In-Reply-To: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander,

> I have kernel 2.6.14 and have installed lm_sensors 2.9.2
> 
> sensors-detect find the chip (see the output below), and after all the
> suggested steps,
> sensors output is apparently nothing for fans and temps (see below).
> 
> I will be happy to quickly provide any additional information if any of
> developers decide to resolve this problem.

Please provide the output of:
  isadump -k 0x87,0x87 0x2e 0x2f 0xb

I want to check the value of registers 0x22, which may be used to shut
down the hardware monitoring part of the device, and 0x30, which may
disable that part. I guess that you wouldn't even be able to dump the
device contents if it was shut down or disabled, but it doesn't hurt to
make sure.

> sensors output:
> 
> w83627ehf-isa-0290
> Adapter: ISA adapter
> fan1:        0 RPM  (min = 10546 RPM, div = 128)
> fan2:        0 RPM  (min =    0 RPM, div = 128)
> fan3:        0 RPM  (min =    0 RPM, div = 128)
> fan4:        0 RPM  (min = 10546 RPM, div = 128)
> temp1:       -48?C  (high =    +0?C, hyst =   +64?C)
> temp2:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)
> temp3:     -48.0?C  (high = +80.0?C, hyst = +75.0?C)

For fans, try setting the limits to something reasonable like 1000 RPM.
It might help.

For temperatures, try:
  isaset 0x295 0x296 0x4e 0x00
  isaset 0x295 0x296 0x59 0x00
This will change the diode measurement type from Pentium II to 2N3904.
Maybe you'll have different readings after that. If it doesn't help,
try:
  isaset 0x295 0x296 0x5d 0x07
This will change the measurement mode from diode to thermistor. This
should change the reported values, although I can't promise the new
values will make more sense than the old ones.

Ideally, the driver should at least report the currently selected
thermal sensor type, and may even let the user change it to workaround
broken BIOSes. The w83627ehf driver is still in a preliminary stage
though.

We have a patch floating around which adds voltage input support to the
driver. Do you want to give it a try? Maybe you'll be more lucky with
voltages than with fans and temperatures. The dump you provided
elsewhere in this thread shows that at least some voltage values make
sense.

-- 
Jean Delvare


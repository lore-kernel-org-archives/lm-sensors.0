From: Leon.Moonen@computer.org (Leon Moonen)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <42387C6B.5030401@computer.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050226191142.6288b2ef.khali@linux-fr.org>
In-Reply-To: <20050226191142.6288b2ef.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Sat, Feb 26, 2005 at 07:11:42PM +0100, Jean Delvare wrote:
> I have been working on a w83627ehf hardware monitoring driver. The
> W83627EHF is a Super-I/O chip made by Winbond. Like other chips of the
> family (W83627HF, W83697HF, W83627THF...), it integrates hardware
> monitoring functions. Of these, my preliminary driver only handles
> temperature and fan inputs at the moment.

I have an Asus P5P800 motherboard with the W83627EHF and would like to
monitor the CPU temperature. I have used your patchfile
(http://jdelvare.net1.nerim.net/sensors/linux-2.6.11-rc5-i2c-w83627ehf-beta1.diff)
to patch my linux-2.6.10 sources (no obvious problems there) and
recompiled and installed (I'm running Fedora Core 3).

I had hoped that this would give me CPU temperature readings but I
didn't get any values when running the sensors command (neither as root
nor as normal user, and after running sensors -s):
----------------
# sensors
w83627ehf-isa-0290
Adapter: ISA adapter

#
----------------

Since then I've read your discussion with David Hoffman and repeated
some of the experiments:

Initially I could not get the version of sensors_detect at
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect
to detect the W83627EHF at the ISA bus. Here's some of the output:
-----------
Do you want to scan the ISA bus? (YES/no):
..
Probing for `Winbond W83627EHF'
   Trying address 0x0290... Failed!
..
Do you want to scan for Super I/O sensors? (YES/no):
..
Probing for `Winbond W83627EHF Super IO Sensors'
   Success... found at address 0x0290

Do you want to scan for secondary Super I/O sensors? (YES/no):
..
Probing for `Winbond W83627EHF Super IO Sensors'
   Failed! (skipping family)
-----------

After running 'isaset 0x295 0x296 0x4e 0' the W83627EHF is found as an
ISA chip as well:
-----------
Do you want to scan the ISA bus? (YES/no):
..
Probing for `Winbond W83627EHF'
   Trying address 0x0290... Success!
     (confidence 8, driver `to-be-written')
..
Do you want to scan for Super I/O sensors? (YES/no):
..
Probing for `Winbond W83627EHF Super IO Sensors'
   Success... found at address 0x0290

Do you want to scan for secondary Super I/O sensors? (YES/no):
..
Probing for `Winbond W83627EHF Super IO Sensors'
   Failed! (skipping family)
-----------

However, both before and after the isaset command I cannot get any
values as output from running sensors.

Here is the i2c part of the output from lsmod
------------------------
Module                  Size  Used by
..
w83627ehf              18200  0
i2c_sensor              7680  1 w83627ehf
i2c_isa                 6400  0
i2c_dev                13568  0
i2c_core               24960  4 w83627ehf,i2c_sensor,i2c_isa,i2c_dev
..
------------------------

I've updated modules.conf (actually modprobe.conf on FC3) and lm_sensors
as indicated by sensors_detect. Dmesg shows that lm_sensors is loaded
without problems (it gave a no sensors found warning before I applied
your patches).

I have no idea how to debug this further or how to get sensor values but 
I'm willing to put some time in this as a tester.  Were my expectations 
wrong and can't I use your preliminary driver to get temperature 
readings? Should I maybe add something to sensors.conf?  Are there 
changes in the 2.6.11-rc5 kernel w.r.t. 2.6.10 that I might need?


cheers,
-- Leon

------------------------------------------------------------------------
Leon Moonen   mailto:Leon.Moonen@computer.org   http://www.cwi.nl/~leon/
------------------------------------------------------------------------
Delft University of Technology  | CWI
Software Evolution Research Lab | Department of Software Engineering
Mekelweg 4, 2628 CD, Delft, NL  | Kruislaan 413, 1098 SJ, Amsterdam, NL
------------------------------------------------------------------------


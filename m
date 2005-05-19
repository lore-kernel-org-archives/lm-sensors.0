From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: LM87 support in LK2.6
Message-Id: <20040707161813.55221449.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <406C6981.6060306@mascorp.com>
In-Reply-To: <406C6981.6060306@mascorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> Right, I now have the code compiled and installed on a Debian unstable
> 2.6.7 kernel system, with the latest lm87 code with the scx200_acb
> patch and all, and it loads and sensors finds it.
> 
> The output I get ( and I have no way to verify whether those numbers
> that are there are correct is:-
> 
> <<<<<<<<<<<<<<<<<<<
> david@microtik:-$sensors
> eeprom-i2c-1-50
> Adapter: SCX200 ACB1
> Memory type:		SDR SDRAM DIMM
> Memory size(MB):	64
> 
> lm87-i2c-1-2e
> Adapter: SCX200 ACB1
> Error: Can't get IN1 data!
> Error: Can't get IN2 data!
> Error: Can't get IN3 data!
> fan1:	0 RPM (min = -1 RPM, div = 2)		ALARM
> fan2:	0 RPM (min = -1 RPM, div = 2)		ALARM
> temp1:	+37C  (low = 	+0 C, high = 	+0)	ALARM
> Error: Can't get TEMP2 data
> <<<<<<<<<<<<<<<<<<<<
> 
> Now looking at this the fan speeds of 0 are right, this system has
> no fans.  Why an alarm is thought to be necessary when the min = -1
> and the value is 0 I am uncertain.

Alarms are flags set by the chip, the driver simply reports them. Maybe
the chip simply doesn't like limit registers being set to 0 (translated
to -1 by the driver) and would prefer 255 (0 or the lowest possible
number for the driver). Try setting these limits to 0 (either using
/etc/sensors.conf + "sensors -s") or by writing directly to the sysfs
files and see if it helps.

> For temp1 the value is plausable, but the low and high values are
> obviously wrong (at least the high one).

You can try setting the limits yourself for these as well.

> The documentation is wonderfully vague as to what sensors there
> are, and there is no BIOS function to read and display them as far
> as I can see.  However it does say:-
> 
> Temperative sensors: CPU area, PCI area, LM87 health monitoring area
> Voltage Monitor: CPU core, +3.3V +5V +12V voltage monitoring
> 
> This would suggest that there should be four voltages and three 
> temperatures.  We seem to have just one temperature.
> 
> Looking at the data in /sys/bus/i2c/device/1-002e I get a slightly
> different picture.
> 
> Ignoring the ones I am not expecting:-
>                        input	min		max
> in0			0		0		0
> in1			1800	0		0
> in2			3300	0		0
> in3			5000	0		0
> in4			12125	0		0
> temp1		37000	0		0
> temp2		0		0		0
> temp3		31000	0		0
> 
> For completeness the vrm value is 82, vid is 0, analog_out is 255,
> detach_state is 0 and alarms is 4606.
> 
> Now this looks as though in0 is unused, in1 is the core, in2 is +3,
> int3 is +5 and in4 is +12, temp1 is the CPU temperature and temp3
> is the PCI area temperature.  Why sensors could not read IN1, IN2
> and IN3 confuses me.

Because (still) libsensors needs to know about the chips and the lm87
driver was only ported to Linux 2.6 recently. Feature names have changed
since 2.4 in the holy name of standardization. Libsensors try to figure
our the new names but when the old ones were chosed in a non standard
way, it fails.

I just commited a change to libsensors to solve the problem. You should
be able to read all values now.

Note that in0, in5 and temp3 share pins, according to the LM87 docs. In
your case, the chip should be configured to use temp3 (and neither in0
nor in5). I believe that the BIOS should have configured it properly and
the lm87 driver should not have to change that (although I guess that
the 2.4 driver was most likely setting an arbitrary mode).

Watch for ignore lines in sensors.conf. If you can't seem to see any
given value, it may just be because of an ignore statement in
/etc/sensors.conf.

> Where do the min and max values come from, if from the chip then
> there is something amis, if from a control file obviously I do not
> have that file installed (correctly).

Limits are programmable regiters inside the chip. Usually they default
to sensible values, but that's not the case here. Just tweak the limits
in /etc/sensors.conf and apply with "sensors -s".

> Any thoughts?

Well I guess it should be better now, though most probably not perfect.
Libsensors may need further tweaking. And the new lm87 driver itself may
need some tweaking.

Let us know how it goes with the new libsensors and you having
additional knowledge about alarms and limits.

-- 
Jean Delvare
http://khali.linux-fr.org/

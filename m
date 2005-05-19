From: danny.backx@skynet.be (Danny Backx)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Works now (Re: my user-space work ? (3d attempt))
Message-Id: <1066812223.1056.79.camel@dell.roesel.skynet.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065896525.1059.14.camel@dell.roesel.skynet.be>
In-Reply-To: <1065896525.1059.14.camel@dell.roesel.skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2003-10-21 at 03:12, Mark Studebaker wrote:
> so you have 'sensors' working on 2.6?

Yes

> I'm having trouble understanding what you did from looking at the diff.
> Could you explain if this is a general fix compatible for both 2.4 and
> 2.6 or is there much more to do...

I saw several things that needed to be ported, I'll explain
what I did and did not do.

The background is that I really don't know much about your code,
and I didn't take much time to learn about it (wrong, I know:-))
but I got much of the 2.4->2.6 port done. The parts not done,
or that need  review, are the parts where knowledge of the
sensors code is needed.

1. #define SENSORS_SYSFS
  I believe I've hidden my changes in #ifdefs based on that
  symbol.
2. /proc vs. sysfs
  I built code to look for the sysfs mount point (by reading
  /proc/mounts) and locate the right directory to read
  sensor data. This is all in sensors_read_proc_chips().

  On my system it locates /sys/bus/i2c/devices, sees that
  there's an entry 0-0290 in there (a symlink to a directory),
  in which it can find a file called "name" that contains
  the string "w83627hf" which is obviously my sensor chip.
  A small hack in the code is then to add "-*" to that
  string so it survives the sensors_parse_chip_name()
  function. You'll want to review this.

  Still in sensors_read_proc_chips(), I've stored the
  complete directory name that I found (e.g.
  /sys/bus/i2c/devices/0-0290) in the entry.name.busname
  field so I don't have to dig up all this info later on.
  This is visible in the first line of the output of
  sensors which displays that field. (See the sample
  output below.) 

3. I've duplicated some of the macros such as
  add_sys_chips() (was add_proc_chips). Not sure
  if this is useful. Also some duplicated structures
  like sensors_sys_chips_entry (sensors_proc_chips_entry).
  Again, please review.

4. In lib/access.c all the compares between sensor chip
  names were case sensitive. That made it fail for me.
  Changed all the calls of strcmp to strcasecmp for
  this reason.

5. Didn't know what to do with bus types. E.g. the
  function sensors_chip_name_has_wildcards() seemed to
  work on that so I disabled that check. Needs review.

  Similar for sensors_get_adapter_name() and
  sensors_get_algorithm_name() where I didn't understand
  what this should do so I basically disabled this
  by something like

	  const char *sensors_get_adapter_name(int bus_nr)
	  {
	+ #ifdef        SENSORS_SYSFS
	+       return "Dummy adapter";
	+ #else
	    int i;
	    if (bus_nr = SENSORS_CHIP_NAME_BUS_ISA)

6. The file names in /sys/bus/i2c/devices/0-0290 were
  different than the ones described in lib/chips.c so
  I changed some of them *for my adapter*. The files
  I see are called in_max0 etc where the code expected
  in0_max. I assume this is incompatibility between the
  code in kernel 2.6 and previous versions.

That's all, I think.

There are obvious problems with what I did in that the
temperature sensors give strange results - see below.

But as I said I really don't understand all this code so
I didn't feel like going after that.

Is this making sense ? Are there other things I can do ?

	Danny


> thanks
> mds


Sample output :
w83627hf-i2c-/sys/bus/i2c/devices/0-0290
Adapter: Dummy adapter
Algorithm: Dummy algorithm
in_input0:+14.40 V  (min = +12.16 V, max = +14.88 V)              
in_input1:+24.48 V  (min = +12.16 V, max = +14.88 V)              
in_input2:+33.28 V  (min = +29.76 V, max = +36.32 V)              
in_input3:+29.92 V  (min = +26.88 V, max = +32.64 V)              
in_input4:+31.52 V  (min = +28.48 V, max = +34.56 V)              
in_input5:+12.16 V  (min =  +3.36 V, max =  +7.84 V)              
in_input6:+15.04 V  (min =  +7.04 V, max = +10.24 V)              
in_input7:+32.80 V  (min = +26.88 V, max = +32.64 V)       ALARM  
in_input8:+32.96 V  (min = +27.04 V, max = +32.96 V)              
fan_input1:
          1622 RPM  (min =  187 RPM, div = 32)                     
fan_input2:
          2481 RPM  (min =  187 RPM, div = 32)                     
fan_input3:
             0 RPM  (min =  375 RPM, div = 16)                     
temp_input1:
            +370?C  (limit =   +0?C, hysteresis =   +0?C) sensor thermistor           
temp_input2:
          +450.0?C  (limit =   +0?C, hysteresis =   +0?C) sensor PII/Celeron diode           
temp_input3:
          +2080.0?C  (limit =   +0?C, hysteresis =   +0?C) sensor thermistor           
vid:      +1.350 V
alarms:   
beep_enable:
          Sound alarm disabled



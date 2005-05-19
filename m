From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH] updated it87 for kernel 2.6 - Part1
Message-Id: <20040217105426.21286f77.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040216231514.61a84c5e.komoriya@paken.org>
In-Reply-To: <20040216231514.61a84c5e.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You seem to consider that each temperature channel *must* have
> either the PIIDIODE (0x01) or the THERMISTOR (0x08) bit set. If none
> is set, you call it INVALID. According to the data sheets, I would
> say that the only invalid value is when *both* bits are set at the
> same time. No bits most probably means that the channel is not in
> use. For this reason, I would rename the INVALID constant to UNUSED
> or DISABLED. I don't think we need a numerical value for INVALID,
> since it is not going to happen(if we do code cleanly, see below).
> (And, BTW, I think I would prefix them with "SENSOR_" or something
> similar, but you are free to do or not to do it).

I agree with you. I was feeling something strange with INVALID.
I think it's better to change "invalid" in sensors program(patch is
attached).

Also, documentation for it87 should be changed.
-----
  To change sensor x to a thermistor, 'echo 2 > sensorx'
  where x is 1, 2, or 3.
  To change sensor x to a thermal diode, 'echo 3 > sensorx'.
- Any other value is invalid.
+ Give 0 for unused sensor.
----

> Then, you forgot to define sysfs files for reading and writing the
> temperature sensor types! Which makes your patch not acceptable
> as-is. To follow the example of the other drivers, these files
> should be named sensor[1-3]. Please note that according to my remark
> above, it is under your responsability to ensure that you will never
> set both type bits to 1 for a given channel. The data sheets don't
> give details about what would happen, but I wouldn't try. The
> prefered way to make sure it doesn't happen is probably to make
> invalid writes fail (sysfs callback function returns -1 instead of
> 0).

Definition of sysfs files already exist in kernel2.6 source and works
for me... Oh, I was in confusion! Sorry for my rush patch.
Please just ingore my first patch which contains useless code.

My proposal with attached new patch is:
 1. delete temp_type option because it can be set at runtime
 2. change the value for thermal diode to be compatible with 'sensors'
    program
 3. add some comments for temperature types
 4. Change copyright mark of (c) to (C)

> Please make sure the driver compiles and works as intended after
> your patch is applied. This is one of the reasons why it is great to
> cut large patches into pieces, because it lets you test each change
> individually.

I'll be more careful from this time.

Thanks in advance.
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-cvs-fix-it87-sensor.patch
Type: application/octet-stream
Size: 1338 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040217/91d04206/lm_sensors-cvs-fix-it87-sensor.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.2-rc2_it87_sensor_type.patch
Type: application/octet-stream
Size: 2311 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040217/91d04206/linux-2.6.2-rc2_it87_sensor_type.obj

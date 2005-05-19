From: Manfred.Knick@T-Online.de (Manfred Knick)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: Addendum : more info
Message-Id: <200405041801.09329.Manfred.Knick@T-Online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Jean,

actually there exists 

 # ll /proc/sys/dev/sensors/w83781d-i2c-0-2d/
total 0
-r--r--r--    1 root     root            0 May  4 17:47 alarms
-rw-r--r--    1 root     root            0 May  4 17:47 beep
-rw-r--r--    1 root     root            0 May  4 17:47 fan1
-rw-r--r--    1 root     root            0 May  4 17:47 fan2
-rw-r--r--    1 root     root            0 May  4 17:47 fan3
-rw-r--r--    1 root     root            0 May  4 17:47 fan_div
-rw-r--r--    1 root     root            0 May  4 17:47 in0
-rw-r--r--    1 root     root            0 May  4 17:47 in1
-rw-r--r--    1 root     root            0 May  4 17:47 in2
-rw-r--r--    1 root     root            0 May  4 17:47 in3
-rw-r--r--    1 root     root            0 May  4 17:47 in4
-rw-r--r--    1 root     root            0 May  4 17:47 in5
-rw-r--r--    1 root     root            0 May  4 17:47 in6
-rw-r--r--    1 root     root            0 May  4 17:47 rt1
-rw-r--r--    1 root     root            0 May  4 17:47 rt2
-rw-r--r--    1 root     root            0 May  4 17:47 rt3
-rw-r--r--    1 root     root            0 May  4 17:47 temp1
-rw-r--r--    1 root     root            0 May  4 17:47 temp2
-rw-r--r--    1 root     root            0 May  4 17:47 temp3
-r--r--r--    1 root     root            0 May  4 17:47 vid
-rw-r--r--    1 root     root            0 May  4 17:47 vrm

-- and it gets contiunually updated !

A readout of these raw data contents follows:

			--- snip ---
alarms:
	3912

beep:
	0 0

fans:
	-1 3013
	5000 5578
	5273 5192

fan_div:
	2 2 2

voltages:
	1.84 2.24 2.06
	1.84 2.24 2.06
	2.82 3.79 3.23
	2.66 0.54 3.02
	1.17 0.38 3.14
	0.51 0.00 3.50
	0.03 0.51 3.36

temperatures:
	-47.0 0.0 28.0
	70.0 60.0 30.5
	80.0 75.0 28.0

vid:
	2.050

vrm:
	8.2
			--- snip ---

And with the provided information from the lm-sensors pages, esp.
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d,
and Winbond homepage, I was able to configure gkrellm2 to display the correct 
values.

But: Without "sensors -s" I can't set the correct limitations for 
hw-monitoring.

So the only question remains:

Why the hell can't "sensors -s" access 
	/proc/sys/dev/sensors/w83781d-i2c-0-2d/
for writing?

	# sensors -s
	w83781d-i2c-0-2d: Can't access procfs/sysfs file for writing;
	Run as root?

	Yes, sure! I do.

Could it have to do that lm-sensors-2.8.6 expects
	procfs/sysfs/dev/sensors/,
while kernel 2.4.25-r2 still provides 
	/proc/sys/dev/sensors/
???

That's what I couldn't figure out yet.

Or do I still have a fault in my patching ??

I would be glad for any idea that comes to your mind.


Kind regards

Manfred
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040504/ced2339b/attachment.bin

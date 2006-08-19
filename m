From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 19 Aug 2006 15:27:35 +0000
Subject: [lm-sensors] [patch 0/3] pc87360 - fix unchecked
Message-Id: <44E72DE7.10907@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ok, this series of patches should get it right, finally.
IOW, they use multiple sysfs groups to organize the attributes
along the boundaries of sensor-type, configurations, and
sysfs_create/remove_group()s where appropriate.

1- code-move (prep patch)
    moves get-set-decl tuples for 3 items:
        cpu0_vid, vrm, alarms_in
    up, to just after the get-set-decl tuple for Voltages.
    These items are already 'activated' together, so the move
        reinforces the grouping thats made explicit in next patch.

2- add 4 explicit attribute groups for the 5 sensor types:
    voltage (in), therm, temp, and fan & pwm (together in one group).
    use sysfs_remove_group() to drop them,
    but keeps the existing startup code, which calls device_create_file 
in loops.

3- rework sys-device-interface startup
    use sysfs_create_group() for 2 sensor-types which are chip-model 
invariant.
       ie all-or-nothing attribute groups
    other 2 groups vary too much due to configuration, etc,
       so we keep the loops of device_create_file(), but now check their 
returns.

Patch 2 adds the groups, so enlarges the .text (by a bit)
Patch 3 shrinks the function in question, but corrects an omission in 
pc87360_detach_client,
which enlarges it overall (by ~200 bytes)

[jimc at harpo hwmon-stuff]$ size ac*/drivers/hwmon/pc87360.ko
   text    data     bss     dec     hex filename
  14246    3384      32   17662    44fe ac-0/drivers/hwmon/pc87360.ko
  14246    3384      32   17662    44fe ac-1/drivers/hwmon/pc87360.ko
  14398    3800      32   18230    4736 ac-2/drivers/hwmon/pc87360.ko
  14454    3800      32   18286    476e ac-3/drivers/hwmon/pc87360.ko

FWIW -
The patchset survived this stress-test:
     for i in `seq 1000`; do { rmmod pc87360;  modprobe pc87360;  
sensors -s; sensors; }  done
It takes about 3.5 secs to re-mod, and about 0.3 sec to reset and query 
sensors.


Thanks also to Mark Hoffman and GregKH,

who both explained that the static *_ATTR declarations are reusable for
multiple devices, and then repeated themselves enough for me to understand.
This kinda defeats the general applicability of my idea to disable
attrs (by setting mode=0) before theyre created by sysfs_create_group. 

While the above works well enough for 'de-configuring' some of a group's 
members,
it falls down if a 2nd set is wanted, for a 2nd device, unless it 
happens to want the
identical de-configuration.

So, to paraphrase the lesson (and risk screwing up ;)
sysfs attr-groups are 'file-lists', and a file-name can appear in 
multiple sub-directories,
(just like foo/bar, ack/bar), which is what happens if the group has a 
name (foo, ack).
Callbacks also get a struct device *p, with which it can differentiate 
amongst multiple instances
of the group.  (Im still handwaving past how sysfs core provides the 
right devp,
but I havent yet used the source, its easier to just ponder a bit 1st ;)


thanks
~jimc



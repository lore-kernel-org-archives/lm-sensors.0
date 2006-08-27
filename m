From: jim.cromie@gmail.com (Jim Cromie)
Date: Sun, 27 Aug 2006 17:06:12 +0000
Subject: [lm-sensors] TODO: unchecked return codes from device_create_file
Message-Id: <44F1D104.1060109@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


in the interest of raising the visibility of 1 particular task,
Ive gone back and harvested (poached verbatim) from old email.

Priority is for someone else to name, presumably in contrast
to other TODO items ;-)

Feel free to lay claim to any of these driver fixups.
While having the hardware is good, its not essential, since youre
not changing functionality (if done correctly)


< for the mentioned subject..>

Here is a quick status summary for drivers/hwmon:

Done by Mark M. Hoffman:
 o asb100
 o lm75
 o lm78
 o smsc47b397
 o w83627hf

Done by Jim Cromie:
 o pc87360

Will be done by David Hubbard:
 o w83627ehf

Will be done by me: (Jean)
 o f71805f
 o it87
 o lm63
 o lm83
 o lm90

This leaves the following list:
 o abituguru
 o adm1021
 o adm1025
 o adm1026
 o adm1031
 o adm9240
 o atxp1
 o ds1621
 o fscher
 o fscpos
 o gl518sm
 o gl520sm
 o lm77
 o lm80
 o lm85
 o lm87
 o lm92
 o max1619
 o sis5595
 o smsc47m1
 o smsc47m192
 o via686a
 o vt8231
 o w83781d
 o w83791d
 o w83792d
 o w83l785ts

Almost 1000 warnings for drivers/hwmon alone... OTOH I wonder how
device_create_file and friends qualified for __must_check given that
nothing wrong can happen if they fail, from the kernel's point of view.
The files are not created and that's about it.

If you are going to fix some of the drivers listed above, please
advertise on the lm-sensors list so that your work is not duplicated.



The current best practice is 2-fold:

1 - declare one or more sysfs_groups, containing all the relevant 
attributes.
This replaces all those separate, (presumably unchecked) calls to 
device_create_file()

2 - for drivers whose sets of attributes need to vary ( drivers 
supporting multiple chips ),
you can still group them, but must call device_create_file() 
individually so that
attributes for unavailable hardware are not created.  Grouping them is 
still good,
since you can remove them as a group !


A good model is Mark Hoffman's patch.

> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html
> 
> 




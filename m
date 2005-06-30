From: bgardner@wabtec.com (bgardner@wabtec.com)
Date: Thu, 30 Jun 2005 16:08:07 +0000
Subject: [lm-sensors] [Patch 0/5] w1: sysfs, select-slave, ds2433
Message-Id: <200506300907.45063.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Evgeniy,

I finally have a working driver for w1 family 23.
Along the way, I made a few changes to the w1 slave stuff.
I also learned how to use quilt, so this wasn't nearly as painful as the last 
patch set. =)
The patches depend on each other and should be applied in the following order.

w1-select-slave.diff
I added w1_reset_select_slave()
This function resets the w1 bus and either sends a skip rom (0xCC) or the full 
select ROM + id.  If there is only 1 slave present, it does skip rom.

w1-select-slave-use.diff
I changed w1-therm to use w1_reset_select_slave.

w1-container-of.diff
I added three inline function to hide the use of container_of().
 - dev_to_w1_slave()
 - kobj_to_w1_slave()
 - dev_to_w1_master()

w1-slave-sysfs.diff
Every slave now has at least two sysfs files:
 - id : an 8 byte binary file that holds the 64 bit id 
   example: [23 6c dc 1c 00 00 00 43]
 - name : the name, example: [23-0000001cdc6c]
Family ops is now two callback functions: add_slave() and remove_slave().
The family driver is responsible for creating any other sysfs entries.
This patch updates w1-smem (which is pretty much empty) and w1-therm.

w1-ds2433.diff
The driver for family 23.

Would you take a moment to review and try it out to make sure I didn't break 
anything?

Thanks,
Ben


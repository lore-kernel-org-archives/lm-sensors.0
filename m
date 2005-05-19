From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dallas 1-wire protocol implementation.
Message-Id: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is driver implementing the most interesting IMHO parts of Dallas
1-wire protocol for linux kernel 2.6.
It supports search/reset/read temperature and prowides API like i2c
layer does.
Since i only have 18s20 termometer driver provides only
temperature reading. Obviously it is easy to report alarms,
writing/reading eeprom and so on with created 1-wire framework.

For testing i soldered ddc pin in my matrox g400 card to termometer's
data pin and used this pin in GPIO mode. 
Strong pull-up was got from harddrive +5V.

Read/write GPIO bits primitives are written and described in
matrox_w1.c.
Great thanks to Petr Vandrovec <VANDROVE@vc.cvut.cz> for explaining some
bits of his matrox_fb driver, GPIO and I2C.

The basic schema is following:
wire.ko - provides general 1-wire API, netlink logging of search
process(can be easily extended to log any other 1-wire events), sysfs
processing and so on.

matrox_w1.ko - low level transport realisation.

w1d - netlink userspace daemon to monitor netlink events.

All events can be both monitored through sysfs and netlink(after
extending).

A bit extended schema:
after inserting wire.ko it registers new bus type and driver.
It also creates main control kernel thread which accepts all
new masters creating/destroying events. This code was
moved to kernel thread since all sysfs related operations may
sleep. When matrox_w1.ko or any other low level transport driver wants
to register new master(i call master the logical connect from
"master" part of computer to 1-wire device, one can have many masters,
for example LPT and matrox GPIO masters) it can register bit operations
it provides with predefined API from 1-wire main driver(wire.ko).
New initialized 1-wire master object is then inserted into global list
of masters. 
After registering main driver creates kernel thread to
process this master's events. The reason for creating kernel thread is
the same as for control thread. This thread searches for slaves and
creates appropriate sysfs entries and sends netlink notifications.
Reading from appropriate slave sysfs entry initiates READ ROM
command(from only matching slave device).

I think it is easy and simple to extend this framework to work with any
kind of operations with Dallas's 1-wire protocol.

I think it is the best and the only mail list to send this kind of
drivers.
Please test and comment.

	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt

-------------- next part --------------
A non-text attachment was scrubbed...
Name: matrox_w1.c
Type: text/x-csrc
Size: 6372 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/matrox_w1.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1.c
Type: text/x-csrc
Size: 14979 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1.h
Type: text/x-chdr
Size: 2340 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_int.c
Type: text/x-csrc
Size: 4940 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1_int.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_int.h
Type: text/x-chdr
Size: 1214 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1_int-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_io.h
Type: text/x-chdr
Size: 3594 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1_io.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_log.h
Type: text/x-chdr
Size: 1053 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1_log.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_netlink.c
Type: text/x-csrc
Size: 1552 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1_netlink.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1_netlink.h
Type: text/x-chdr
Size: 1136 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1_netlink-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w1d.c
Type: text/x-csrc
Size: 2907 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/b55e56f2/w1d.bin

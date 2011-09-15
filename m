From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 15 Sep 2011 11:41:56 +0000
Subject: Re: [lm-sensors] General API and documentation discussion
Message-Id: <1316086917.2033.16.camel@tellur>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-e6XD7MZL+K1BO/i7n86h"
List-Id: <lm-sensors.vger.kernel.org>
References: <1315948191.2018.20.camel@tellur>
In-Reply-To: <1315948191.2018.20.camel@tellur>
To: lm-sensors@vger.kernel.org


--=-e6XD7MZL+K1BO/i7n86h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello Guenter,
Am Dienstag, den 13.09.2011, 22:33 -0700 schrieb Guenter Roeck:
[...]
> My priorities would be
> 
> 1) Documentation/hwmon/sysfs-interface
> 2) Code in drivers/hwmon
> 
> libsensors is just an application and not expected to implement everything,
> even though it would be great if it did. But you can't argue that a system call
> should go away just because glibc doesn't implement it.
> 
> If there are discrepancies, it would be good to have a table listing what
> those are. sysfs-interface is not (necessarily) perfect, and there are lots
> of non-standardized attributes used by various hwmon drivers. Also,
> sysfs-interface is not cast in stone; just look at its history. If I catch
> a non-standard attribute in a driver I am working on, and if I happen to have
> some spare time, I look around and check if it is used by multiple drivers.
> If it is, it may make sense to add it to the ABI, and update drivers to use
> it if applicable. One example I remember is update_interval.
> 
Ok, I did a bit digging and it seems only libsensors is missing some
sysfs attributes and not the other way around. I attached a list with a
side-by-side comparison (minus hardware trip point handling).

I think I will run with what is documented in
Documentation/hwmon/sysfs-interface for my first iteration of the core
interface, if something pops up in the process of porting drivers to the
new interface it can always be added later.

Only thing I noticed is "vid" and "vrm" are listed as voltage features,
though libsensors count them as an extra "cpu" feature. Should we change
the kernel doc accordingly, or should it stay under voltages?
[...]
> That is really a tricky and sensitive issue. So far the relationship is strictly
> thermal -> hwmon, since hwmon by itself has a passive role. Fan handling with
> its trip point settings are pretty much at the edge of things, and probably
> acceptable because the actual _action_ associated with it is implemented in HW.
> We have just started talking about if and how to handle interrupts, sysfs notifications,
> and uevents.
> 
I will leave this out of the core interface for the time being. I think
we should reiterate the issue, after doing a simple core interface.

> One of the key question here is if the kernel should do anything besides notifying
> applications. Seems to me the real action should be in userland, not in the kernel.
> But then maybe I am missing some essential use cases, where the action would _have_
> to be in the kernel. If so, we'll have to think really carefully about any to-be-defined
> APIs.
> 
I think many people want to have the thermal management in kernel, so
even if no userspace is present the right actions could be performed to
protect the hardware. This is the philosophy of thermal drivers, where
the userspace could specify which actions the kernel should perform in
case of rising temperature, like throttling the hardware or rising fan
speeds, but no actions are performed in userspace itself. So I think we
need some generic thermal driver to take action according to information
it gets from hwmon drivers, the core interface will be a great way to
allow such cooperation.

But this is only the third step after
1. specifying a basic core interface with split out of the sysfs
handling
2. knowing how to handle interrupts and hardware trip points and
extending the core interface to reflect such things

Would you be ok with this?
--Lucas

> Guenter
> 


--=-e6XD7MZL+K1BO/i7n86h
Content-Disposition: attachment; filename="hwmon-sysfs-vs-libsensors"
Content-Type: text/plain; name="hwmon-sysfs-vs-libsensors"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

sysfs kernel doc            |    libsensors code
                         general
name                        |
update_interval             |
                           cpu
vid (listed under voltages) |   vid
vrm	(listed under voltages) |
                         voltages
input                       |   input
min                         |   min
max                         |   max
lcrit                       |   lcrit
crit                        |   crit
average                     |
lowest                      |
highest                     |
reset_history               |
label                       |
alarm                       |   alarm
min_alarm                   |   min_alarm
max_alarm                   |   max_alarm
lcrit_alarm                 |   lcrit_alarm
crit_alarm                  |   crit_alarm
beep                        |   beep
                           fans
input                       |   input
min                         |   min
max                         |
div                         |   div
pulses                      |   pulses
target                      |
label                       |
(unclear)                   |   alarm
beep                        |   beep
fault                       |   fault
						   pwm
pwm                         |
enable                      |
mode                        |
freq                        |
auto_channels_tem           |
*various trip points*       |
                        temperatures
type                        |   type
input                       |   input
min                         |   min
max                         |   max
max_hyst                    |   max_hyst
lcrit                       |   lcrit
crit                        |   crit
crit_hyst                   |   crit_hyst
emergency                   |   emergency
emergency_hyst              |   emergency_hyst
offset                      |   offset
label                       |
lowest                      |
highest                     |
reset_history               |
alarm                       |   alarm
min_alarm                   |   min_alarm
max_alarm                   |   max_alarm
lcrit_alarm                 |   lcrit_alarm
crit_alarm                  |   crit_alarm
emergency_alarm             |   emergency_alarm
beep                        |   beep
fault                       |   fault
                        currents
input                       |   input
min                         |   min
max                         |   max
lcrit                       |   lcrit
crit                        |   crit
average                     |
lowest                      |
highest                     |
reset_history               |
alarm                       |   alarm
min_alarm                   |   min_alarm
max_alarm                   |   max_alarm
lcrit_alarm                 |   lcrit_alarm
crit_alarm                  |   crit_alarm
beep                        |   beep
                          power
input                       |   input
input_lowest                |   input_lowest
input_highest               |   input_highest
reset_history               |
accuracy                    |
average                     |   average
average_interval            |   average_interval
average_interval_min        |
average_interval_max        |
average_min                 |
average_max                 |
average_lowest              |   average_lowest
average_highest             |   average_highest
cap                         |   cap
cap_hyst                    |   cap_hyst
cap_min                     |
cap_max                     |
max                         |   max
crit                        |   crit
alarm                       |   alarm
cap_alarm                   |   cap_alarm
max_alarm                   |   max_alarm
crit_alarm                  |   crit_alarm
                          energy
input                       |   input
                         humidity
input                       |   input
                        intrusion
alarm                       |   alarm
beep                        |   beep

--=-e6XD7MZL+K1BO/i7n86h
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-e6XD7MZL+K1BO/i7n86h--


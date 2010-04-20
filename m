From: katsuhiko.hirata@jrits.ricoh.co.jp
Date: Tue, 20 Apr 2010 06:16:08 +0000
Subject: [lm-sensors] Intel GM45 supported?
Message-Id: <OFDE606C91.A9A81289-ON4925770B.00223C8F-4925770B.00226EBC@mta.ricoh.co.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please tell me.

I want to acquire the temperature of GM45 by using "lm_sensors".

1. my environment：

OS：Centos 5.3
kernel:2.6.18-128.1.10.el5
lm_sensors:3.1.2
ChipSet：Intel GM45

2. result(now):

[root@abo-svr gm965temp-module_o]# sensors
coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +26.0°C  (high = +100.0°C, crit = +100.0°C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +26.0°C  (high = +100.0°C, crit = +100.0°C)

--------------------

3.
It has the driver referring to the following.

http://lists.lm-sensors.org/pipermail/lm-sensors/2009-July/026358.html

result(lsmod):
[root@abo-svr osibadm]# lsmod | grep hwmon
hwmon                   7365  2 gm965temp,coretemp

--------------------
What is bad?

best regards


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <401577E2.7000008@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>1* Fix libsensors so that it handles fscher correctly.
> 
> Oh, BTW: Could you please send me the list of files as they appear in
> sysfs? It'll be less error prone than reading the macros in your code (I
> have nothing against using them, but this makes thing a bit hard to
> understand at first sight).

video:~ # dir /sys/bus/i2c/devices/0-0073/
total 0
drwxr-xr-x    3 root     root            0 Jan 26 20:09 .
drwxr-xr-x    6 root     root            0 Jan 26 20:09 ..
-r--r--r--    1 root     root         4096 Jan 26 20:09 alarms
-rw-r--r--    1 root     root         4096 Jan 26 20:09 control
-rw-r--r--    1 root     root         4096 Jan 26 20:09 detach_state
-rw-r--r--    1 root     root         4096 Jan 26 20:09 fan_div1
-rw-r--r--    1 root     root         4096 Jan 26 20:09 fan_div2
-rw-r--r--    1 root     root         4096 Jan 26 20:09 fan_div3
-r--r--r--    1 root     root         4096 Jan 26 20:09 fan_input1
-r--r--r--    1 root     root         4096 Jan 26 20:09 fan_input2
-r--r--r--    1 root     root         4096 Jan 26 20:09 fan_input3
-rw-r--r--    1 root     root         4096 Jan 26 20:09 fan_status1
-rw-r--r--    1 root     root         4096 Jan 26 20:09 fan_status2
-rw-r--r--    1 root     root         4096 Jan 26 20:09 fan_status3
-r--r--r--    1 root     root         4096 Jan 26 20:09 in_input0
-r--r--r--    1 root     root         4096 Jan 26 20:09 in_input1
-r--r--r--    1 root     root         4096 Jan 26 20:09 in_input2
-r--r--r--    1 root     root         4096 Jan 26 20:09 name
drwxr-xr-x    2 root     root            0 Jan 26 20:09 power
-rw-r--r--    1 root     root            0 Jan 26 20:09 pwm1
-rw-r--r--    1 root     root            0 Jan 26 20:09 pwm2
-rw-r--r--    1 root     root            0 Jan 26 20:09 pwm3
-r--r--r--    1 root     root         4096 Jan 26 20:09 revision
-r--r--r--    1 root     root         4096 Jan 26 20:09 temp_input1
-r--r--r--    1 root     root         4096 Jan 26 20:09 temp_input2
-r--r--r--    1 root     root         4096 Jan 26 20:09 temp_input3
-rw-r--r--    1 root     root         4096 Jan 26 20:09 temp_status1
-rw-r--r--    1 root     root         4096 Jan 26 20:09 temp_status2
-rw-r--r--    1 root     root         4096 Jan 26 20:09 temp_status3
-rw-r--r--    1 root     root         4096 Jan 26 20:09 watchdog_control
-rw-r--r--    1 root     root         4096 Jan 26 20:09 watchdog_preset
-rw-r--r--    1 root     root         4096 Jan 26 20:09 watchdog_status

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de



From: paul@astropaul.com (Paul Reilly)
Date: Sat, 25 Nov 2006 13:21:33 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <1164460893.4568435d2695a@mail.third-rock.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163375222.4557b2764fc69@mail.third-rock.net>
In-Reply-To: <1163375222.4557b2764fc69@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

> Theoretically there could be 4 temps for one physical CPU. Two for each core
> * 2 = 4. And because your CPU is dualcore, and your CPU supports only 1
> temperature/core so you see two of them ;) I hope I clarified that.

Yes, I see from the k8temp.c
static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);

So,
temp1 = CPU#0 Core#0 Temp #0
temp2 = CPU#0 Core#0 Temp #1
temp3 = CPU#0 Core#1 Temp #0
temp4 = CPU#0 Core#1 Temp #1

My Dual Core Opteron (265) only reports temp1, and temp3.
That is OK. One temperature per core.

What would it look like if I add a second physical processor in
the second socket? Would I get the same lmsensor names repeated?

> So all in all, this works fine. Lets check the i2c bus related problem. And
> wait for some logs from you ;)

Here are the logs.
It looks like a timeout problem....

syslog:Nov 25 08:31:58 discover kernel: i2c /dev entries driver
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-9191: ISA main adapter
registered
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: nForce2 SMBus adapter
at 0xa000
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: nForce2 SMBus adapter
at 0xa040
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-9191: Driver w83627hf
registered
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-9191: Driver w83781d-isa
registered
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)


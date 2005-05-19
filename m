From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [jamagallon@able.es: i2c: lost sensors with 2.6.10(-mm1)]
Message-Id: <20050107011207.GA20597@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anyone have any ideas?  If so, care to join this linux-kernel thread?

----- Forwarded message from "J.A. Magallon" <jamagallon@able.es> -----

Date: Fri, 07 Jan 2005 00:46:31 +0000
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com, akpm@osdl.org
Subject: i2c: lost sensors with 2.6.10(-mm1)

Hi...

I have lost my sensors info with 2.6.10, in particular -mm1.
They work fine with 2.6.9-mm1 (current state of the box, booted on
2.6.9 or 10, no other difference).

Some info follows.

With 2.6.9-mm1, I get this:

Module                  Size  Used by
w83627hf               25128  0
i2c_sensor              3456  1 w83627hf
i2c_isa                 2304  0
i2c_i801                7820  0
i2c_dev                 8192  0
i2c_core               19712  5 w83627hf,i2c_sensor,i2c_isa,i2c_i801,i2c_dev

sensors:
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.49 V  (min =  +1.93 V, max =  +1.93 V)
..

With 2.6.10-mm1:

Module                  Size  Used by
w83627hf               24224  0
i2c_sensor              3968  1 w83627hf
i2c_isa                 2304  0
i2c_i801                9996  0
i2c_dev                 8960  0
i2c_core               20992  5 w83627hf,i2c_sensor,i2c_isa,i2c_i801,i2c_dev

sensors:
No sensors found!

I have noticed different contents in /sys:
under 2.6.9:
/sys/devices/platform/i2c-1:
/sys/devices/platform/i2c-1/1-0290:
/sys/devices/platform/i2c-1/1-0290/power:
/sys/devices/platform/i2c-1/power:

under 2.6.10:
/sys/devices/platform/i2c-1:
/sys/devices/platform/i2c-1/power:

So some /sys nodes are missing !!!
(the isa bus)


Debug output from 2.6.10-mm1:

Jan  7 01:33:11 werewolf kernel: i2c /dev entries driver
Jan  7 01:33:11 werewolf kernel: i2c-core: driver dev_driver registered.
Jan  7 01:33:11 werewolf kernel: i801_smbus 0000:00:1f.3: I801 using PCI Interrupt for SMBus.
Jan  7 01:33:11 werewolf kernel: i801_smbus 0000:00:1f.3: SMBREV = 0x2
Jan  7 01:33:11 werewolf kernel: i801_smbus 0000:00:1f.3: I801_smba = 0x500
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-0: Registered as minor 0
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-0: registered as adapter #0
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: Registered as minor 1
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: registered as adapter #1
Jan  7 01:33:11 werewolf kernel: i2c-core: driver w83627hf registered.
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: found normal isa entry for adapter 9191, addr 0290
Jan  7 01:33:12 werewolf sensord: sensord started
Jan  7 01:33:12 werewolf lm_sensors: sensord startup succeeded

Some ideas ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-2mdk)) #2




----- End forwarded message -----

-- 

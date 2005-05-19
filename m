From: ploujj@gmail.com (Michael P)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <18e57513050327204829b8bbce@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325220626.4fdc613c.khali@linux-fr.org>
In-Reply-To: <20050325220626.4fdc613c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yeah, the new script doesn't help since I do have the IT8712F chip.
Here's:
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial
0970-0977 : 0000:00:07.0
  0970-0977 : sata_nv
09f0-09f7 : 0000:00:07.0
  09f0-09f7 : sata_nv
0b70-0b73 : 0000:00:07.0
  0b70-0b73 : sata_nv
0bf0-0bf3 : 0000:00:07.0
  0bf0-0bf3 : sata_nv
0cf8-0cff : PCI conf1
1000-107f : motherboard
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1010-1015 : ACPI CPU throttle
  101c-101c : PM2_CNT_BLK
  1020-1027 : GPE0_BLK
1080-10ff : motherboard
1400-147f : motherboard
1480-14ff : motherboard
  14a0-14af : GPE1_BLK
1800-187f : motherboard
1880-18ff : motherboard
1c00-1c3f : 0000:00:01.1
1c40-1c7f : 0000:00:01.1
6000-6fff : PCI Bus #04
7000-7fff : PCI Bus #03
8000-8007 : 0000:01:09.0
8400-8403 : 0000:01:09.0
8800-8807 : 0000:01:09.0
8c00-8c03 : 0000:01:09.0
9000-900f : 0000:01:09.0
a000-afff : PCI Bus #02
  a000-a0ff : 0000:02:00.0
    a000-a0ff : sk98lin
b400-b4ff : 0000:00:04.0
b800-b8ff : 0000:00:04.0
d400-d40f : 0000:00:07.0
  d400-d40f : sata_nv
d800-d81f : 0000:00:01.1
dc00-dc07 : 0000:00:0a.0
  dc00-dc07 : forcedeth
f000-f00f : 0000:00:06.0
  f000-f007 : ide0
  f008-f00f : ide1

That is with these modules loaded:
# lsmod
Module                  Size  Used by
it87                   25884  0 
i2c_sensor              3200  1 it87
i2c_isa                 2432  0 
i2c_dev                10240  0 
i2c_nforce2             5760  0 
i2c_core               19736  5 it87,i2c_sensor,i2c_isa,i2c_dev,i2c_nforce2
vmnet                  28632  12 
vmmon                 170060  0 
nvidia               4559932  12 

From what I can see, nothing else is using the chip. I might be wrong
in my interpretations though.

From: stic6021@yahoo.com (Steve Tice)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Follow-up, ticket #1375
Message-Id: <20030814211421.52539.qmail@web11206.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I may have stumbled across the root cause of my ticket #1375
(Tyan S2727, no chips detected). The main chipset is the
ServerWorks GC-SL with a CSB6 controlling the PCI bus. I just
noticed the CSB6 is on the "NEW AND REQUESTED BUS DRIVERS" list.

Is there any information, besides the following lspci output,
that I might provide to help?

---
[root@install3 lm_sensors-2.8.0]# lspci -v
00:00.0 Host bridge: ServerWorks: Unknown device 0017 (rev 32)
        Flags: fast devsel

00:00.1 Host bridge: ServerWorks: Unknown device 0017
        Flags: fast devsel

00:08.0 Ethernet controller: Intel Corp.: Unknown device 100e
(rev 02)
        Subsystem: Intel Corp.: Unknown device 100e
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ
16
        Memory at fe980000 (64-bit, non-prefetchable)
[size8K]
        Memory at fe9e0000 (64-bit, non-prefetchable) [sizedK]
        I/O ports at c400 [sized]
        Expansion ROM at fe970000 [disabled] [sizedK]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable
-

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
100] (rev 10)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server
Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 17
        Memory at fe9fd000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c800 [sized]
        Memory at fe9a0000 (32-bit, non-prefetchable)
[size8K]
        Capabilities: [dc] Power Management version 2

00:0a.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27) (prog-i
f 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 8008
        Flags: bus master, stepping, medium devsel, latency 64,
IRQ 30
        Memory at fd000000 (32-bit, non-prefetchable) [sizeM]
        I/O ports at e800 [size%6]
        Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe9c0000 [disabled] [size8K]
        Capabilities: [5c] Power Management version 2

00:0e.0 RAID bus controller: ServerWorks: Unknown device 0213
(rev a0) (prog-if
83)
        Subsystem: ServerWorks: Unknown device 0213
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e400 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at d800 [size=8]
        I/O ports at d400 [size=4]
        I/O ports at d000 [size]

00:0f.0 ISA bridge: ServerWorks: Unknown device 0203 (rev a0)
        Subsystem: ServerWorks: Unknown device 0201
        Flags: bus master, medium devsel, latency 64

00:0f.1 IDE interface: ServerWorks: Unknown device 0213 (rev a0)
(prog-if 8a [Ma
ster SecP PriP])
        Subsystem: ServerWorks: Unknown device 0212
        Flags: bus master, medium devsel, latency 64
        I/O ports at 01f0 [size=8]
        I/O ports at 03f4
        I/O ports at 0170 [size=8]
        I/O ports at 0374
        I/O ports at ffa0 [size]

00:0f.3 Host bridge: ServerWorks: Unknown device 0227
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

[root@install3 lm_sensors-2.8.0]#
---


Thanks for making lm-sensors available,
Steve Tice

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com

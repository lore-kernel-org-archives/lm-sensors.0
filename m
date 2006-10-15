From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 15 Oct 2006 12:03:33 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061015140333.3048fbe7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

Michael Kress wrote:
> > But it only appeared once, I normally load the module once, then I call
> > it every 3 sec over the whole day. The only difference today: I loaded
> > the module lots of times today.
> > Another difference: I activated MSI in the kernel in order to solve this
> > problem: http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0101.html
> > CONFIG_PCI_MSI=y
> 
> I recompiled the kernel without CONFIG_PCI_MSI and the same thing
> happened. It's absoluteley the same config as before...

Did you also cycle the pc87427 module several times this time?

> Oct 15 09:57:13 matrix kernel: general protection fault: 0000 [1] SMP
> Oct 15 09:57:13 matrix kernel: CPU 0
> Oct 15 09:57:13 matrix kernel: Modules linked in: pc87427 hwmon i2c_isa
> i2c_core xt_physdev iptable_filter ip_tables x_tables bridge ipv6
> autofs4 sunrpc pcmcia yenta_socket rsrc_nonstatic pcmcia_core joydev
> video thermal processor fan container button battery ac uhci_hcd
> ehci_hcd e1000 dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod 3w_9xxx
> aic79xx scsi_transport_spi sd_mod
> Oct 15 09:57:13 matrix kernel: Pid: 9044, comm: sensors Not tainted
> 2.6.16-xen #1
> Oct 15 09:57:13 matrix kernel: RIP: e030:[<ffffffff80178679>]
> <ffffffff80178679>{vfs_read+281}
> Oct 15 09:57:13 matrix kernel: RSP: e02b:ffff880028b99f18  EFLAGS: 00010202
> Oct 15 09:57:13 matrix kernel: RAX: 0000000000000002 RBX:
> 4c0841894c01894c RCX: 0000000000000000
> Oct 15 09:57:13 matrix kernel: RDX: 0000000000000002 RSI:
> 0000000000000001 RDI: ffff88003dd64260
> Oct 15 09:57:13 matrix kernel: RBP: 0000000000000002 R08:
> 00000000fffffffb R09: 0000000000000000
> Oct 15 09:57:13 matrix kernel: R10: 00000000ffffffff R11:
> 0000000000000000 R12: 0000000000000001
> Oct 15 09:57:13 matrix kernel: R13: 00002b0dfe3ca000 R14:
> ffff880028b99f50 R15: 000000000054ff10
> Oct 15 09:57:13 matrix kernel: FS:  00002b0dfe2c48a0(0000)
> GS:ffffffff8049a000(0000) knlGS:0000000000000000
> Oct 15 09:57:13 matrix kernel: CS:  e033 DS: 0000 ES: 0000
> Oct 15 09:57:13 matrix kernel: Process sensors (pid: 9044, threadinfo
> ffff880028b98000, task ffff88003ea530e0)
> Oct 15 09:57:13 matrix kernel: Stack: ffff88003fec2180 0000000000001000
> 00002b0dfe3ca000 fffffffffffffff7
> Oct 15 09:57:13 matrix kernel:        0000000000000000 ffffffff80178a23
> 0000000000000000 0000000000000002
> Oct 15 09:57:14 matrix kernel:        0000000000001000 000000000054ff10
> Oct 15 09:57:14 matrix kernel: Call Trace:
> <ffffffff80178a23>{sys_read+83} <ffffffff8010b206>{system_call+134}
> Oct 15 09:57:14 matrix kernel:        <ffffffff8010b180>{system_call+0}
> Oct 15 09:57:14 matrix kernel:
> Oct 15 09:57:14 matrix kernel: Code: 4c 8b 6b 10 48 89 df 41 0f b7 45 4c
> 25 00 f0 00 00 3d 00 40
> Oct 15 09:57:14 matrix kernel: RIP <ffffffff80178679>{vfs_read+281} RSP
> <ffff880028b99f18>
> 
> dmesg outputs the same, sensors is running every 3 secs, so must be
> something else.
> It doesn't really disturb me as the rest of the system really stays
> stable and sensors still displays the fan speeds, but maybe you'd like
> to find the reason why.

Well the problem occurs in vfs_read(), so even before reaching the
pc87427 code. I don't quite see how my driver could be responsible.

You could try repeatedly reading other random sysfs files instead, to
see if you can reproduce the problem.

Which 2.6.16 kernel are you using exactly? The 2.6.16.y series was
quite long, please make sure you are using one of the latest updates.

If this is an SMP and/or PREEMPT kernel, you may want to try UP and/or
non-PREEMPT to see if it makes a difference.

-- 
Jean Delvare


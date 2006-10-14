From: kress@hal.saar.de (Michael Kress)
Date: Sat, 14 Oct 2006 16:49:54 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <45311532.8060304@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael Kress wrote:
> sorry, it took a bit ... not because I tested for so long time... ;-)
> I've been modprobe'ing und rmmod'ing the driver constantly for an hour
> or so (every few seconds, with 'watch') and I can still receive the
> expected results without any flaw, nothing irregular, no strange syslog
> messages etc.
>   

woops, that was a bit too quick - I got that after calling 'sensors'
every 3 seconds for the whole afternoon:

Oct 14 17:19:14 matrix kernel: general protection fault: 0000 [1] SMP
Oct 14 17:19:14 matrix kernel: CPU 0
Oct 14 17:19:14 matrix kernel: Modules linked in: xfs exportfs pc87427
hwmon i2c_isa i2c_core xt_physdev iptable_filter ip_tables x_tables
bridge ipv6 autofs4 sunrpc pcmcia yenta_socket rsrc_nonstatic
pcmcia_core joydev video thermal processor fan container button battery
ac uhci_hcd ehci_hcd e1000 dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod
3w_9xxx aic79xx scsi_transport_spi sd_mod
Oct 14 17:19:14 matrix kernel: Pid: 16330, comm: sensors Not tainted
2.6.16-xen #2
Oct 14 17:19:14 matrix kernel: RIP: e030:[<ffffffff80178679>]
<ffffffff80178679>{vfs_read+281}
Oct 14 17:19:14 matrix kernel: RSP: e02b:ffff88003b5adf18  EFLAGS: 00010202
Oct 14 17:19:14 matrix kernel: RAX: 0000000000000002 RBX:
4c0841894c01894c RCX: 0000000000000000
Oct 14 17:19:14 matrix kernel: RDX: 0000000000000002 RSI:
0000000000000001 RDI: ffff8800352fe1e0
Oct 14 17:19:14 matrix kernel: RBP: 0000000000000002 R08:
00000000fffffffb R09: 0000000000000000
Oct 14 17:19:14 matrix kernel: R10: 00000000ffffffff R11:
0000000000000000 R12: 0000000000000001
Oct 14 17:19:14 matrix kernel: R13: 00002ba7142df000 R14:
ffff88003b5adf50 R15: 000000000054ff10
Oct 14 17:19:14 matrix kernel: FS:  00002ba7141d98a0(0000)
GS:ffffffff8049b000(0000) knlGS:0000000000000000
Oct 14 17:19:14 matrix kernel: CS:  e033 DS: 0000 ES: 0000
Oct 14 17:19:14 matrix kernel: Process sensors (pid: 16330, threadinfo
ffff88003b5ac000, task ffff88003fec8970)
Oct 14 17:19:14 matrix kernel: Stack: ffff880000e3fc80 0000000000001000
00002ba7142df000 fffffffffffffff7
Oct 14 17:19:15 matrix kernel:        0000000000000000 ffffffff80178a23
0000000000000000 0000000000000002
Oct 14 17:19:15 matrix kernel:        0000000000001000 000000000054ff10
Oct 14 17:19:15 matrix kernel: Call Trace:
<ffffffff80178a23>{sys_read+83} <ffffffff8010b206>{system_call+134}
Oct 14 17:19:16 matrix kernel:        <ffffffff8010b180>{system_call+0}
Oct 14 17:19:16 matrix kernel:
Oct 14 17:19:16 matrix kernel: Code: 4c 8b 6b 10 48 89 df 41 0f b7 45 4c
25 00 f0 00 00 3d 00 40
Oct 14 17:19:16 matrix kernel: RIP <ffffffff80178679>{vfs_read+281} RSP
<ffff88003b5adf18>

But it only appeared once, I normally load the module once, then I call
it every 3 sec over the whole day. The only difference today: I loaded
the module lots of times today.
Another difference: I activated MSI in the kernel in order to solve this
problem: http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0101.html
CONFIG_PCI_MSI=y

Salut - Michael


-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L



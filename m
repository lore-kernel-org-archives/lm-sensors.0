From: drab@kepler.fjfi.cvut.cz (Martin Drab)
Date: Mon, 08 Aug 2005 21:51:43 +0000
Subject: [lm-sensors] Re: General Protection Fault with bcmsensors
Message-Id: <Pine.LNX.4.60.0508082112260.24859@kepler.fjfi.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 8 Aug 2005, Yani Ioannou wrote:
> On 8/8/05, Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
> > 
> > I'm getting following general protection fault with bmcsensors and
> > i2c-ipmi obtained from today's CVS and with 2.6.13-rc6 kernel. After that
> > system doesn't seem to hang immediatelly (as I was able to do the dmesg
> > below), however it seems that the internal IPMI watchdog restarted the
> > system after a while (or perhaps it did it on its own?), since it did
> > reboot then.
> > 
> > ---------------
...
> > [ 1007.059503] general protection fault: 0000 [1] SMP
> > [ 1007.059511] CPU 1
> > [ 1007.059514] Modules linked in: ipmi_si ipmi_devintf i2c_ipmi bmcsensors i2c_isa i2c_amd756 nfsd exportfs lockd nfs_acl parport_pc lp parport
> > autofs4 sunrpc powernow_k8 freq_table binfmt_misc dm_mod video thermal processor hotkey fan container button battery ac ipv6 usbkbd usbhid
> > ohci_hcd i2c_amd8111 i2c_core hw_random shpchp tg3 ide_cd cdrom sg usbcore ext3 jbd sd_mod
> > [ 1007.059533] Pid: 3655, comm: sensors Not tainted 2.6.13-rc6
> > [ 1007.059535] RIP: 0010:[<ffffffff801fed50>] <ffffffff801fed50>{strcmp+0}
> > [ 1007.059547] RSP: 0018:ffff810071653cb0  EFLAGS: 00010246
> > [ 1007.059552] RAX: ffff000a36343735 RBX: ffff81003596f608 RCX: ffff8100328f96d0
> > [ 1007.059555] RDX: 0000000000000037 RSI: ffff8100710ac9cc RDI: ffff000a36343735
> > [ 1007.059560] RBP: ffff8100328f9680 R08: 000003fa892e45c7 R09: ffff81003535301c
> > [ 1007.059563] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8100710ac910
> > [ 1007.059567] R13: ffff810071653d48 R14: ffff810036776d70 R15: ffff810076d33bf0
> > [ 1007.059571] FS:  00002aaaaaad9e40(0000) GS:ffffffff80541880(0000) knlGS:00000000627c2bb0
> > [ 1007.059574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1007.059577] CR2: 00002aaaadb48000 CR3: 0000000071725000 CR4: 00000000000006e0
> > [ 1007.059581] Process sensors (pid: 3655, threadinfo ffff810071652000, task ffff810035c58a20)
> > [ 1007.059583] Stack: ffffffff801c59d1 ffff8100710ac910 ffff810071653ed8 ffff810071653d38
> > [ 1007.059590]        ffff810071653d48 ffff810036776d70 ffffffff80192565 000001b600008001
> > [ 1007.059596]        ffff810037ff7080 ffff810036776cb0
> > [ 1007.059599] Call Trace:<ffffffff801c59d1>{sysfs_lookup+81} <ffffffff80192565>{do_lookup+245}
> > [ 1007.059614]        <ffffffff80193076>{__link_path_walk+2582} <ffffffff80193659>{link_path_walk+137}
> > [ 1007.059626]        <ffffffff801818b3>{get_unused_fd+227} <ffffffff8014a509>{remove_wait_queue+25}
> > [ 1007.059640]        <ffffffff80193c9d>{path_lookup+461} <ffffffff801951cc>{open_namei+172}
> > [ 1007.059649]        <ffffffff8025867a>{tty_ldisc_deref+122} <ffffffff8018261d>{filp_open+45}
> > [ 1007.059660]        <ffffffff80182712>{sys_open+82} <ffffffff8010dcf2>{system_call+126}
> > [ 1007.059673]
> > [ 1007.059678]
> > [ 1007.059678] Code: 0f b6 17 89 d0 2a 06 48 ff c6 84 c0 74 04 0f be c0 c3 48 ff
> > [ 1007.059687] RIP <ffffffff801fed50>{strcmp+0} RSP <ffff810071653cb0>
> > [ 1007.059693]
> > ---------------
> 
> I haven't had a chance to test the CVS version of bmcsensors yet on my
> IPMI machines (hence why its not released), but it basically differs
> in a patch submitted by someone to use the i2c_client addr instead of
> the now defunct id.

None of the kernel patches work for recent kernels. I'm not entirely sure 
since when exactly it began, but from a certain point those patches on 
the sf.net cased to work properly and began to crash like that.

Recently there were some fixes that needed to be done in order to make 
those patches on sf.net compile (changes in i2c structures), but though it 
compiled, it crashed.

So I thought I'll try the CVS bmcsensors-26. Those compiled without a
problem (that's probably the patch you are referring to and perhaps 
simillar that I was using), but it crashes the same way as well. So I 
think there may be some other problem introduced somewhere else in recent 
kernels. Tomorrow when I get a chance to safely reboot the server I may 
try to find when it was last working. From what I can briefly see from the 
past kernel logs, it seems to have been working with the kernel 2.6.12.2, 
then I tried the 2.6.13-rc4-git4 and it crashed allready. (Both had to be 
patched to compile and for both I used the same patch.) 

> What version of sensors are you using? It looks like its crashing

It's

	sensors version 2.8.8 with libsensors version 2.8.8

from the FC4's lm_sensors-2.8.8-5.x86_64.rpm. But I'm not so sure that 
sensors have anything to do with the crash, since it's the kernel that 
crashes, not the application. Kernel shouldn't crash no matter what the 
application does.

> while trying to read the sysfs attributes, try cating the sysfs
> entries the driver creates and see if you can see anything unusual.

I'll try that tomorrow as well, but since from the trace above it seem 
that the sensors were doing the sysfs inspection as well, I think it would 
also produce the crash.

Martin

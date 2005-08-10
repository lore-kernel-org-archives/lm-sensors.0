From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Wed, 10 Aug 2005 17:36:57 +0000
Subject: [lm-sensors] Re: General Protection Fault with bcmsensors
Message-Id: <2538186705081008364347d8e8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0508081716070.24140@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I tested it out with 2.6.13-rc1, but I'll try it out with 2.6.13-rc6
and get back to you.

Yani

On 8/10/05, Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
> On Mon, 8 Aug 2005, Yani Ioannou wrote:
> > On 8/8/05, Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
> > > None of the kernel patches work for recent kernels. I'm not entirely sure
> > > since when exactly it began, but from a certain point those patches on
> > > the sf.net cased to work properly and began to crash like that.
> > >
> > > Recently there were some fixes that needed to be done in order to make
> > > those patches on sf.net compile (changes in i2c structures), but though it
> > > compiled, it crashed.
> > >
> > > So I thought I'll try the CVS bmcsensors-26. Those compiled without a
> > > problem (that's probably the patch you are referring to and perhaps
> > > simillar that I was using), but it crashes the same way as well. So I
> > > think there may be some other problem introduced somewhere else in recent
> > > kernels. Tomorrow when I get a chance to safely reboot the server I may
> > > try to find when it was last working. From what I can briefly see from the
> > > past kernel logs, it seems to have been working with the kernel 2.6.12.2,
> > > then I tried the 2.6.13-rc4-git4 and it crashed allready. (Both had to be
> > > patched to compile and for both I used the same patch.)
> >
> > lol..indeed the problem is something that was introduced into the
> > kernel at 2.6.13-rc1 - a change by myself :-). The sysfs callbacks
> > need to be updated (you should have got warnings complaining of an
> > invalid function pointer when you compiled the module) for newer
> > kernels, I'll fix that now, and commit it to CVS so you can try it out
> > tomorrow, and I will try to test this out on my own machines tonight
> > too.
> 
> I've tested the current CVS again. It seems to be updated, and it no
> longer gives the compile warnings. But still it produces a crash. although
> the system isn't frozen, unless the IPMI watchdog is enabled, which runs
> out and reboots the comp. When I disable it, the system runs on. So,
> perhaps just the IPMI part crashes and the watchdog is no longer
> refreshed.
> 
> Anyway, the crash again occurs when you try to read the sensors
> values (either directly through sysfs or using sensors) now produces this:
> 
> ---------------
> Aug 10 16:58:39 neutron kernel: [  672.694754] Unable to handle kernel paging request at ffffffff89feb91c RIP:
> Aug 10 16:58:39 neutron kernel: [  672.694942] <ffffffff881e77cc>{:bmcsensors:show_sensor+44}
> Aug 10 16:58:39 neutron kernel: [  672.719842] PGD 103027 PUD 105027 PMD 0
> Aug 10 16:58:39 neutron kernel: [  672.719847] Oops: 0000 [1] SMP
> Aug 10 16:58:39 neutron kernel: [  672.719850] CPU 1
> Aug 10 16:58:39 neutron kernel: [  672.719852] Modules linked in: ipmi_si ipmi_devintf i2c_ipmi bmcsensors i2c_isa i2c_amd756 nfsd exportfs lockd nfs_acl parport_pc lp parport autofs4 sunrpc powernow_k8 freq_table binfmt_misc dm_mod video thermal processor hotkey fan container button battery ac ipv6 usbkbd usbhid ohci_hcd i2c_amd8111 i2c_core hw_random shpchp tg3 ide_cd cdrom sg usbcore ext3 jbd sd_mod
> Aug 10 16:58:39 neutron kernel: [  672.719868] Pid: 3364, comm: sensors Not tainted 2.6.13-rc6
> Aug 10 16:58:39 neutron kernel: [  672.719870] RIP: 0010:[<ffffffff881e77cc>] <ffffffff881e77cc>{:bmcsensors:show_sensor+44}
> Aug 10 16:58:39 neutron kernel: [  672.719878] RSP: 0018:ffff810076ff9ea8  EFLAGS: 00010216
> Aug 10 16:58:39 neutron kernel: [  672.719881] RAX: 0000000001dfff88 RBX: ffff810037c65240 RCX: fffffffffffffff4
> Aug 10 16:58:39 neutron kernel: [  672.719885] RDX: 00000000001ffff8 RSI: ffff810037c65240 RDI: ffffffff881eac00
> Aug 10 16:58:39 neutron kernel: [  672.719888] RBP: ffff810075f954a0 R08: ffff810040000000 R09: 0000000000000282
> Aug 10 16:58:39 neutron kernel: [  672.719891] R10: 0000000000000000 R11: ffffffff881e77a0 R12: ffff81007f3f0000
> Aug 10 16:58:39 neutron kernel: [  672.719895] R13: ffff810076ff9f50 R14: ffffffff80438440 R15: ffffffff881ead00
> Aug 10 16:58:39 neutron kernel: [  672.719899] FS:  00002aaaaaad9e40(0000) GS:ffffffff80541880(0000) knlGS:0000000061b80bb0
> Aug 10 16:58:39 neutron kernel: [  672.719902] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> Aug 10 16:58:39 neutron kernel: [  672.719905] CR2: ffffffff89feb91c CR3: 000000003b70d000 CR4: 00000000000006e0
> Aug 10 16:58:39 neutron kernel: [  672.719908] Process sensors (pid: 3364, threadinfo ffff810076ff8000, task ffff81003c54c070)
> Aug 10 16:58:39 neutron kernel: [  672.719910] Stack: ffffffff881ead00 ffff810075f95480 0000000000001000 ffffffff801c48af
> Aug 10 16:58:39 neutron kernel: [  672.719916]        0000000000000000 00002aaaadb48000 ffff810037c65240 ffff81007df09180
> Aug 10 16:58:39 neutron kernel: [  672.719921]        0000000000000000 0000000000001000
> Aug 10 16:58:39 neutron kernel: [  672.719923] Call Trace:<ffffffff801c48af>{sysfs_read_file+175} <ffffffff8018342b>{vfs_read+219}
> Aug 10 16:58:39 neutron kernel: [  672.719942]        <ffffffff80183bf3>{sys_read+83} <ffffffff8010dcf2>{system_call+126}
> Aug 10 16:58:40 neutron kernel: [  672.719952]
> Aug 10 16:58:40 neutron kernel: [  672.719957]
> Aug 10 16:58:40 neutron kernel: [  672.719958] Code: 0f b6 b8 94 b9 1e 88 48 8d b0 60 b9 1e 88 e8 11 fe ff ff 4c
> Aug 10 16:58:40 neutron kernel: [  672.719965] RIP <ffffffff881e77cc>{:bmcsensors:show_sensor+44} RSP <ffff810076ff9ea8>
> Aug 10 16:58:40 neutron kernel: [  672.719972] CR2: ffffffff89feb91c
> ---------------
> 
> Is it possible you forgot to update something? Or is it a different bug?
> 
> Martin
> 
>

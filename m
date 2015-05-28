From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 May 2015 16:06:54 +0000
Subject: Re: [lm-sensors] kernel lock warning for NCT6776D/F
Message-Id: <20150528160654.GA11645@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAL_Kpj2HmRZY5kuUtOkYorP9Xov9LE4jeNGGVnBxok7V+fS+6Q@mail.gmail.com>
In-Reply-To: <CAL_Kpj2HmRZY5kuUtOkYorP9Xov9LE4jeNGGVnBxok7V+fS+6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 28, 2015 at 05:33:32PM +0200, Alexey Orishko wrote:
> Hi guys,
> 
> I have a custom linux kernel 4.0.3 with debug info and I saw a couple
> of times a stack dump for  nct6775 module (compiled as module, loaded
> at boot time). I can also recall similar situation with 3.18.11.
> 
> I wonder if it is a known problem with nct6775 driver (or not a problem).
> 
It is not fatal, but it is a bug. Seen if DEBUG_LOCK_ALLOC is enabled.
Thanks for reporting!

Guenter

> Motherboard: ASRock E3C222D4U, BIOS P1.10 02/11/2015
> Chip (as in manual): Nuvoton NCT6776D
> Just in case, I use lm_sensors-3.3.5 in the linux build
> 
> Cut from kernel log:
> 
> [    8.957599] nct6775: Found NCT6776D/F or compatible chip at 0x2e:0x290
> [    8.958006] BUG: key ffff88040b2f0030 not in .data!
> [    8.958008] ------------[ cut here ]------------
> [    8.958790] WARNING: CPU: 0 PID: 186 at
> kernel/locking/lockdep.c:2988 lockdep_init_map+0x469/0x630()
> [    8.959586] DEBUG_LOCKS_WARN_ON(1)
> [    8.959599] Modules linked in: nct6775(+) hwmon_vid bonding
> [    8.961215] CPU: 0 PID: 186 Comm: modprobe Not tainted 4.0.3-asu0517 #1
> [    8.961908] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./E3C222D4U, BIOS P1.10 02/11/2015
> [    8.962662]  ffffffff81c5a896 ffff88040b35f698 ffffffff8182810d
> ffffffff810a1341
> [    8.963466]  ffff88040b35f6e8 ffff88040b35f6d8 ffffffff81058677
> ffff88040b2f0030
> [    8.964271]  ffff88040ac76728 ffff88040b2f0030 0000000000000000
> 0000000000001000
> [    8.965081] Call Trace:
> [    8.965865]  [<ffffffff8182810d>] dump_stack+0x4c/0x6e
> [    8.966650]  [<ffffffff810a1341>] ? console_unlock+0x1f1/0x4c0
> [    8.967431]  [<ffffffff81058677>] warn_slowpath_common+0x87/0xc0
> [    8.968209]  [<ffffffff810586f1>] warn_slowpath_fmt+0x41/0x50
> [    8.968977]  [<ffffffff810938b9>] lockdep_init_map+0x469/0x630
> [    8.969754]  [<ffffffff811d381d>] ? __kernfs_new_node+0x5d/0xd0
> [    8.970507]  [<ffffffff811d63a1>] __kernfs_create_file+0x71/0xd0
> [    8.971262]  [<ffffffff811d6d42>] sysfs_add_file_mode_ns+0x92/0x1d0
> [    8.972010]  [<ffffffff811d7970>] internal_create_group+0xd0/0x250
> [    8.972741]  [<ffffffff811d7c52>] sysfs_create_groups+0x42/0x90
> [    8.973476]  [<ffffffff81502c4d>] device_add+0x2ed/0x630
> [    8.974190]  [<ffffffff81502fa9>] device_register+0x19/0x20
> [    8.974911]  [<ffffffff81695c18>]
> hwmon_device_register_with_groups.part.6+0xb8/0x120
> [    8.975640]  [<ffffffff81695ce9>] hwmon_device_register_with_groups+0x69/0x70
> [    8.976361]  [<ffffffff81695d4f>]
> devm_hwmon_device_register_with_groups+0x5f/0xa0
> [    8.977091]  [<ffffffffa00333b1>] nct6775_probe+0x1c1/0x1ae6 [nct6775]
> [    8.977792]  [<ffffffff81507e0f>] platform_drv_probe+0x2f/0x90
> [    8.978482]  [<ffffffff81505d35>] driver_probe_device+0x125/0x3d0
> [    8.979170]  [<ffffffff81505fe0>] ? driver_probe_device+0x3d0/0x3d0
> [    8.979858]  [<ffffffff8150601b>] __device_attach+0x3b/0x40
> [    8.980509]  [<ffffffff81503cd3>] bus_for_each_drv+0x63/0xa0
> [    8.981171]  [<ffffffff81505b90>] device_attach+0x90/0xb0
> [    8.981847]  [<ffffffff81504f90>] bus_probe_device+0xb0/0xe0
> [    8.982519]  [<ffffffff81502d83>] device_add+0x423/0x630
> [    8.983181]  [<ffffffff8182fae6>] ? _raw_write_unlock+0x26/0x50
> [    8.983838]  [<ffffffff81507a51>] platform_device_add+0xd1/0x2d0
> [    8.984490]  [<ffffffffa003d31d>] sensors_nct6775_init+0x31d/0x3ae [nct6775]
> [    8.985147]  [<ffffffff81000308>] ? do_one_initcall+0xc8/0x210
> [    8.985780]  [<ffffffffa003d000>] ? 0xffffffffa003d000
> [    8.986409]  [<ffffffff81000314>] do_one_initcall+0xd4/0x210
> [    8.987040]  [<ffffffff8182469d>] ? do_init_module+0x23/0x1c1
> [    8.987665]  [<ffffffff811593c0>] ? kmem_cache_alloc_trace+0x130/0x1e0
> [    8.988289]  [<ffffffff818246d6>] do_init_module+0x5c/0x1c1
> [    8.988908]  [<ffffffff810cc922>] load_module+0x1a52/0x23c0
> [    8.989518]  [<ffffffff810c95b0>] ? store_uevent+0x40/0x40
> [    8.990100]  [<ffffffff810cd46e>] SyS_finit_module+0x7e/0xa0
> [    8.990690]  [<ffffffff818300f2>] system_call_fastpath+0x12/0x17
> [    8.991295] ---[ end trace 046e10fe12543e9a ]---
> 
> Regards,
> Alexey
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

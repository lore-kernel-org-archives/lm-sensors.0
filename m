From: Brice Figureau <brice+lm@daysofwonder.com>
Date: Thu, 17 Jul 2008 08:11:25 +0000
Subject: [lm-sensors] Ipmisensors bug report.
Message-Id: <1216282286.6474.19.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,


I have a bunch of Sun X2200 servers that I need to monitor (temperatures
and fan speeds), through SNMP (and thus net-snmp). Net-Snmp does only
support lm-sensors to access hardware sensors values. Those servers
don't have a "native" lm-sensor chip, but expose some values through
IPMI.

I tried the latest ipmisensors version I could find
(http://bmcsensors-26.sourceforge.net/ipmisensors/ipmisensors-20070630-1330=
.diff), which compiled with a few api changes on 2.6.25.

Unfortunately there are some issues for this hwmon:

* Important: when unloading ipmisensors it doesn't remove its sysfs
files, so that you can get a BUG() if you look at its sysfs files, or
you can't reload it. Note that I'm not really familiar with sysfs or
kernel development, maybe removing sysfs on module unloading is
something that was added after 2.6.17.
Here is the oops trace:
sysfs: duplicate filename 'name' can not be created
------------[ cut here ]------------
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one+0x3f/0x93()
Modules linked in: ipmisensors ipmi_si ipmi_msghandler i2c_dev
sha1_generic drbd cn ipv6 video output ac battery nf_conntrack_ftp
nf_conntrack_irc xt_tcpudp ipt_LOG xt_limit xt_state nf_conntrack_ipv4
nf_conntrack iptable_filter ip_tables x_tables bonding sg loop pcspkr
i2c_nforce2 button shpchp i2c_core pci_hotplug evdev ext3 jbd mbcache
dm_mirror dm_snapshot dm_mod raid1 md_mod sd_mod amd74xx ide_pci_generic
ide_core usbhid hid ff_memless mptsas mptscsih mptbase sata_nv
ata_generic scsi_transport_sas libata scsi_mod forcedeth tg3 ehci_hcd
ohci_hcd dock thermal processor fan [last unloaded: k8temp]
Pid: 22794, comm: ipmisensors_wor Not tainted 2.6.25-2-amd64 #1

Call Trace:
 [<ffffffff80234ce5>] warn_on_slowpath+0x51/0x63
 [<ffffffff80235a40>] printk+0x4e/0x56
 [<ffffffff802abb65>] find_inode+0x28/0x6d
 [<ffffffff802e0320>] sysfs_ilookup_test+0x0/0xf
 [<ffffffff802abc94>] ifind+0x44/0x88
 [<ffffffff802e051c>] sysfs_find_dirent+0x1b/0x2f
 [<ffffffff802e056f>] sysfs_add_one+0x3f/0x93
 [<ffffffff802e0083>] sysfs_add_file+0x50/0x81
 [<ffffffff88318b27>] :ipmisensors:ipmisensors_build_sysfs+0x804/0x8ed
 [<ffffffff88318323>] :ipmisensors:ipmisensors_build_sysfs+0x0/0x8ed
 [<ffffffff80243938>] run_workqueue+0x82/0x111
 [<ffffffff8024423e>] worker_thread+0xd5/0xe0
 [<ffffffff80246a44>] autoremove_wake_function+0x0/0x2e
 [<ffffffff80244169>] worker_thread+0x0/0xe0
 [<ffffffff8024691b>] kthread+0x47/0x74
 [<ffffffff8023036d>] schedule_tail+0x27/0x5c
 [<ffffffff8020ce08>] child_rip+0xa/0x12
 [<ffffffff802468d4>] kthread+0x0/0x74
 [<ffffffff8020cdfe>] child_rip+0x0/0x12

---[ end trace 092ee9a6ca0fc199 ]---
ipmisensors: Failed to create sysfs entry 'name'<0>general protection
fault: 0000 [1] SMP
CPU 1
Modules linked in: ipmisensors ipmi_si ipmi_msghandler i2c_dev
sha1_generic drbd cn ipv6 video output ac battery nf_conntrack_ftp
nf_conntrack_irc xt_tcpudp ipt_LOG xt_limit xt_state nf_conntrack_ipv4
nf_conntrack iptable_filter ip_tables x_tables bonding sg loop pcspkr
i2c_nforce2 button shpchp i2c_core pci_hotplug evdev ext3 jbd mbcache
dm_mirror dm_snapshot dm_mod raid1 md_mod sd_mod amd74xx ide_pci_generic
ide_core usbhid hid ff_memless mptsas mptscsih mptbase sata_nv
ata_generic scsi_transport_sas libata scsi_mod forcedeth tg3 ehci_hcd
ohci_hcd dock thermal processor fan [last unloaded: k8temp]
Pid: 22795, comm: sensors Not tainted 2.6.25-2-amd64 #1
RIP: 0010:[<ffffffff8037bfee>]  [<ffffffff8037bfee>] dev_attr_show
+0x20/0x44
RSP: 0018:ffff8102224f3ea8  EFLAGS: 00010282
RAX: 776f645f7777771c RBX: ffff810320511328 RCX: 0000000000000000
RDX: ffff810221d44000 RSI: ffff810320511328 RDI: ffff8103231f2410
RBP: fffffffffffffffb R08: ffff81022306ec74 R09: 000000000012076f
R10: 0000000000000000 R11: 0000000000000002 R12: ffff81009d4cdc80
R13: ffffffff80510630 R14: ffff8100a2855d60 R15: ffff8102224f3f50
FS:  00007fa20fa4c6e0(0000) GS:ffff81022306eb40(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fff17a58c38 CR3: 00000002221f7000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process sensors (pid: 22795, threadinfo ffff8102224f2000, task
ffff8102224b3240)
Stack:  ffff8102224f3f50 ffff8103231f2500 ffff8100a2855d40
ffffffff802dfe5a
 00007fa20fa55000 0000000000001000 00007fa20fa55000 ffff810221dfe980
 0000000000001000 00007fa20fa55000 ffff8102224f3f50 00000000023ef0c0
Call Trace:
 [<ffffffff802dfe5a>] ? sysfs_read_file+0xa2/0x129
 [<ffffffff8029ad10>] ? vfs_read+0xaa/0x152
 [<ffffffff8029b0f1>] ? sys_read+0x45/0x6e
 [<ffffffff8020bd9a>] ? system_call_after_swapgs+0x8a/0x8f


Code: 5c e9 7e 52 f6 ff 5b 5d 41 5c c3 55 48 c7 c5 fb ff ff ff 53 48 89
f3 48 83 ec 08 48 8b 46 18 48 85 c0 74 24 48 81 ef f0 00 00 00 <ff> d0
48 3d ff 0f 00 00 48 89 c5 7e 10 48 8b 73 18 48 c7 c7 58
RIP  [<ffffffff8037bfee>] dev_attr_show+0x20/0x44
 RSP <ffff8102224f3ea8>
---[ end trace 092ee9a6ca0fc199 ]---

* Temperatures are divided by 10, except the first one, compared to the
right temperature. That's something that is easy to correct with
sensors.conf though.

* More important, the fan speeds are incorrectly reported. The first fan
is always at 0, and the last one is missing (a kind of
zero-based/one-based mismatch somewhere I guess).

Here is the sensors report:
bmc-isa-14db
Adapter: ISA adapter
Vcc 3.3V STB:  +1.42 V  (min =3D  +2.80 V, max =3D  +3.79 V)
Vcc 5V:        +4.40 V  (min =3D  +4.40 V, max =3D  +5.59 V)
Vcc 3.3V:      +3.66 V  (min =3D  +2.80 V, max =3D  +3.79 V)
DDRP1 1.8V:    +1.62 V  (min =3D  +1.58 V, max =3D  +2.02 V)
DDRP0 1.8V:    +1.82 V  (min =3D  +1.58 V, max =3D  +2.02 V)
Vcc 12V:      +12.08 V  (min =3D +10.55 V, max =3D +13.41 V)
Axial Fan 1:     0 RPM  (min =3D 2272 RPM)
Axial Fan 0:  9656 RPM  (min =3D 2272 RPM)
Blower Fan 1: 5488 RPM  (min =3D  784 RPM)
Blower Fan 0: 3488 RPM  (min =3D  784 RPM)
Ambient Temp1: +23.1=B0C  (low  =3D  +0.0=B0C, high =3D  +7.5=B0C)
Ambient Temp0:  +4.3=B0C  (low  =3D  +0.0=B0C, high =3D  +7.5=B0C)
CPU 1 Temp:     +3.4=B0C  (low  =3D  +0.0=B0C, high =3D  +9.5=B0C)
CPU 0 Temp:     +4.0=B0C  (low  =3D  +0.0=B0C, high =3D  +9.5=B0C)

Here is the ipmitool report to compare:
CPU 0 Temp       | 40.000     | degrees C  | ok    | na        | na        =
| na        | 93.000    | 95.000    | na
CPU 1 Temp       | 44.000     | degrees C  | ok    | na        | na        =
| na        | 93.000    | 95.000    | na
Ambient Temp0    | 34.000     | degrees C  | ok    | na        | na        =
| na        | 70.000    | 75.000    | na
Ambient Temp1    | 43.000     | degrees C  | ok    | na        | na        =
| na        | 70.000    | 75.000    | na
Vcc 12V          | 12.243     | Volts      | ok    | na        | 10.547    =
| 10.759    | 13.197    | 13.409    | na
DDRP0 1.8V       | 1.816      | Volts      | ok    | na        | 1.584     =
| 1.616     | 1.976     | 2.016     | na
DDRP1 1.8V       | 1.824      | Volts      | ok    | na        | 1.584     =
| 1.616     | 1.976     | 2.016     | na
Vcc 3.3V         | 3.248      | Volts      | ok    | na        | 2.800     =
| 2.960     | 3.616     | 3.792     | na
Vcc 5V           | 5.060      | Volts      | ok    | na        | 4.400     =
| 4.488     | 5.500     | 5.588     | na
Vcc 3.3V STB     | 3.168      | Volts      | ok    | na        | 2.800     =
| 2.960     | 3.616     | 3.792     | na
Blower Fan 0     | 3488.800   | RPM        | ok    | na        | 784.000   =
| na        | na        | 8976.800  | na
Blower Fan 1     | 3567.200   | RPM        | ok    | na        | 784.000   =
| na        | na        | 8976.800  | na
Axial Fan 0      | 9656.000   | RPM        | ok    | na        | 2272.000  =
| na        | na        | 15975.000 | na
Axial Fan 1      | 9656.000   | RPM        | ok    | na        | 2272.000  =
| na        | na        | 15975.000 | na

I also have all the output from the module available on request.

Is there a new ipmisensors version somewhere? The webpage mentions a git re=
pository, but I couldn't find it.

Many thanks,
--=20
Brice Figureau <brice+lm@daysofwonder.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

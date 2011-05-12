From: Jeff Rickman <jrickman@myamigos.us>
Date: Thu, 12 May 2011 20:37:51 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DCC451F.5010900@myamigos.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070705050900010200010704"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070705050900010200010704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/2011 8:38 AM, Jean Delvare wrote:
> Hi Jeff, Luca,
>
> On Thu, 12 May 2011 15:02:08 +0200, Luca Tettamanti wrote:
>> On Wed, May 11, 2011 at 7:59 PM, Jeff Rickman<jrickman@myamigos.us>  wrote:
>>> [test results]
>>> load new i8k module
>>>
>>> modprobe -v i8k
>>> insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
>>> FATAL: Error inserting i8k
>>> (/lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko): No such
>>> device
>>>
>>> from /var/log/messages
>>> May 11 12:39:11 XX kernel: [  263.320306] i8k: unable to get SMM Dell
>>> signature
>>>
>>> modprobe -v i8k force
>>> insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
>>> force
>>>
>>> from /var/log/messages
>>> May 11 12:39:11 XX kernel: [  263.320306] i8k: unable to get SMM Dell
>>> signature
>>> May 11 12:40:52 XX kernel: [  365.019189] i8k: unable to get SMM Dell
>>> signature
>>> May 11 12:40:52 XX kernel: [  365.020148] i8k: unable to get SMM BIOS
>>> version
>>> May 11 12:40:52 XX kernel: [  365.027736] Dell laptop SMM driver v1.14
>>> 21/02/2005 Massimo Dal Zotto (dz@debian.org)
>
> This is not a fatal error, you may still see interesting things
> in /proc/i8k or the output of "sensors". Although Harry's report makes
> it unlikely...
>
Jean, these are very interesting questions. I got a crash message on the 
Console and found a lengthy (~70 lines) dump in Syslog. Like last time, 
assembly coding skills will be required to figure it out. Sensors output 
tells me I have to run "sensors-detect". Output attached.
>
>>> I will guess that this detection issue is not due to the changes made by
>>> Jean and Luca. This module may be at a dead end for my hardware.
>>
>> Hum, maybe my change is not correct. It should be possible to verify
>> to functionality of the patch on Harry's machine
>
> Harry already reported:
>
> "This new i8k crashes on my machine, the old one does not."
>
> This suggests that your patch is indeed not correct, however it looks
> good to me so I don't know what else to suggest.
>


--------------070705050900010200010704
Content-Type: text/plain;
 name="Dell_Sensors_Testing_5.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Dell_Sensors_Testing_5.txt"

[root@XX char]# cat /proc/i8k
Killed

Message from syslogd@XX at May 12 15:28:53 ...
 kernel:[96086.545317] last sysfs file: /sys/devices/system/cpu/cpu3/cach=
e/index1/shared_cpu_map
[root@XX char]#=20
Message from syslogd@XX at May 12 15:28:53 ...
 kernel:[96086.545317] Stack:

Message from syslogd@XX at May 12 15:28:53 ...
 kernel:[96086.545317] Call Trace:

Message from syslogd@XX at May 12 15:28:53 ...
 kernel:[96086.545317] Code: 5d 41 5e 41 5f c9 c3 55 48 89 e5 53 48 83 ec=
 58 0f 1f 44 00 00 48 89 fb 48 89 55 d0 48 89 4d d8 4c 89 45 e0 4c 89 4d =
e8 48 89 f2 <48> 8b 7f 18 48 3b 7b 08 73 3e 48 8b 73 08 48 8d 45 10 48 8d=
 4d=20

Message from syslogd@XX at May 12 15:28:53 ...
 kernel:[96086.545317] CR2: 0000000000000018


from /var/log/messages=20
May 12 15:28:08 XX kernel: [96041.748222] ------------[ cut here ]-------=
-----
May 12 15:28:08 XX kernel: [96041.755366] i8k: unable to get SMM Dell sig=
nature
May 12 15:28:08 XX kernel: [96041.756179] i8k: unable to get SMM BIOS ver=
sion
May 12 15:28:08 XX kernel: [96041.748222] WARNING: at kernel/sched_clock.=
c:207 sched_clock_tick+0x3d/0x78()
May 12 15:28:08 XX kernel: [96041.748222] Hardware name: Precision WorkSt=
ation 670   =20
May 12 15:28:08 XX kernel: [96041.748222] Modules linked in: i8k(+) act_p=
olice cls_flow cls_fw cls_u32 sch_tbf sch_prio sch_htb sch_hfsc sch_ingre=
ss sch_sfq xt_time xt_connlimit
May 12 15:28:08 XX kernel: [96041.748222]  xt_realm iptable_raw
May 12 15:28:08 XX kernel: [96041.759086] Dell laptop SMM driver v1.14 21=
/02/2005 Massimo Dal Zotto (dz@debian.org)
May 12 15:28:08 XX kernel: [96041.748222]  xt_comment xt_recent xt_policy=
 ipt_ULOG ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE ipt_ECN ipt_ecn ipt_CLUS=
TERIP ipt_ah ipt_addrtype nf_nat_tftp nf_nat_snmp_basic nf_nat_sip nf_nat=
_pptp nf_nat_proto_gre nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts=
_kmp nf_conntrack_amanda nf_conntrack_sane nf_conntrack_tftp nf_conntrack=
_sip nf_conntrack_proto_sctp nf_conntrack_pptp nf_conntrack_proto_gre nf_=
conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_irc nf_conntrack_h=
323 nf_conntrack_ftp xt_TPROXY nf_tproxy_core xt_tcpmss xt_pkttype xt_phy=
sdev xt_owner xt_NFQUEUE xt_NFLOG nfnetlink_log xt_multiport xt_mark xt_m=
ac xt_limit xt_length xt_iprange xt_helper xt_hashlimit xt_DSCP xt_dscp x=
t_dccp xt_connmark xt_CLASSIFY ipt_LOG iptable_nat nf_nat iptable_mangle =
nfnetlink p4_clockmod freq_table speedstep_lib e752x_edac edac_core iTCO_=
wdt i2c_i801 iTCO_vendor_support e1000 shpchp dcdbas serio_raw microcode =
firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_=
a
May 12 15:28:08 XX kernel: lgo_bit video output i2c_core [last unloaded: =
i2c_dev]
May 12 15:28:08 XX kernel: [96041.748222] Pid: 0, comm: swapper Not taint=
ed 2.6.35.12-90.fc14.x86_64 #1
May 12 15:28:08 XX kernel: [96041.748222] Call Trace:
May 12 15:28:08 XX kernel: [96041.748222]  <IRQ>  [<ffffffff8104dce1>] wa=
rn_slowpath_common+0x85/0x9d
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff8104dd13>] warn_slow=
path_null+0x1a/0x1c
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff8106b9e6>] sched_clo=
ck_tick+0x3d/0x78
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff8106ba33>] sched_clo=
ck_idle_wakeup_event+0x12/0x1b
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff8107315d>] tick_nohz=
_stop_idle+0x3e/0x43
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff81073785>] tick_chec=
k_idle+0x57/0xa8
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff8100abdc>] ? call_so=
ftirq+0x1c/0x30
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff81053ee1>] irq_enter=
+0x49/0x74
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff810218d1>] smp_call_=
function_single_interrupt+0x13/0x2a
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff8100a833>] call_func=
tion_single_interrupt+0x13/0x20
May 12 15:28:08 XX kernel: [96041.748222]  <EOI>  [<ffffffff810111b8>] ? =
mwait_idle+0x72/0x7b
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff810111ab>] ? mwait_i=
dle+0x65/0x7b
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff81008325>] cpu_idle+=
0xaa/0xcc
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff81452736>] rest_init=
+0x8a/0x8c
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff81ba1c49>] start_ker=
nel+0x40b/0x416
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff81ba12c6>] x86_64_st=
art_reservations+0xb1/0xb5
May 12 15:28:08 XX kernel: [96041.748222]  [<ffffffff81ba13c2>] x86_64_st=
art_kernel+0xf8/0x107
May 12 15:28:08 XX kernel: [96041.748222] ---[ end trace 33dd116366d42f77=
 ]---
May 12 15:28:53 XX kernel: [96086.544428] BUG: unable to handle kernel NU=
LL pointer dereference at 0000000000000018
May 12 15:28:53 XX kernel: [96086.544551] IP: [<ffffffff8112fd09>] seq_pr=
intf+0x24/0x7e
May 12 15:28:53 XX kernel: [96086.545317] PGD 7e443067 PUD 7e3fa067 PMD 0=
=20
May 12 15:28:53 XX kernel: [96086.545317] Oops: 0000 [#1] SMP=20
May 12 15:28:53 XX kernel: [96086.545317] last sysfs file: /sys/devices/s=
ystem/cpu/cpu3/cache/index1/shared_cpu_map
May 12 15:28:53 XX kernel: [96086.545317] CPU 3=20
May 12 15:28:53 XX kernel: [96086.545317] Modules linked in: i8k act_poli=
ce cls_flow cls_fw cls_u32 sch_tbf sch_prio sch_htb sch_hfsc sch_ingress =
sch_sfq xt_time xt_connlimit xt_realm iptable_raw xt_comment xt_recent xt=
_policy ipt_ULOG ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE ipt_ECN ipt_ecn i=
pt_CLUSTERIP ipt_ah ipt_addrtype nf_nat_tftp nf_nat_snmp_basic nf_nat_sip=
 nf_nat_pptp nf_nat_proto_gre nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_am=
anda ts_kmp nf_conntrack_amanda nf_conntrack_sane nf_conntrack_tftp nf_co=
nntrack_sip nf_conntrack_proto_sctp nf_conntrack_pptp nf_conntrack_proto_=
gre nf_conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_irc nf_conn=
track_h323 nf_conntrack_ftp xt_TPROXY nf_tproxy_core xt_tcpmss xt_pkttype=
 xt_physdev xt_owner xt_NFQUEUE xt_NFLOG nfnetlink_log xt_multiport xt_ma=
rk xt_mac xt_limit xt_length xt_iprange xt_helper xt_hashlimit xt_DSCP xt=
_dscp xt_dccp xt_connmark xt_CLASSIFY ipt_LOG iptable_nat nf_nat iptable_=
mangle nfnetlink p4_clockmod freq_table speedstep_lib e752x_edac edac_cor=
e
May 12 15:28:53 XX kernel: iTCO_wdt i2c_i801 iTCO_vendor_support e1000 sh=
pchp dcdbas serio_raw microcode firewire_ohci firewire_core crc_itu_t nou=
veau ttm drm_kms_helper drm i2c_algo_bit video output i2c_core [last unlo=
aded: i2c_dev]
May 12 15:28:53 XX kernel: [96086.545317]=20
May 12 15:28:53 XX kernel: [96086.545317] Pid: 27584, comm: cat Tainted: =
G        W   2.6.35.12-90.fc14.x86_64 #1 0U7565/Precision WorkStation 670=
   =20
May 12 15:28:53 XX kernel: [96086.545317] RIP: 0010:[<ffffffff8112fd09>] =
 [<ffffffff8112fd09>] seq_printf+0x24/0x7e
May 12 15:28:53 XX kernel: [96086.545317] RSP: 0018:ffff88007ea21d58  EFL=
AGS: 00010292
May 12 15:28:53 XX kernel: [96086.545317] RAX: 0000000000000000 RBX: 0000=
000000000000 RCX: ffffffffa0012274
May 12 15:28:53 XX kernel: [96086.545317] RDX: ffffffffa00119e6 RSI: ffff=
ffffa00119e6 RDI: 0000000000000000
May 12 15:28:53 XX kernel: [96086.545317] RBP: ffff88007ea21db8 R08: ffff=
ffff81e4406c R09: 00000000ffffffea
May 12 15:28:53 XX kernel: [96086.545317] R10: 0000000000000001 R11: 0000=
000000000246 R12: 00000000ffffffff
May 12 15:28:53 XX kernel: [96086.545317] R13: 00000000ffffffea R14: 0000=
0000ffffffea R15: 00000000ffffffea
May 12 15:28:53 XX kernel: [96086.545317] FS:  00007fa138fd3720(0000) GS:=
ffff8800020c0000(0000) knlGS:0000000000000000
May 12 15:28:53 XX kernel: [96086.545317] CS:  0010 DS: 0000 ES: 0000 CR0=
: 0000000080050033
May 12 15:28:53 XX kernel: [96086.545317] CR2: 0000000000000018 CR3: 0000=
00007d2b4000 CR4: 00000000000006e0
May 12 15:28:53 XX kernel: [96086.545317] DR0: 0000000000000000 DR1: 0000=
000000000000 DR2: 0000000000000000
May 12 15:28:53 XX kernel: [96086.545317] DR3: 0000000000000000 DR6: 0000=
0000ffff0ff0 DR7: 0000000000000400
May 12 15:28:53 XX kernel: [96086.545317] Process cat (pid: 27584, thread=
info ffff88007ea20000, task ffff88007d80ae80)
May 12 15:28:53 XX kernel: [96086.545317] Stack:
May 12 15:28:53 XX kernel: [96086.545317]  0000000000000246 ffff88007ea21=
d78 0000000000000018 0000000000000025
May 12 15:28:53 XX kernel: [96086.545317] <0> 0000000000000246 0000000000=
000000 ffffffffa00119e2 ffffffffa0012274
May 12 15:28:53 XX kernel: [96086.545317] <0> ffffffff81e4406c 00000000ff=
ffffea ffff88007ea21db8 0000000000000000
May 12 15:28:53 XX kernel: [96086.545317] Call Trace:
May 12 15:28:53 XX kernel: [96086.545317]  [<ffffffffa0011580>] i8k_proc_=
show+0xbe/0xcd [i8k]
May 12 15:28:53 XX kernel: [96086.545317]  [<ffffffff8112fff2>] seq_read+=
0x18d/0x36b
May 12 15:28:53 XX kernel: [96086.545317]  [<ffffffff81161330>] proc_reg_=
read+0x73/0x8c
May 12 15:28:53 XX kernel: [96086.545317]  [<ffffffff81117a45>] vfs_read+=
0xa9/0xfd
May 12 15:28:53 XX kernel: [96086.545317]  [<ffffffff81117ae3>] sys_read+=
0x4a/0x6e
May 12 15:28:53 XX kernel: [96086.545317]  [<ffffffff81009cf2>] system_ca=
ll_fastpath+0x16/0x1b
May 12 15:28:53 XX kernel: [96086.545317] Code: 5d 41 5e 41 5f c9 c3 55 4=
8 89 e5 53 48 83 ec 58 0f 1f 44 00 00 48 89 fb 48 89 55 d0 48 89 4d d8 4c=
 89 45 e0 4c 89 4d e8 48 89 f2 <48> 8b 7f 18 48 3b 7b 08 73 3e 48 8b 73 0=
8 48 8d 45 10 48 8d 4d=20
May 12 15:28:53 XX kernel: [96086.545317] RIP  [<ffffffff8112fd09>] seq_p=
rintf+0x24/0x7e
May 12 15:28:53 XX kernel: [96086.545317]  RSP <ffff88007ea21d58>
May 12 15:28:53 XX kernel: [96086.545317] CR2: 0000000000000018
May 12 15:28:53 XX kernel: [96086.545317] [drm] nouveau 0000:05:00.0: Set=
ting dpms mode 0 on vga encoder (output 0)
May 12 15:28:53 XX kernel: [96086.627526] ---[ end trace 33dd116366d42f78=
 ]---

--------------070705050900010200010704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070705050900010200010704--

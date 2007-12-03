From: Dan Borlovan <danb@level7.ro>
Date: Mon, 03 Dec 2007 14:11:06 +0000
Subject: [lm-sensors] Oops in ipmisensors
Message-Id: <47540E7A.5070302@level7.ro>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Intel S5000PAL motherboard, kernel 2.6.23.9 with=20
ipmisensors-20070630-1330.diff

Oops occured after a first successful modprobe and rmmod of ipmisensors

The oops seems to be here in the strcmp function in the kernel=20
(fs/sysfs/dir.c)

struct sysfs_dirent *sysfs_find_dirent(struct sysfs_dirent *parent_sd,
                                        const unsigned char *name)
{
         struct sysfs_dirent *sd;

         for (sd =3D parent_sd->s_children; sd; sd =3D sd->s_sibling)
                 if (sysfs_type(sd) && !strcmp(sd->s_name, name))
                         return sd;
         return NULL;
}

The actual oops

ipmisensors - IPMI BMC sensors interface
BUG: unable to handle kernel paging request at virtual address f8bf02ba
  printing eip:
b01bdcd7
*pde =3D 2fff1067
*pte =3D 00000000
Oops: 0000 [#1]
SMP
Modules linked in: ipmisensors i2c_i801 ipmi_si ipmi_msghandler i2c_dev=20
ac battery ipv6 sch_esfq cls_u32 xt_tcpudp xt_state ipt_LOG xt_limit=20
iptable_nat nf_nat iptable_filter sch_htb ipt_IMQ nf_conntrack_ipv4
xt_layer7 xt_MARK iptable_mangle ip_tables x_tables imq ip_gre 8021q=20
dm_snapshot dm_mirror dm_mod nf_conntrack_ftp nf_conntrack nfnetlink=20
hwmon_vid e100 mii skge ide_disk ide_cd cdrom mousedev tsdev button iTC
O_wdt iTCO_vendor_support i5000_edac psmouse i2c_core serio_raw=20
edac_core 8250_pnp evdev pcspkr rtc ext3 jbd raid1 md_mod ide_generic=20
sd_mod ata_generic ata_piix ahci uhci_hcd ehci_hcd piix libata generic scsi
_mod ide_core usbcore thermal processor fan e1000
CPU:    1
EIP:    0060:[<b01bdcd7>]    Not tainted VLI
EFLAGS: 00010202   (2.6.23.9-0-686-imq-l7 #2)
EIP is at strcmp+0x6/0x19
eax: f8bf02ba   ebx: bb7579c4   ecx: 00000000   edx: f31b8be0
esi: f8bf02ba   edi: f31b8be0   ebp: f31b8be0   esp: e6379d6c
ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
Process modprobe (pid: 27317, ti=E6378000 task=F7f21570 task.ti=E6378000)
Stack: f31b8be0 bc9943ac b019d13e e6379d94 bc9949c4 b019e53f bc994a2c=20
df860400
        bc994b64 00000246 bc9943ac ee005194 00000000 00000000 00000000=20
edd2ba40
        df860400 edd2ba48 b0216f92 edd2ba48 b02d0aa6 edd2baa8 ffffffff=20
00000000
Call Trace:
  [<b019d13e>] sysfs_find_dirent+0x24/0x2d
  [<b019e53f>] sysfs_create_link+0x89/0x146
  [<b0216f92>] class_device_add+0x2e0/0x39e
  [<b01b9ca8>] kobject_init+0x2f/0x3f
  [<b02170dd>] class_device_create+0x7d/0x9e
  [<b0221a91>] hwmon_device_register+0x80/0xbb
  [<f8bd52db>] ipmisensors_new_smi+0xca/0x20b [ipmisensors]
  [<b015e7b2>] enable_cpucache+0x29/0xa8
  [<f8bff39f>] ipmi_smi_watcher_register+0xf2/0x1a1 [ipmi_msghandler]
  [<f8ac6072>] ipmisensors_init+0x72/0xc4 [ipmisensors]
  [<b013ea83>] sys_init_module+0x10a/0x1806
  [<b015dc30>] kmem_cache_destroy+0x0/0xc2
  [<b01080ff>] sys_mmap2+0xb5/0xb7
  [<b0103e62>] sysenter_past_esp+0x5f/0x85
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DCode: d2 89 c7 89 d0 b9 ff ff ff ff f2 a=
e 4f 89 e9 49 78 06 ac aa 84 c0=20
75 f7 31 c0 aa 89 d8 83 c4 0c 5b 5e 5f 5d c3 57 56 89 c6 89 d7 <ac> ae=20
75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 5e 5f c3 57 56
EIP: [<b01bdcd7>] strcmp+0x6/0x19 SS:ESP 0068:e6379d6c


--=20
Dan Borlovan
Level 7 Software

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

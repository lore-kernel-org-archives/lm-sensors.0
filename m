From: Mario.Schubert@physik.uni-muenchen.de (Mario Schubert)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Ticket # 1373 - i2c-amd756.o: Busy wait timeout
Message-Id: <200308251056.24336.Mario.Schubert@physik.uni-muenchen.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello MDS,

thanks for your hints, I will try this out. But this will need time, becaus=
e,=20
if I reboot our cluster to often, the users go crazy. ;-|

I have attached the output of ksymoops.

[root@node20 root]# find / -name "libsensors*"
/usr/local/lib/libsensors.a
/usr/local/lib/libsensors.so.1.3.0
/usr/local/lib/libsensors.so.1
/usr/local/lib/libsensors.so
/usr/local/man/man3/libsensors.3

I hope this helps you a little bit. My last private kernel hacking was in t=
he=20
2.0 kernel. Now I am more in userland. Thank you for your work and effort.

Ciao,
    Mario
---------------------------------------------
Maier-Leibnitz-Laboratorium/Beschleunigerlabor der LMU und TU M?nchen
Dipl. Phys. Mario Schubert
Email: mario.schubert@physik.uni-muenchen.de
Phone: (+49 89)289 14283
FAX:   (+49 89)289 14280
Am Coulombwall 6, D-85748 Garching, Germany
-------------- next part --------------
[root@node20 root]# ksymoops < /var/log/messages
ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

sh: /usr/bin/nm: No such file or directory
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in /lib/modules/2.4.18/kernel/drivers/sen=
sors/w83781d.o
sh: /usr/bin/nm: No such file or directory
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in /lib/modules/2.4.18/kernel/drivers/i2c=
/i2c-proc.o
sh: /usr/bin/nm: No such file or directory
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in /lib/modules/2.4.18/kernel/drivers/i2c=
/i2c-amd756.o
sh: /usr/bin/nm: No such file or directory
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in /lib/modules/2.4.18/kernel/drivers/i2c=
/i2c-core.o
Error (regular_file): read_system_map stat /boot/System.map-2.4.18 failed
ksymoops: No such file or directory
Warning (compare_maps): i2c-proc symbol i2c_deregister_entry not found in /=
lib/modules/2.4.18/kernel/drivers/i2c/i2c-proc.o.  Ignoring /lib/modules/2.=
4.18/kernel/drivers/i2c/i2c-proc.o entry
Warning (compare_maps): i2c-proc symbol i2c_detect not found in /lib/module=
s/2.4.18/kernel/drivers/i2c/i2c-proc.o.  Ignoring /lib/modules/2.4.18/kerne=
l/drivers/i2c/i2c-proc.o entry
Warning (compare_maps): i2c-proc symbol i2c_proc_real not found in /lib/mod=
ules/2.4.18/kernel/drivers/i2c/i2c-proc.o.  Ignoring /lib/modules/2.4.18/ke=
rnel/drivers/i2c/i2c-proc.o entry
Warning (compare_maps): i2c-proc symbol i2c_register_entry not found in /li=
b/modules/2.4.18/kernel/drivers/i2c/i2c-proc.o.  Ignoring /lib/modules/2.4.=
18/kernel/drivers/i2c/i2c-proc.o entry
Warning (compare_maps): i2c-proc symbol i2c_sysctl_real not found in /lib/m=
odules/2.4.18/kernel/drivers/i2c/i2c-proc.o.  Ignoring /lib/modules/2.4.18/=
kernel/drivers/i2c/i2c-proc.o entry
Warning (compare_maps): i2c-core symbol i2c_adapter_id not found in /lib/mo=
dules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/k=
ernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_add_adapter not found in /lib/m=
odules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/=
kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_add_driver not found in /lib/mo=
dules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/k=
ernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_attach_client not found in /lib=
/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.1=
8/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_check_addr not found in /lib/mo=
dules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/k=
ernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_check_functionality not found i=
n /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules=
/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_control not found in /lib/modul=
es/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/kern=
el/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_dec_use_client not found in /li=
b/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.=
18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_del_adapter not found in /lib/m=
odules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/=
kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_del_driver not found in /lib/mo=
dules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/k=
ernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_detach_client not found in /lib=
/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.1=
8/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_get_client not found in /lib/mo=
dules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/k=
ernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_get_functionality not found in =
/lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2=
.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_inc_use_client not found in /li=
b/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.=
18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_master_recv not found in /lib/m=
odules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/=
kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_master_send not found in /lib/m=
odules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/=
kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_probe not found in /lib/modules=
/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/kernel=
/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_release_client not found in /li=
b/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.=
18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_process_call not found in=
 /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/=
2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_read_block_data not found=
 in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modul=
es/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_read_byte not found in /l=
ib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4=
.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_read_byte_data not found =
in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/module=
s/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_read_i2c_block_data not f=
ound in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/m=
odules/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_read_word_data not found =
in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/module=
s/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_write_block_data not foun=
d in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modu=
les/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_write_byte not found in /=
lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.=
4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_write_byte_data not found=
 in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modul=
es/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_write_i2c_block_data not =
found in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/=
modules/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_write_quick not found in =
/lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2=
.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_write_word_data not found=
 in /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modul=
es/2.4.18/kernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_smbus_xfer not found in /lib/mo=
dules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/k=
ernel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_transfer not found in /lib/modu=
les/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/ker=
nel/drivers/i2c/i2c-core.o entry
Warning (compare_maps): i2c-core symbol i2c_use_client not found in /lib/mo=
dules/2.4.18/kernel/drivers/i2c/i2c-core.o.  Ignoring /lib/modules/2.4.18/k=
ernel/drivers/i2c/i2c-core.o entry
Apr  1 09:23:44 icnode12 kernel: 1151MB HIGHMEM available.
Apr  1 09:23:44 icnode12 kernel: cpu: 0, clocks: 2666705, slice: 888901
Apr  1 09:23:44 icnode12 kernel: cpu: 1, clocks: 2666705, slice: 888901
Apr  1 09:23:44 icnode12 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 10:02:33 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 10:02:33 icnode13 kernel: cpu: 0, clocks: 2666804, slice: 888934
Apr  1 10:02:33 icnode13 kernel: cpu: 1, clocks: 2666804, slice: 888934
Apr  1 10:02:33 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 11:07:17 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 11:07:17 icnode13 kernel: cpu: 0, clocks: 2666705, slice: 888901
Apr  1 11:07:17 icnode13 kernel: cpu: 1, clocks: 2666705, slice: 888901
Apr  1 11:07:17 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 11:38:55 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 11:38:55 icnode13 kernel: cpu: 0, clocks: 2666980, slice: 888993
Apr  1 11:38:55 icnode13 kernel: cpu: 1, clocks: 2666980, slice: 888993
Apr  1 11:38:55 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 11:51:32 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 11:51:32 icnode13 kernel: cpu: 0, clocks: 2666705, slice: 888901
Apr  1 11:51:32 icnode13 kernel: cpu: 1, clocks: 2666705, slice: 888901
Apr  1 11:51:32 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 12:55:57 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 12:55:57 icnode13 kernel: cpu: 0, clocks: 2666804, slice: 888934
Apr  1 12:55:57 icnode13 kernel: cpu: 1, clocks: 2666804, slice: 888934
Apr  1 12:55:57 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 15:02:09 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 15:02:09 icnode13 kernel: cpu: 0, clocks: 2666705, slice: 888901
Apr  1 15:02:09 icnode13 kernel: cpu: 1, clocks: 2666705, slice: 888901
Apr  1 15:02:09 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 15:07:44 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 15:07:44 icnode13 kernel: cpu: 0, clocks: 2666804, slice: 888934
Apr  1 15:07:44 icnode13 kernel: cpu: 1, clocks: 2666804, slice: 888934
Apr  1 15:07:44 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 15:27:12 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 15:27:12 icnode13 kernel: cpu: 0, clocks: 2666705, slice: 888901
Apr  1 15:27:12 icnode13 kernel: cpu: 1, clocks: 2666705, slice: 888901
Apr  1 15:27:12 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  1 15:33:24 icnode13 kernel: 1151MB HIGHMEM available.
Apr  1 15:33:24 icnode13 kernel: cpu: 0, clocks: 2666804, slice: 888934
Apr  1 15:33:24 icnode13 kernel: cpu: 1, clocks: 2666804, slice: 888934
Apr  1 15:33:24 icnode13 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  2 11:02:26 icnode20 kernel: 1151MB HIGHMEM available.
Apr  2 11:02:26 icnode20 kernel: cpu: 0, clocks: 2666800, slice: 888933
Apr  2 11:02:26 icnode20 kernel: cpu: 1, clocks: 2666800, slice: 888933
Apr  2 11:02:26 icnode20 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  3 05:17:09 icnode20 kernel: 1151MB HIGHMEM available.
Apr  3 05:17:09 icnode20 kernel: cpu: 0, clocks: 2666718, slice: 888906
Apr  3 05:17:09 icnode20 kernel: cpu: 1, clocks: 2666718, slice: 888906
Apr  3 05:17:09 icnode20 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  7 12:11:30 icnode20 kernel: 1151MB HIGHMEM available.
Apr  7 12:11:30 icnode20 kernel: cpu: 0, clocks: 2666800, slice: 888933
Apr  7 12:11:30 icnode20 kernel: cpu: 1, clocks: 2666800, slice: 888933
Apr  7 12:11:30 icnode20 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  7 16:14:53 icnode20 kernel: 1151MB HIGHMEM available.
Apr  7 16:14:53 icnode20 kernel: cpu: 0, clocks: 2666718, slice: 888906
Apr  7 16:14:53 icnode20 kernel: cpu: 1, clocks: 2666718, slice: 888906
Apr  7 16:14:53 icnode20 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  7 20:15:29 icnode20 kernel: 1151MB HIGHMEM available.
Apr  7 20:15:29 icnode20 kernel: cpu: 0, clocks: 2666798, slice: 888932
Apr  7 20:15:29 icnode20 kernel: cpu: 1, clocks: 2666798, slice: 888932
Apr  7 20:15:29 icnode20 kernel: 3c59x: Donald Becker and others. www.scyld=
.com/network/vortex.html
Apr  7 21:22:22 node20 kernel: 1151MB HIGHMEM available.
Apr  7 21:22:22 node20 kernel: cpu: 0, clocks: 2666718, slice: 888906
Apr  7 21:22:22 node20 kernel: cpu: 1, clocks: 2666718, slice: 888906
Apr  7 21:22:23 node20 kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
Apr  7 22:32:27 node20 kernel: 1151MB HIGHMEM available.
Apr  7 22:32:32 node20 kernel: cpu: 0, clocks: 2666800, slice: 888933
Apr  7 22:32:32 node20 kernel: cpu: 1, clocks: 2666800, slice: 888933
Apr  7 22:32:35 node20 kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
Apr 14 15:05:06 node20 kernel: 1151MB HIGHMEM available.
Apr 14 15:05:06 node20 kernel: cpu: 0, clocks: 2666718, slice: 888906
Apr 14 15:05:06 node20 kernel: cpu: 1, clocks: 2666718, slice: 888906
Apr 14 15:05:06 node20 kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
Apr 15 15:42:18 node20 kernel: 1151MB HIGHMEM available.
Apr 15 15:42:18 node20 kernel: cpu: 0, clocks: 2666798, slice: 888932
Apr 15 15:42:18 node20 kernel: cpu: 1, clocks: 2666798, slice: 888932
Apr 15 15:42:20 node20 kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
May  5 13:05:33 node20 kernel: 1151MB HIGHMEM available.
May  5 13:05:33 node20 kernel: cpu: 0, clocks: 2666993, slice: 888997
May  5 13:05:33 node20 kernel: cpu: 1, clocks: 2666993, slice: 888997
May  5 13:05:33 node20 kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
Jul 14 15:53:47 node20 kernel: 1151MB HIGHMEM available.
Jul 14 15:53:47 node20 kernel: cpu: 0, clocks: 2666718, slice: 888906
Jul 14 15:53:47 node20 kernel: cpu: 1, clocks: 2666718, slice: 888906
Jul 14 15:53:47 node20 kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
Jul 14 20:45:52 node20 kernel: 1151MB HIGHMEM available.
Jul 14 20:45:52 node20 kernel: cpu: 0, clocks: 2666718, slice: 888906
Jul 14 20:45:52 node20 kernel: cpu: 1, clocks: 2666718, slice: 888906
Jul 14 20:45:52 node20 kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
Aug 14 09:24:57 node20 kernel: Unable to handle kernel paging request at vi=
rtual address f887124a
Aug 14 09:24:57 node20 kernel: f887124a
Aug 14 09:24:57 node20 kernel: *pde =3D 37bb2067
Aug 14 09:24:57 node20 kernel: Oops: 0000
Aug 14 09:24:57 node20 kernel: CPU:    1
Aug 14 09:24:57 node20 kernel: EIP:    0010:[<f887124a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 14 09:24:57 node20 kernel: EFLAGS: 00010246
Aug 14 09:24:57 node20 kernel: eax: 00000000   ebx: 00000d00   ecx: f0655c4=
8   edx: f0655c48
Aug 14 09:24:57 node20 kernel: esi: 00000124   edi: 00000000   ebp: f0655d1=
8   esp: f0655c78
Aug 14 09:24:57 node20 kernel: ds: 0018   es: 0018   ss: 0018
Aug 14 09:24:57 node20 kernel: Process sensors (pid: 25526, stackpage=F0655=
000)
Aug 14 09:24:57 node20 kernel: Stack: 00000001 ffffffff 00000016 00000002 0=
0000002 000080e0 00000001 f88714cc
Aug 14 09:24:57 node20 kernel:        f88720e8 f0654000 0000002d f88720e0 0=
0000002 0000002d 00000000 f886cfeb
Aug 14 09:24:57 node20 kernel:        f88720a0 0000002d 00000000 00000001 0=
0000055 00000002 f0655d18 f88720a0
Aug 14 09:24:57 node20 kernel: Call Trace: [<c0128a34>] [<c012c4fb>] [<c012=
c529>] [<c01289e5>] [<c0116040>]
Aug 14 09:24:57 node20 kernel:    [<c012c440>] [<c0128a58>] [<c011f5ab>] [<=
c0129868>] [<c011f519>] [<c011f315>]
Aug 14 09:24:57 node20 kernel:    [<c011f3e0>] [<c0116040>] [<c010722b>]
Aug 14 09:24:57 node20 kernel: Code:  Bad EIP value.

>>EIP; f887124a <[i2c-amd756].text.start+1ea/67f>   <=3D=3DTrace; c0128a34 =
<vmtruncate+424/cc0>
Trace; c012c4fb <filemap_nopage+bb/210>
Trace; c012c529 <filemap_nopage+e9/210>
Trace; c01289e5 <vmtruncate+3d5/cc0>
Trace; c0116040 <__verify_write+230/970>
Trace; c012c440 <filemap_nopage+0/210>
Trace; c0128a58 <vmtruncate+448/cc0>
Trace; c011f5ab <__release_region+3bb/490>
Trace; c0129868 <get_unmapped_area+d8/120>
Trace; c011f519 <__release_region+329/490>
Trace; c011f315 <__release_region+125/490>
Trace; c011f3e0 <__release_region+1f0/490>
Trace; c0116040 <__verify_write+230/970>
Trace; c010722b <__read_lock_failed+123f/2754>


43 warnings and 5 errors issued.  Results may not be reliable.

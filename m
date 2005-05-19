From: calum.mackay@cdmnet.org (Calum Mackay)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: i801_adapter: oops when gkrellm is running
Message-Id: <3EBFAD93.8050801@cdmnet.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

not sure whether this should have been a ticket, or whether it's just me.

I've just started using lm-sensors/i2c. Debian system, with:

ii  lm-sensors     2.7.0-3        Utilities to read=20
temperature/voltage/fan se
ii  lm-sensors-sou 2.7.0-3        Kernel drivers to read=20
temperature/voltage/f
ii  i2c-source     2.7.0-3        sources for drivers for the i2c bus

used to compile the drivers. No i2c whatsoever is in the main kernel
build; I'm on 2.4.20 (built myself).

sensors-detect was perfectly happy, and I startup like this:

          modprobe -v i2c-i801
          modprobe -v adm1025
          modprobe -v eeprom
          sleep 3
          /usr/bin/sensors -s

Since installing gkrellm 2.1.10 a few days ago, I'm getting repeated
oops (see attached). Especially easy to provoke if I run "sensors"
whilst gkrellm is running.

I'd be happy to test a fix, if it's a known issue, since it's easy to
reproduce.

best regards,
Calum.
-------------- next part --------------
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0115854
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0115854>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210082
eax: f8d0118c   ebx: 00000000   ecx: 00200202   edx: c5515d50
esi: c5515d48   edi: c5514000   ebp: f8d01140   esp: c5515d30
ds: 0018   es: 0018   ss: 0018
Process gkrellmd (pid: 29615, stackpage=C5515000)
Stack: f8d01180 c5515d48 c0107519 f8d01180 00000000 00000002 00000001 c5514=
000=20
       f8d0118c 00000000 c0107678 f8d01180 f8d00704 f8d01100 f8cfd13f 00000=
000=20
       00000000 00000000 0000002d 00000000 00000000 01200201 db62c280 db62c=
2bc=20
Call Trace:    [<f8d01180>] [<c0107519>] [<f8d01180>] [<f8d0118c>] [<c01076=
78>]
  [<f8d01180>] [<f8d00704>] [<f8d01100>] [<f8cfd13f>] [<f8cfc6c0>] [<f8d011=
40>]
  [<f8d06342>] [<f8d064ef>] [<f8d06889>] [<c014347a>] [<c0143696>] [<f8d067=
74>]
  [<f8d03704>] [<c0139beb>] [<c0123a02>] [<c0123f4e>] [<c0123f5a>] [<c011b9=
32>]
  [<c011b960>] [<c0131766>] [<c01086a7>]
Code: 89 13 51 9d 5b 5e c3 90 56 53 89 d6 9c 5a fa 8d 5e 08 8b 4b=20


>>EIP; c0115854 <add_wait_queue_exclusive+1c/24>   <=3D=3D
>>eax; f8d0118c <[i2c-i801]i801_adapter+4c/e4>
>>edx; c5515d50 <_end+523ec80/345b3f90>
>>esi; c5515d48 <_end+523ec78/345b3f90>
>>edi; c5514000 <_end+523cf30/345b3f90>
>>ebp; f8d01140 <[i2c-i801]i801_adapter+0/e4>
>>esp; c5515d30 <_end+523ec60/345b3f90>

Trace; f8d01180 <[i2c-i801]i801_adapter+40/e4>
Trace; c0107519 <__down+41/9c>
Trace; f8d01180 <[i2c-i801]i801_adapter+40/e4>
Trace; f8d0118c <[i2c-i801]i801_adapter+4c/e4>
Trace; c0107678 <__down_failed+8/c>
Trace; f8d01180 <[i2c-i801]i801_adapter+40/e4>
Trace; f8d00704 <[i2c-i801]i801_access+0/2b8>
Trace; f8d01100 <[i2c-i801]smbus_algorithm+0/c>
Trace; f8cfd13f <[i2c-core].text.lock.KBUILD_BASENAME+127/135>
Trace; f8cfc6c0 <[i2c-core]i2c_smbus_read_byte_data+28/40>
Trace; f8d01140 <[i2c-i801]i801_adapter+0/e4>
Trace; f8d06342 <[adm1025]adm1025_read_value+12/1c>
Trace; f8d064ef <[adm1025]adm1025_update_client+63/180>
Trace; f8d06889 <[adm1025]adm1025_temp+115/178>
Trace; c014347a <get_new_inode+f6/178>
Trace; c0143696 <iget4+ca/dc>
Trace; f8d06774 <[adm1025]adm1025_temp+0/178>
Trace; f8d03704 <[i2c-proc]i2c_proc_real+f0/130>
Trace; c0139beb <real_lookup+53/c4>
Trace; c0123a02 <__vma_link+62/b0>
Trace; c0123f4e <do_mmap_pgoff+40e/4cc>
Trace; c0123f5a <do_mmap_pgoff+41a/4cc>
Trace; c011b932 <do_rw_proc+76/88>
Trace; c011b960 <proc_readsys+1c/24>
Trace; c0131766 <sys_read+96/f0>
Trace; c01086a7 <system_call+33/38>

Code;  c0115854 <add_wait_queue_exclusive+1c/24>
00000000 <_EIP>:
Code;  c0115854 <add_wait_queue_exclusive+1c/24>   <=3D=3D   0:   89 13    =
                 mov    %edx,(%ebx)   <=3D=3DCode;  c0115856 <add_wait_queu=
e_exclusive+1e/24>
   2:   51                        push   %ecx
Code;  c0115857 <add_wait_queue_exclusive+1f/24>
   3:   9d                        popf  =20
Code;  c0115858 <add_wait_queue_exclusive+20/24>
   4:   5b                        pop    %ebx
Code;  c0115859 <add_wait_queue_exclusive+21/24>
   5:   5e                        pop    %esi
Code;  c011585a <add_wait_queue_exclusive+22/24>
   6:   c3                        ret   =20
Code;  c011585b <add_wait_queue_exclusive+23/24>
   7:   90                        nop   =20
Code;  c011585c <remove_wait_queue+0/28>
   8:   56                        push   %esi
Code;  c011585d <remove_wait_queue+1/28>
   9:   53                        push   %ebx
Code;  c011585e <remove_wait_queue+2/28>
   a:   89 d6                     mov    %edx,%esi
Code;  c0115860 <remove_wait_queue+4/28>
   c:   9c                        pushf =20
Code;  c0115861 <remove_wait_queue+5/28>
   d:   5a                        pop    %edx
Code;  c0115862 <remove_wait_queue+6/28>
   e:   fa                        cli   =20
Code;  c0115863 <remove_wait_queue+7/28>
   f:   8d 5e 08                  lea    0x8(%esi),%ebx
Code;  c0115866 <remove_wait_queue+a/28>
  12:   8b 4b 00                  mov    0x0(%ebx),%ecx

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
c0114a8b
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0114a8b>]    Not tainted
EFLAGS: 00010097
eax: f8d0118c   ebx: f8d01188   ecx: 00000000   edx: 00000003
esi: 00000000   edi: 00000001   ebp: d1dcbcd0   esp: d1dcbcb8
ds: 0018   es: 0018   ss: 0018
Process sensors (pid: 29606, stackpage=D1dcb000)
Stack: f8d01180 00000000 00000001 f8d0118c 00000286 00000003 f8d01140 c0107=
4d6=20
       c010769c f8d01180 0000efa5 00000000 f8cfd149 00dcbd18 00000000 0142b=
e80=20
       00000050 0062c2bc 00000000 01000302 000000ea c5b13e3c c5b13e00 c5b13=
e40=20
Call Trace:    [<f8d01180>] [<f8d0118c>] [<f8d01140>] [<c01074d6>] [<c01076=
9c>]
  [<f8d01180>] [<f8cfd149>] [<f8cfc654>] [<f8d01140>] [<c0195ff1>] [<c019d7=
67>]
  [<f8d092e9>] [<f8d09384>] [<c01a0d95>] [<f8d03824>] [<f8d03796>] [<c01976=
a7>]
  [<f8d09318>] [<c0114a36>] [<c01257a8>] [<c01268f1>] [<c011b5a9>] [<c011b5=
15>]
  [<c011b34c>] [<c011b3e7>] [<c01086a7>]
Code: 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00 00 83 79=20


>>EIP; c0114a8b <__wake_up+2b/98>   <=3D=3D
>>eax; f8d0118c <[i2c-i801]i801_adapter+4c/e4>
>>ebx; f8d01188 <[i2c-i801]i801_adapter+48/e4>
>>ebp; d1dcbcd0 <_end+11af4c00/345b3f90>
>>esp; d1dcbcb8 <_end+11af4be8/345b3f90>

Trace; f8d01180 <[i2c-i801]i801_adapter+40/e4>
Trace; f8d0118c <[i2c-i801]i801_adapter+4c/e4>
Trace; f8d01140 <[i2c-i801]i801_adapter+0/e4>
Trace; c01074d6 <__up+16/18>
Trace; c010769c <__up_wakeup+8/c>
Trace; f8d01180 <[i2c-i801]i801_adapter+40/e4>
Trace; f8cfd149 <[i2c-core].text.lock.KBUILD_BASENAME+131/135>
Trace; f8cfc654 <[i2c-core]i2c_smbus_read_byte+24/3c>
Trace; f8d01140 <[i2c-i801]i801_adapter+0/e4>
Trace; c0195ff1 <ide_set_handler+59/64>
Trace; c019d767 <piix_dmaproc+23/2c>
Trace; f8d092e9 <[eeprom]eeprom_update_client+61/90>
Trace; f8d09384 <[eeprom]eeprom_contents+6c/118>
Trace; c01a0d95 <do_rw_disk+2bd/528>
Trace; f8d03824 <[i2c-proc]i2c_sysctl_real+e0/164>
Trace; f8d03796 <[i2c-proc]i2c_sysctl_real+52/164>
Trace; c01976a7 <ide_do_request+287/2d4>
Trace; f8d09318 <[eeprom]eeprom_contents+0/118>
Trace; c0114a36 <schedule+2ea/314>
Trace; c01257a8 <__lock_page+b8/c0>
Trace; c01268f1 <filemap_nopage+e9/1f8>
Trace; c011b5a9 <do_sysctl_strategy+71/144>
Trace; c011b515 <parse_table+c9/ec>
Trace; c011b34c <do_sysctl+6c/a0>
Trace; c011b3e7 <sys_sysctl+67/7c>
Trace; c01086a7 <system_call+33/38>

Code;  c0114a8b <__wake_up+2b/98>
00000000 <_EIP>:
Code;  c0114a8b <__wake_up+2b/98>   <=3D=3D   0:   8b 01                   =
  mov    (%ecx),%eax   <=3D=3DCode;  c0114a8d <__wake_up+2d/98>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0114a90 <__wake_up+30/98>
   5:   74 4e                     je     55 <_EIP+0x55>
Code;  c0114a92 <__wake_up+32/98>
   7:   31 c0                     xor    %eax,%eax
Code;  c0114a94 <__wake_up+34/98>
   9:   9c                        pushf =20
Code;  c0114a95 <__wake_up+35/98>
   a:   5e                        pop    %esi
Code;  c0114a96 <__wake_up+36/98>
   b:   fa                        cli   =20
Code;  c0114a97 <__wake_up+37/98>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c0114a9d <__wake_up+3d/98>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)


1 warning issued.  Results may not be reliable.
-------------- next part --------------
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 VE Network Connection
e100: eth0 NIC Link is Up 100 Mbps Full duplex
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0115854
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0115854>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210082
eax: f491018c   ebx: 00000000   ecx: 00200202   edx: d7921d50
esi: d7921d48   edi: d7920000   ebp: f4910140   esp: d7921d30
ds: 0018   es: 0018   ss: 0018
Process gkrellm (pid: 1682, stackpage=D7921000)
Stack: f4910180 d7921d48 c0107519 f4910180 00000000 00000002 00000001 d7920=
000=20
       f491018c 00000000 c0107678 f4910180 f490f704 f4910100 f490c13f 00000=
000=20
       00000000 00000000 0000002d 00000000 00000000 01200000 ec460f80 ec460=
fbc=20
Call Trace:    [<f4910180>] [<c0107519>] [<f4910180>] [<f491018c>] [<c01076=
78>]
  [<f4910180>] [<f490f704>] [<f4910100>] [<f490c13f>] [<f490b6c0>] [<f49101=
40>]
  [<f4915342>] [<f49154ef>] [<f4915889>] [<c014347a>] [<c0143696>] [<f49157=
74>]
  [<f4912704>] [<c0139beb>] [<c0123a02>] [<c0123f4e>] [<c0123f5a>] [<c011b9=
32>]
  [<c011b960>] [<c0131766>] [<c01086a7>]
Code: 89 13 51 9d 5b 5e c3 90 56 53 89 d6 9c 5a fa 8d 5e 08 8b 4b=20


>>EIP; c0115854 <add_wait_queue_exclusive+1c/24>   <=3D=3D
>>eax; f491018c <[i2c-i801]i801_adapter+4c/e4>
>>edx; d7921d50 <_end+1764ac80/345b3f90>
>>esi; d7921d48 <_end+1764ac78/345b3f90>
>>edi; d7920000 <_end+17648f30/345b3f90>
>>ebp; f4910140 <[i2c-i801]i801_adapter+0/e4>
>>esp; d7921d30 <_end+1764ac60/345b3f90>

Trace; f4910180 <[i2c-i801]i801_adapter+40/e4>
Trace; c0107519 <__down+41/9c>
Trace; f4910180 <[i2c-i801]i801_adapter+40/e4>
Trace; f491018c <[i2c-i801]i801_adapter+4c/e4>
Trace; c0107678 <__down_failed+8/c>
Trace; f4910180 <[i2c-i801]i801_adapter+40/e4>
Trace; f490f704 <[i2c-i801]i801_access+0/2b8>
Trace; f4910100 <[i2c-i801]smbus_algorithm+0/c>
Trace; f490c13f <[i2c-core].text.lock.KBUILD_BASENAME+127/135>
Trace; f490b6c0 <[i2c-core]i2c_smbus_read_byte_data+28/40>
Trace; f4910140 <[i2c-i801]i801_adapter+0/e4>
Trace; f4915342 <[adm1025]adm1025_read_value+12/1c>
Trace; f49154ef <[adm1025]adm1025_update_client+63/180>
Trace; f4915889 <[adm1025]adm1025_temp+115/178>
Trace; c014347a <get_new_inode+f6/178>
Trace; c0143696 <iget4+ca/dc>
Trace; f4915774 <[adm1025]adm1025_temp+0/178>
Trace; f4912704 <[i2c-proc]i2c_proc_real+f0/130>
Trace; c0139beb <real_lookup+53/c4>
Trace; c0123a02 <__vma_link+62/b0>
Trace; c0123f4e <do_mmap_pgoff+40e/4cc>
Trace; c0123f5a <do_mmap_pgoff+41a/4cc>
Trace; c011b932 <do_rw_proc+76/88>
Trace; c011b960 <proc_readsys+1c/24>
Trace; c0131766 <sys_read+96/f0>
Trace; c01086a7 <system_call+33/38>

Code;  c0115854 <add_wait_queue_exclusive+1c/24>
00000000 <_EIP>:
Code;  c0115854 <add_wait_queue_exclusive+1c/24>   <=3D=3D   0:   89 13    =
                 mov    %edx,(%ebx)   <=3D=3DCode;  c0115856 <add_wait_queu=
e_exclusive+1e/24>
   2:   51                        push   %ecx
Code;  c0115857 <add_wait_queue_exclusive+1f/24>
   3:   9d                        popf  =20
Code;  c0115858 <add_wait_queue_exclusive+20/24>
   4:   5b                        pop    %ebx
Code;  c0115859 <add_wait_queue_exclusive+21/24>
   5:   5e                        pop    %esi
Code;  c011585a <add_wait_queue_exclusive+22/24>
   6:   c3                        ret   =20
Code;  c011585b <add_wait_queue_exclusive+23/24>
   7:   90                        nop   =20
Code;  c011585c <remove_wait_queue+0/28>
   8:   56                        push   %esi
Code;  c011585d <remove_wait_queue+1/28>
   9:   53                        push   %ebx
Code;  c011585e <remove_wait_queue+2/28>
   a:   89 d6                     mov    %edx,%esi
Code;  c0115860 <remove_wait_queue+4/28>
   c:   9c                        pushf =20
Code;  c0115861 <remove_wait_queue+5/28>
   d:   5a                        pop    %edx
Code;  c0115862 <remove_wait_queue+6/28>
   e:   fa                        cli   =20
Code;  c0115863 <remove_wait_queue+7/28>
   f:   8d 5e 08                  lea    0x8(%esi),%ebx
Code;  c0115866 <remove_wait_queue+a/28>
  12:   8b 4b 00                  mov    0x0(%ebx),%ecx

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
c0114a8b
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0114a8b>]    Not tainted
EFLAGS: 00013097
eax: f491018c   ebx: f4910188   ecx: 00000000   edx: 00000003
esi: 00000000   edi: 00000001   ebp: d7959cd0   esp: d7959cb8
ds: 0018   es: 0018   ss: 0018
Process sensors (pid: 1681, stackpage=D7959000)
Stack: f4910180 00000000 00000001 f491018c 00003286 00000003 f4910140 c0107=
4d6=20
       c010769c f4910180 0000efa5 00000000 f490c149 00b04940 00000000 01429=
0ac=20
       00000050 00460fbc 00000000 01000302 00000058 ed3a563c ed3a5600 ed3a5=
640=20
Call Trace:    [<f4910180>] [<f491018c>] [<f4910140>] [<c01074d6>] [<c01076=
9c>]
  [<f4910180>] [<f490c149>] [<f490b654>] [<f4910140>] [<c0195ff1>] [<c019d7=
67>]
  [<f48d92e9>] [<f48d9384>] [<c01a0d95>] [<f4912824>] [<f4912796>] [<c01976=
a7>]
  [<f48d9318>] [<c0114a36>] [<c01257a8>] [<c01268f1>] [<c011b5a9>] [<c011b5=
15>]
  [<c011b34c>] [<c011b3e7>] [<c01086a7>]
Code: 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00 00 83 79=20


>>EIP; c0114a8b <__wake_up+2b/98>   <=3D=3D
>>eax; f491018c <[i2c-i801]i801_adapter+4c/e4>
>>ebx; f4910188 <[i2c-i801]i801_adapter+48/e4>
>>ebp; d7959cd0 <_end+17682c00/345b3f90>
>>esp; d7959cb8 <_end+17682be8/345b3f90>

Trace; f4910180 <[i2c-i801]i801_adapter+40/e4>
Trace; f491018c <[i2c-i801]i801_adapter+4c/e4>
Trace; f4910140 <[i2c-i801]i801_adapter+0/e4>
Trace; c01074d6 <__up+16/18>
Trace; c010769c <__up_wakeup+8/c>
Trace; f4910180 <[i2c-i801]i801_adapter+40/e4>
Trace; f490c149 <[i2c-core].text.lock.KBUILD_BASENAME+131/135>
Trace; f490b654 <[i2c-core]i2c_smbus_read_byte+24/3c>
Trace; f4910140 <[i2c-i801]i801_adapter+0/e4>
Trace; c0195ff1 <ide_set_handler+59/64>
Trace; c019d767 <piix_dmaproc+23/2c>
Trace; f48d92e9 <[eeprom]eeprom_update_client+61/90>
Trace; f48d9384 <[eeprom]eeprom_contents+6c/118>
Trace; c01a0d95 <do_rw_disk+2bd/528>
Trace; f4912824 <[i2c-proc]i2c_sysctl_real+e0/164>
Trace; f4912796 <[i2c-proc]i2c_sysctl_real+52/164>
Trace; c01976a7 <ide_do_request+287/2d4>
Trace; f48d9318 <[eeprom]eeprom_contents+0/118>
Trace; c0114a36 <schedule+2ea/314>
Trace; c01257a8 <__lock_page+b8/c0>
Trace; c01268f1 <filemap_nopage+e9/1f8>
Trace; c011b5a9 <do_sysctl_strategy+71/144>
Trace; c011b515 <parse_table+c9/ec>
Trace; c011b34c <do_sysctl+6c/a0>
Trace; c011b3e7 <sys_sysctl+67/7c>
Trace; c01086a7 <system_call+33/38>

Code;  c0114a8b <__wake_up+2b/98>
00000000 <_EIP>:
Code;  c0114a8b <__wake_up+2b/98>   <=3D=3D   0:   8b 01                   =
  mov    (%ecx),%eax   <=3D=3DCode;  c0114a8d <__wake_up+2d/98>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0114a90 <__wake_up+30/98>
   5:   74 4e                     je     55 <_EIP+0x55>
Code;  c0114a92 <__wake_up+32/98>
   7:   31 c0                     xor    %eax,%eax
Code;  c0114a94 <__wake_up+34/98>
   9:   9c                        pushf =20
Code;  c0114a95 <__wake_up+35/98>
   a:   5e                        pop    %esi
Code;  c0114a96 <__wake_up+36/98>
   b:   fa                        cli   =20
Code;  c0114a97 <__wake_up+37/98>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c0114a9d <__wake_up+3d/98>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)


1 warning issued.  Results may not be reliable.

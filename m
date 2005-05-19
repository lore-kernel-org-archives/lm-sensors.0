From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Oops: i2c-proc.c
Message-Id: <20030130235623.A4057@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all:

CVS versions of all sensors modules:
i2c-proc.c	1.15.2.4 (tag lk2-4)
i2c-core.c	1.91.2.3 (tag lk2-4)
i2c-sis645.c	1.12 (HEAD)
w83781d.c	1.99 (HEAD)

kernel is RedHat 2.4.18-19.8.0

Yes, it looks bad because I just checked in a change
to w83781d.c - symbols wouldn't resolve otherwise.
What I did there is unrelated to this...

Oops occurs upon loading w83781d.o. On line 197 of
i2c-proc.c... looks like client_tbl->de is NULL.
Ksymoops output is attached.  If one of the main-
tainers can give me a hint, I'll try to fix it.
Right now, I'm fried and need sleep.

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com

-------------- next part --------------
ksymoops 2.4.5 on i686 2.4.18-19.8.0.  Options used
     -v /boot/vmlinux-2.4.18-19.8.0 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-19.8.0/ (default)
     -m /boot/System.map-2.4.18-19.8.0 (default)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique m=
odule object.  Trace may not be reliable.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Unable to handle kernel NULL pointer dereference at virtual address 00000024
d08af2fc
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d08af2fc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000100   ecx: c1a83c00   edx: d096a000
esi: 00000014   edi: cf0284fc   ebp: cf028000   esp: cdfa3e00
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 838, stackpage=CDfa3000)
Stack: d08ad380 00000048 00000080 cf028108 00000370 00000014 ce317b20 00000=
03c=20
       00000000 cdeda1ef c1a83c00 d096a29f c1a83c00 d096caa3 d096db80 00000=
000=20
       00000000 00000000 00000000 00000000 d096ca47 d096caa3 c1a83c3c 00000=
002=20
Call Trace: [<d08ad380>] sis645_adapter [i2c-sis645] 0x0 (0xcdfa3e00))
[<d096a29f>] w83781d_detect [w83781d] 0x223 (0xcdfa3e2c))
[<d096caa3>] .rodata.str1.1 [w83781d] 0x10c (0xcdfa3e34))
[<d096db80>] as99127f_dir_table_template [w83781d] 0x0 (0xcdfa3e38))
[<d096ca47>] .rodata.str1.1 [w83781d] 0xb0 (0xcdfa3e50))
[<d096caa3>] .rodata.str1.1 [w83781d] 0x10c (0xcdfa3e54))
[<d096da20>] ignore_range [w83781d] 0x0 (0xcdfa3e6c))
[<d096d8f8>] forces [w83781d] 0x38 (0xcdfa3e70))
[<d096da20>] ignore_range [w83781d] 0x0 (0xcdfa3e7c))
[<d096d8f8>] forces [w83781d] 0x38 (0xcdfa3e80))
[<d08b003f>] i2c_detect_R12fb8fa2 [i2c-proc] 0x31b (0xcdfa3e8c))
[<d08ad380>] sis645_adapter [i2c-sis645] 0x0 (0xcdfa3e90))
[<d096db40>] w83781d_driver [w83781d] 0x0 (0xcdfa3eb0))
[<d096a076>] w83781d_attach_adapter [w83781d] 0x16 (0xcdfa3ebc))
[<d08ad380>] sis645_adapter [i2c-sis645] 0x0 (0xcdfa3ec0))
[<d096da80>] addr_data [w83781d] 0x0 (0xcdfa3ec4))
[<d096a07c>] w83781d_detect [w83781d] 0x0 (0xcdfa3ec8))
[<c011b111>] printk [kernel] 0x111 (0xcdfa3ecc))
[<d096cb3c>] .rodata.str1.1 [w83781d] 0x1a5 (0xcdfa3ed8))
[<d08a631f>] i2c_add_driver_Rd0e7daf2 [i2c-core] 0x8f (0xcdfa3edc))
[<d08ad380>] sis645_adapter [i2c-sis645] 0x0 (0xcdfa3ee0))
[<d096c93b>] sm_w83781d_init [w83781d] 0x23 (0xcdfa3efc))
[<d096db40>] w83781d_driver [w83781d] 0x0 (0xcdfa3f00))
[<d096cb19>] .rodata.str1.1 [w83781d] 0x182 (0xcdfa3f04))
[<d096cb10>] .rodata.str1.1 [w83781d] 0x179 (0xcdfa3f08))
[<c011bf99>] sys_init_module [kernel] 0x4d9 (0xcdfa3f1c))
[<d096a060>] w83781d_attach_adapter [w83781d] 0x0 (0xcdfa3f20))
[<d096cde4>] .kmodtab [w83781d] 0x0 (0xcdfa3f2c))
[<d096a060>] w83781d_attach_adapter [w83781d] 0x0 (0xcdfa3f58))
[<c0109127>] system_call [kernel] 0x33 (0xcdfa3fc0))
Code: 89 50 24 89 d8 83 c4 1c 5b 5e 5f 5d c3 83 ec 0c 68 80 04 8b=20


>>EIP; d08af2fc <[i2c-proc]i2c_register_entry+158/1a4>   <=3D=3D
>>ecx; c1a83c00 <_end+16c2300/1044b760>
>>edx; d096a000 <[nfs].bss.end+1d7d/1ddd>
>>edi; cf0284fc <_end+ec66bfc/1044b760>
>>ebp; cf028000 <_end+ec66700/1044b760>
>>esp; cdfa3e00 <_end+dbe2500/1044b760>

Trace; d08ad380 <[i2c-sis645]sis645_adapter+0/100>
Trace; d096a29f <[w83781d]w83781d_detect+223/8a8>
Trace; d096caa3 <[w83781d]__module_parm_desc_force_w83781d+56/73>
Trace; d096db80 <[w83781d]as99127f_dir_table_template+0/3a0>
Trace; d096ca47 <[w83781d]__module_parm_force_w83781d+2d/33>
Trace; d096caa3 <[w83781d]__module_parm_desc_force_w83781d+56/73>
Trace; d096da20 <[w83781d]ignore_range+0/60>
Trace; d096d8f8 <[w83781d]forces+38/40>
Trace; d096da20 <[w83781d]ignore_range+0/60>
Trace; d096d8f8 <[w83781d]forces+38/40>
Trace; d08b003f <[i2c-proc]i2c_detect+31b/498>
Trace; d08ad380 <[i2c-sis645]sis645_adapter+0/100>
Trace; d096db40 <[w83781d]w83781d_driver+0/40>
Trace; d096a076 <[w83781d]w83781d_attach_adapter+16/1c>
Trace; d08ad380 <[i2c-sis645]sis645_adapter+0/100>
Trace; d096da80 <[w83781d]addr_data+0/40>
Trace; d096a07c <[w83781d]w83781d_detect+0/8a8>
Trace; c011b111 <printk+111/150>
Trace; d096cb3c <[w83781d]__module_parm_desc_force_w83782d+4f/73>
Trace; d08a631f <[i2c-core]i2c_add_driver+8f/c0>
Trace; d08ad380 <[i2c-sis645]sis645_adapter+0/100>
Trace; d096c93b <[w83781d]sm_w83781d_init+23/28>
Trace; d096db40 <[w83781d]w83781d_driver+0/40>
Trace; d096cb19 <[w83781d]__module_parm_desc_force_w83782d+2c/73>
Trace; d096cb10 <[w83781d]__module_parm_desc_force_w83782d+23/73>
Trace; c011bf99 <sys_init_module+4d9/630>
Trace; d096a060 <[w83781d]w83781d_attach_adapter+0/1c>
Trace; d096cde4 <[w83781d]__module_parm_probe+2/2b>
Trace; d096a060 <[w83781d]w83781d_attach_adapter+0/1c>
Trace; c0109127 <system_call+33/38>

Code;  d08af2fc <[i2c-proc]i2c_register_entry+158/1a4>
00000000 <_EIP>:
Code;  d08af2fc <[i2c-proc]i2c_register_entry+158/1a4>   <=3D=3D   0:   89 =
50 24                  mov    %edx,0x24(%eax)   <=3D=3DCode;  d08af2ff <[i2=
c-proc]i2c_register_entry+15b/1a4>
   3:   89 d8                     mov    %ebx,%eax
Code;  d08af301 <[i2c-proc]i2c_register_entry+15d/1a4>
   5:   83 c4 1c                  add    $0x1c,%esp
Code;  d08af304 <[i2c-proc]i2c_register_entry+160/1a4>
   8:   5b                        pop    %ebx
Code;  d08af305 <[i2c-proc]i2c_register_entry+161/1a4>
   9:   5e                        pop    %esi
Code;  d08af306 <[i2c-proc]i2c_register_entry+162/1a4>
   a:   5f                        pop    %edi
Code;  d08af307 <[i2c-proc]i2c_register_entry+163/1a4>
   b:   5d                        pop    %ebp
Code;  d08af308 <[i2c-proc]i2c_register_entry+164/1a4>
   c:   c3                        ret   =20
Code;  d08af309 <[i2c-proc]i2c_register_entry+165/1a4>
   d:   83 ec 0c                  sub    $0xc,%esp
Code;  d08af30c <[i2c-proc]i2c_register_entry+168/1a4>
  10:   68 80 04 8b 00            push   $0x8b0480

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
d08af565
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d08af565>]    Not tainted
EFLAGS: 00010282
eax: 00000000   ebx: bffffccc   ecx: 00000066   edx: cf0280b0
esi: 00000000   edi: cdfa3ebc   ebp: 40036e00   esp: cdfa3ea8
ds: 0018   es: 0018   ss: 0018
Process sensors (pid: 852, stackpage=CDfa3000)
Stack: 00000000 00000066 00000000 00000000 00000000 00000000 c012b836 cdf3c=
000=20
       00000000 00000000 cffe1ba0 cdf14420 420da100 00000000 c012c0c9 cffe1=
ba0=20
       c1988f00 420da100 d08b1020 d08b0fc0 40036e00 bffffccc 00000000 c0120=
845=20
Call Trace: [<c012b836>] do_wp_page [kernel] 0x116 (0xcdfa3ec0))
[<c012c0c9>] handle_mm_fault [kernel] 0x89 (0xcdfa3ee0))
[<d08b1020>] i2c_proc_dev [i2c-proc] 0x0 (0xcdfa3ef0))
[<d08b0fc0>] i2c_proc_dev_sensors [i2c-proc] 0x0 (0xcdfa3ef4))
[<c0120845>] do_sysctl_strategy [kernel] 0x175 (0xcdfa3f04))
[<d08b0fc0>] i2c_proc_dev_sensors [i2c-proc] 0x0 (0xcdfa3f08))
[<c0120493>] do_sysctl [kernel] 0x93 (0xcdfa3f3c))
[<d08b0fc0>] i2c_proc_dev_sensors [i2c-proc] 0x0 (0xcdfa3f40))
[<c0120534>] sys_sysctl [kernel] 0x64 (0xcdfa3f74))
[<c0109218>] error_code [kernel] 0x34 (0xcdfa3fb8))
[<c0109127>] system_call [kernel] 0x33 (0xcdfa3fc0))
Code: ac aa 84 c0 75 fa 50 6a 28 8d 44 24 18 50 55 e8 af 0d 00 00=20


>>EIP; d08af565 <[i2c-proc]i2c_sysctl_chips+e5/114>   <=3D=3D
>>ebx; bffffccc Before first symbol
>>edx; cf0280b0 <_end+ec667b0/1044b760>
>>edi; cdfa3ebc <_end+dbe25bc/1044b760>
>>ebp; 40036e00 Before first symbol
>>esp; cdfa3ea8 <_end+dbe25a8/1044b760>

Trace; c012b836 <do_wp_page+116/2a0>
Trace; c012c0c9 <handle_mm_fault+89/160>
Trace; d08b1020 <[i2c-proc]i2c_proc_dev+0/60>
Trace; d08b0fc0 <[i2c-proc]i2c_proc_dev_sensors+0/60>
Trace; c0120845 <do_sysctl_strategy+175/190>
Trace; d08b0fc0 <[i2c-proc]i2c_proc_dev_sensors+0/60>
Trace; c0120493 <do_sysctl+93/d0>
Trace; d08b0fc0 <[i2c-proc]i2c_proc_dev_sensors+0/60>
Trace; c0120534 <sys_sysctl+64/70>
Trace; c0109218 <error_code+34/3c>
Trace; c0109127 <system_call+33/38>

Code;  d08af565 <[i2c-proc]i2c_sysctl_chips+e5/114>
00000000 <_EIP>:
Code;  d08af565 <[i2c-proc]i2c_sysctl_chips+e5/114>   <=3D=3D   0:   ac    =
                    lods   %ds:(%esi),%al   <=3D=3DCode;  d08af566 <[i2c-pr=
oc]i2c_sysctl_chips+e6/114>
   1:   aa                        stos   %al,%es:(%edi)
Code;  d08af567 <[i2c-proc]i2c_sysctl_chips+e7/114>
   2:   84 c0                     test   %al,%al
Code;  d08af569 <[i2c-proc]i2c_sysctl_chips+e9/114>
   4:   75 fa                     jne    0 <_EIP>
Code;  d08af56b <[i2c-proc]i2c_sysctl_chips+eb/114>
   6:   50                        push   %eax
Code;  d08af56c <[i2c-proc]i2c_sysctl_chips+ec/114>
   7:   6a 28                     push   $0x28
Code;  d08af56e <[i2c-proc]i2c_sysctl_chips+ee/114>
   9:   8d 44 24 18               lea    0x18(%esp,1),%eax
Code;  d08af572 <[i2c-proc]i2c_sysctl_chips+f2/114>
   d:   50                        push   %eax
Code;  d08af573 <[i2c-proc]i2c_sysctl_chips+f3/114>
   e:   55                        push   %ebp
Code;  d08af574 <[i2c-proc]i2c_sysctl_chips+f4/114>
   f:   e8 af 0d 00 00            call   dc3 <_EIP+0xdc3>


1 warning and 5 errors issued.  Results may not be reliable.

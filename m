From: r.young@irl.cri.nz (Roger Young)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Ticket 1272
Message-Id: <20030615162205.129779e7.r.young@irl.cri.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>Reply from support:
>please run output through ksymoops and email the result,
>ref. your ticket number

Thanks for your quick response. I hope I am replying via this email
through the correct channel. The original inquiry (ticket 1272) is
copied to the bottom of this email. The output from ksymoops is
reproduced directly below (C). This also shows the loaded modules (A)
and the modproble command which generated the oops (B)

Hope this is helpful information.
Regards,
Roger Young.
r.young@irl.cri.nz

.........................................................................
(A)
root@Beauty:~# lsmod
Module                  Size  Used by    Not tainted
eeprom                  3508   0  (unused)
w83781d                19312   0  (unused)
i2c-proc                6928   0  [eeprom w83781d]
i2c-core               14000   0  [eeprom w83781d i2c-proc]

(B)
root@Beauty:~# modprobe i2c-amd756

[Error message copied to i2c-amd756.err1]

(C)
root@Beauty:~# ksymoops i2c-amd756.err1=20
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 000011ee
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<fc88a65c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 000011e6   ebx: 00000000   ecx: fc87d69c   edx: 00000000
esi: 00000001   edi: 00000001   ebp: fc88a000   esp: f77d1f08
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 114, stackpage=F77d1000)
Stack: fc88a6fc 000080e0 00000001 00000001 ffffffea c011ec4e fc88a060 08090=
a80
       00000d50 fc88abfc 08091534 00000b14 00000060 00000060 0000000a c1c1d=
840
       f77c9000 f77ca000 00000060 fc888000 fc88a060 00000db0 00000000 00000=
000
Call Trace:    [<fc88a6fc>] [<c011ec4e>] [<fc88a060>] [<fc88abfc>] [<fc88a0=
60>]
  [<c01091ff>]
Code: ff 70 08 68 80 aa 88 fc ff 05 ac ad 88 fc e8 21 34 89 c3 31


>>EIP; fc88a65c <.data.end+18a9/????>   <=3D=3D
>>ecx; fc87d69c <[i2c-core].data.end+d1/1a95>
>>ebp; fc88a000 <.data.end+124d/????>
>>esp; f77d1f08 <_end+3740c950/3c4b4aa8>

Trace; fc88a6fc <.data.end+1949/????>
Trace; c011ec4e <sys_init_module+4ee/650>
Trace; fc88a060 <.data.end+12ad/????>
Trace; fc88abfc <.data.end+1e49/????>
Trace; fc88a060 <.data.end+12ad/????>
Trace; c01091ff <system_call+33/38>

Code;  fc88a65c <.data.end+18a9/????>
00000000 <_EIP>:
Code;  fc88a65c <.data.end+18a9/????>   <=3D=3D   0:   ff 70 08            =
      pushl  0x8(%eax)   <=3D=3DCode;  fc88a65f <.data.end+18ac/????>
   3:   68 80 aa 88 fc            push   $0xfc88aa80
Code;  fc88a664 <.data.end+18b1/????>
   8:   ff 05 ac ad 88 fc         incl   0xfc88adac
Code;  fc88a66a <.data.end+18b7/????>
   e:   e8 21 34 89 c3            call   c3893434 <_EIP+0xc3893434>
Code;  fc88a66f <.data.end+18bc/????>
  13:   31 00                     xor    %eax,(%eax)


1 warning issued.  Results may not be reliable.


...........................................................................=
..........
[Original inquiry]

Ticket #: 1272 Timestamp: 2003-06-14 13:18:02-07 Version/Environment: lm_se=
nsors 2.7.0 Linux 2.4.20 SMP
Subject: i2c-amd756 segfault with kernel 2.4.20 Category: kernel
Contact: r.young@irl.cri.nz Client Machine: ippool31-186-irl.remote.irl.cri=
.nz Status: Examined/Unsolved
Problem in detail:

Hello, I am trying to use i2c/lm_sensors v.2.7.0 under Linux v.2.4.20
but the i2c-amd756 module segfaults when loaded (with modprobe or insmod).
I give the complete error message below. I have a Tyan MPX 2466B m/b.
and use gcc 3.3.2 (with the Slackware 9.0 distribution).=20

I am using the "stand-alone" option (method 1). Therefore I didn?t
apply any of the patches as they seemed to relate only to the kernel
option. There was an initial compile problem but that was fixed according t=
o=20
a suggestion made in ticket #1189. There were no further problems.
modules.conf and sensors.conf were configured as suggested by=20
Tyan on their website.

My impression is that this is related to the current kernel version
(2.4.20) since I have not had this problem in the past. After a search
I looked at some other tickets (#1235, 1096) but they did not seem to=20
relate directly to my problem.

Thanks for any help with this.
Regards,
Roger Young.=20

....................................................................
root@Beauty:~# modprobe i2c-amd756
Unable to handle kernel paging request at virtual address 000011f2
*pde =3D 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<fc89e65c>]    Not tainted
EFLAGS: 00010292
eax: 000011ea   ebx: 00000000   ecx: fc89169c   edx: 00000000
esi: 00000001   edi: 00000001   ebp: fc89e000   esp: f77e5f08
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 111, stackpage=F77e5000)
Stack: fc89e6fc 000080e0 00000001 00000001 ffffffea c011ec4e fc89e060 08091=
6e8
       00000d50 fc89ebfc 0809219c 00000b14 00000060 00000060 0000000a f7d92=
500
       f77da000 f77db000 00000060 fc89c000 fc89e060 00000db0 00000000 00000=
000
Call Trace:    [<fc89e6fc>] [<c011ec4e>] [<fc89e060>] [<fc89ebfc>] [<fc89e0=
60>]
  [<c01091ff>]

Code: ff 70 08 68 80 ea 89 fc ff 05 ac ed 89 fc e8 21 f4 87 c3 31
 Segmentation fault

Reply from support:

please run output through ksymoops and email the result,
ref. your ticket number



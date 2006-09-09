From: tuomas.leikola@gmail.com (Tuomas Leikola)
Date: Sat, 09 Sep 2006 13:56:24 +0000
Subject: [lm-sensors] ipmisensors problem report on Intel STL2 MB
Message-Id: <5b170a7d0609090656t3cdf3c16x233cc4dc50ece9b9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

(cc:ing lm-sensors)

Hi!

I've tried your ipmisensors patch ipmisensors-20060805-0622.diff on
linux-2.6.17.12, with less success that could be hoped for :(

This is an Intel STL2 dual-P3 motherboard. I'm happy to provide any
other info if interested.

2ct2:~# lsmod | grep ipmi
ipmisensors            18632  0
ipmi_si                37036  1
ipmi_msghandler        35456  2 ipmisensors,ipmi_si
2ct2:~# dmesg|grep 'ipmisensors:'
ipmisensors: Registered IPMI 1.0 BMC over interface 0
ipmisensors: Send 0x22
ipmisensors: received message
ipmisensors: Got first resid 0x0037
ipmisensors: Get SDR 0x0 0x0 0x0
ipmisensors: Send 0x23 0x0 0x0
ipmisensors: received message
ipmisensors: Get SDR 0x37 0x1 0x10
ipmisensors: Send 0x23 0x37 0x0
ipmisensors: received message
ipmisensors: Get SDR 0x37 0x1 0x20
ipmisensors: Send 0x23 0x37 0x0
ipmisensors: received message
ipmisensors: Get SDR 0x37 0x1 0x30
ipmisensors: Send 0x23 0x37 0x0
ipmisensors: Error 0xca on cmd 0xb/0x23
ipmisensors: received message
ipmisensors: Reducing SDR request size to 8
ipmisensors: Get SDR 0x0 0x0 0x0
ipmisensors: Send 0x23 0x0 0x0
ipmisensors: received message
ipmisensors: Get SDR 0x37 0x1 0x38
ipmisensors: Send 0x23 0x37 0x0
ipmisensors: Error 0xca on cmd 0xb/0x23
ipmisensors: received message
ipmisensors: IPMI buffers too small, giving up
2ct2:~# sensors
No sensors found!
2ct2:~# sensors-detect
# sensors-detect revision 1.413 (2006/01/19 20:28:00)
<snip>
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Success!
    (confidence 4, driver `bmcsensors')
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!


Sensors-detect might be a bit old as it recommends bmcsensors. I
assume that's not a problem, though.

As a sidenote, module unmount crashes things:

2ct2:~# rmmod ipmisensors
Segmentation fault

with dmesg:

BUG: unable to handle kernel paging request at virtual address 00005202
 printing eip:
c0194b04
*pde =3D 00000000
Oops: 0000 [#1]
SMP
Modules linked in: i2c_dev nfs lockd sunrpc nbd iptable_nat ip_nat iptable_=
mang
le iptable_filter sd_mod ipmisensors ipmi_si ipmi_msghandler i2c_isa i2c_pi=
ix4
i2c_core e1000
CPU:    0
EIP:    0060:[<c0194b04>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17.12 #6)
EIP is at sysfs_hash_and_remove+0x64/0x110
eax: dfa53c68   ebx: c174a748   ecx: dfa53c40   edx: 00000020
esi: dfa53c21   edi: 00005202   ebp: c174a744   esp: d36eff20
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 4532, threadinfo=D36ee000 task=D7876050)
Stack: 00005202 df9b39b4 dfc11e04 dfa1e808 df9d8f10 00000000 d36ee000 c02b3=
f61
       df9d8c00 e0829644 e0827173 e0827b54 e0829680 e0829680 e08270d0 c0137=
123
       696d7069 736e6573 0073726f d7fe8d2c c014cb09 b7fd2000 dfce9040 c014d=
597
Call Trace:
 <c02b3f61> device_remove_file+0x21/0x40  <e0827173> ipmisensors_exit+0xa3/=
0x15
1 [ipmisensors]
 <e08270d0> ipmisensors_exit+0x0/0x151 [ipmisensors]  <c0137123> sys_delete=
_mod
ule+0x133/0x190
 <c014cb09> remove_vma+0x39/0x50  <c014d597> do_munmap+0x197/0x1f0
 <c0102e1b> syscall_call+0x7/0xb
Code: 00 90 83 c6 0c 8d 5d 04 39 de 89 74 24 08 74 44 8d b4 26 00 00 00 00 =
8b 4
d 14 85 c9 74 20 89 e8 e8 52 ff ff ff 8b 3c 24 89 c6 ac <ae> 75 08 84 c0 75=
 f8
31 c0 eb 04 19 c0 0c 01 85 c0 74 34 8b 6d
EIP: [<c0194b04>] sysfs_hash_and_remove+0x64/0x110 SS:ESP 0068:d36eff20

If there's anything else I can do to help, please just give me a pointer.

- Tuomas


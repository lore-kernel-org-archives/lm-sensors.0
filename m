From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd050321222140f08910@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Mar 2005 13:07:08 +0100 (CET), Jean Delvare
<khali@linux-fr.org> wrote:

> Miles, could you please try to modify your oopsing configuration in the
> following way:
>   CONFIG_I2C_CHARDEV=n
>   CONFIG_SENSORS_EEPROM=y
> I would expect if to oops in i2c_add_driver() as well.

I had to copy this by hand, but I think I got it all down correctly.

ksymoops -o /lib/modules/2.6.12-rc1-mm1/ -m
/boot/System.map-2.6.12-rc1-mm1 < oops2
ksymoops 2.4.9 on i686 2.6.11-bk5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12-rc1-mm1/ (specified)
     -m /boot/System.map-2.6.12-rc1-mm1 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000020
c02f094f
*pde = 00000000
Oops: 0000 [#1]
CPU:     0
EIP:      0060:[<c02f094f>}    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292   (2.6.12-rc1-mm1)
eax: 00000000 ebx: f7c076fc ecx: 00000001 edx: f7c07558
esi: c047c8e0 edi: 00000000 epb: f7c33f80 esp: f7c33f38
Warning (Oops_set_regs): garbage 'epb: f7c33f80 esp: f7c33f38' at end
of register line ignored
ds: 007b es: 007b ss: 0068
Stack: c02416fb c047bcc8 c047c94c f7c33f54 c047c94c ffffffea c047c920 f7c33f70
         00000246 c047c94c 00000000 c047bc64 c047bc00 c047c920 f7c33f94 f7c076fc
         c047c8e0 00000000 f7c33f94 c02f1aa1 f7c07558 c047c8c8 c02f1ab0 f7c33fb0
Call trace:
[<c0104d7f>] show_stack+0x74/0xa0
[<c0104f1a>] show_registers+0x15a/0x1c0
[<c0105184>] die+0x164/0x2e0
[<c0119936>] do_page_fault+0x356/0x68d
[<c0104853>] error_code+0x4f/0x54
[<c02f1aa1>] eeprom_attach_adapter+0x21/0x30
[<c02ee704>] i2c_add_driver+0xb4/0xe0
[<c050a652>] eeprom_init+0x12/0x40
[<c04ee8ab>] do_initcalls+0x2b/0xc0
[<c0100302>] init+0x32/0x130
[<c0101351>] kernel_thread_helper+0x5/0x14
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 55 89 e5 57 56 53 83 ec 3c 8b 55 08 8b 42 0c <81>
78 20 00 00 05 00 c7 45 e4 e7 23 00 00 0f 94 c0 0f b6 c0 85


>>EIP; c02f094f <i2c_detect+f/500>   <==
>>ebx; f7c076fc <pg0+376a46fc/3fa9b400>
>>edx; f7c07558 <pg0+376a4558/3fa9b400>
>>esi; c047c8e0 <eeprom_driver+0/e0>

Trace; c0104d7f <show_stack+7f/a0>
Trace; c0104f1a <show_registers+15a/1c0>
Trace; c0105184 <die+164/2e0>
Trace; c0119936 <do_page_fault+356/68d>
Trace; c0104853 <error_code+4f/54>
Trace; c02f1aa1 <eeprom_attach_adapter+21/30>
Trace; c02ee704 <i2c_add_driver+b4/e0>
Trace; c050a652 <eeprom_init+12/40>
Trace; c04ee8ab <do_initcalls+2b/c0>
Trace; c0100302 <init+32/130>
Trace; c0101351 <kernel_thread_helper+5/14>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c02f0924 <.text.lock.i2c_core+1be/1da>
00000000 <_EIP>:
Code;  c02f0924 <.text.lock.i2c_core+1be/1da>
   0:   90                        nop
Code;  c02f0925 <.text.lock.i2c_core+1bf/1da>
   1:   90                        nop
Code;  c02f0926 <.text.lock.i2c_core+1c0/1da>
   2:   90                        nop
Code;  c02f0927 <.text.lock.i2c_core+1c1/1da>
   3:   90                        nop
Code;  c02f0928 <.text.lock.i2c_core+1c2/1da>
   4:   90                        nop
Code;  c02f0929 <.text.lock.i2c_core+1c3/1da>
   5:   90                        nop
Code;  c02f092a <.text.lock.i2c_core+1c4/1da>
   6:   90                        nop
Code;  c02f092b <.text.lock.i2c_core+1c5/1da>
   7:   90                        nop
Code;  c02f092c <.text.lock.i2c_core+1c6/1da>
   8:   90                        nop
Code;  c02f092d <.text.lock.i2c_core+1c7/1da>
   9:   90                        nop
Code;  c02f092e <.text.lock.i2c_core+1c8/1da>
   a:   90                        nop
Code;  c02f092f <.text.lock.i2c_core+1c9/1da>
   b:   90                        nop
Code;  c02f0930 <.text.lock.i2c_core+1ca/1da>
   c:   90                        nop
Code;  c02f0931 <.text.lock.i2c_core+1cb/1da>
   d:   90                        nop
Code;  c02f0932 <.text.lock.i2c_core+1cc/1da>
   e:   90                        nop
Code;  c02f0933 <.text.lock.i2c_core+1cd/1da>
   f:   90                        nop
Code;  c02f0934 <.text.lock.i2c_core+1ce/1da>
  10:   90                        nop
Code;  c02f0935 <.text.lock.i2c_core+1cf/1da>
  11:   90                        nop
Code;  c02f0936 <.text.lock.i2c_core+1d0/1da>
  12:   90                        nop
Code;  c02f0937 <.text.lock.i2c_core+1d1/1da>
  13:   90                        nop
Code;  c02f0938 <.text.lock.i2c_core+1d2/1da>
  14:   90                        nop
Code;  c02f0939 <.text.lock.i2c_core+1d3/1da>
  15:   90                        nop
Code;  c02f093a <.text.lock.i2c_core+1d4/1da>
  16:   90                        nop
Code;  c02f093b <.text.lock.i2c_core+1d5/1da>
  17:   90                        nop
Code;  c02f093c <.text.lock.i2c_core+1d6/1da>
  18:   90                        nop
Code;  c02f093d <.text.lock.i2c_core+1d7/1da>
  19:   90                        nop
Code;  c02f093e <.text.lock.i2c_core+1d8/1da>
  1a:   90                        nop
Code;  c02f093f <.text.lock.i2c_core+1d9/1da>
  1b:   90                        nop
Code;  c02f0940 <i2c_detect+0/500>
  1c:   55                        push   %ebp
Code;  c02f0941 <i2c_detect+1/500>
  1d:   89 e5                     mov    %esp,%ebp
Code;  c02f0943 <i2c_detect+3/500>
  1f:   57                        push   %edi
Code;  c02f0944 <i2c_detect+4/500>
  20:   56                        push   %esi
Code;  c02f0945 <i2c_detect+5/500>
  21:   53                        push   %ebx
Code;  c02f0946 <i2c_detect+6/500>
  22:   83 ec 3c                  sub    $0x3c,%esp
Code;  c02f0949 <i2c_detect+9/500>
  25:   8b 55 08                  mov    0x8(%ebp),%edx
Code;  c02f094c <i2c_detect+c/500>
  28:   8b 42 0c                  mov    0xc(%edx),%eax

This decode from eip onwards should be reliable

Code;  c02f094f <i2c_detect+f/500>
00000000 <_EIP>:
Code;  c02f094f <i2c_detect+f/500>   <==   0:   81 78 20 00 00 05 00      cmpl   $0x50000,0x20(%eax)   <==Code;  c02f0956 <i2c_detect+16/500>
   7:   c7 45 e4 e7 23 00 00      movl   $0x23e7,0xffffffe4(%ebp)
Code;  c02f095d <i2c_detect+1d/500>
   e:   0f 94 c0                  sete   %al
Code;  c02f0960 <i2c_detect+20/500>
  11:   0f b6 c0                  movzbl %al,%eax
Code;  c02f0963 <i2c_detect+23/500>
  14:   85                        .byte 0x85

<0>Kernel panic - not syncing: Attempted to kill init!

1 warning and 1 error issued.  Results may not be reliable.

(gdb) x/30i 0xc02f094f
0xc02f094f <i2c_detect+15>:     cmpl   $0x50000,0x20(%eax)
0xc02f0956 <i2c_detect+22>:     movl   $0x23e7,0xffffffe4(%ebp)
0xc02f095d <i2c_detect+29>:     sete   %al
0xc02f0960 <i2c_detect+32>:     movzbl %al,%eax
0xc02f0963 <i2c_detect+35>:     test   %eax,%eax
0xc02f0965 <i2c_detect+37>:     mov    %eax,0xffffffe8(%ebp)
0xc02f0968 <i2c_detect+40>:     je     0xc02f0e1c <i2c_detect+1244>
0xc02f096e <i2c_detect+46>:     mov    0xffffffe8(%ebp),%eax
0xc02f0971 <i2c_detect+49>:     test   %eax,%eax
0xc02f0973 <i2c_detect+51>:     je     0xc02f0df7 <i2c_detect+1207>
0xc02f0979 <i2c_detect+57>:     mov    0xc(%ebp),%edx
0xc02f097c <i2c_detect+60>:     movl   $0xc047bf00,0xffffffd8(%ebp)
0xc02f0983 <i2c_detect+67>:     movl   $0xc047bf00,0xffffffd4(%ebp)
0xc02f098a <i2c_detect+74>:     movl   $0xc047bf04,0xffffffdc(%ebp)
0xc02f0991 <i2c_detect+81>:     mov    (%edx),%eax
0xc02f0993 <i2c_detect+83>:     test   %eax,%eax
0xc02f0995 <i2c_detect+85>:     cmove  0xffffffd8(%ebp),%eax
0xc02f0999 <i2c_detect+89>:     mov    %eax,0xffffffe0(%ebp)
0xc02f099c <i2c_detect+92>:     mov    0x4(%edx),%eax
0xc02f099f <i2c_detect+95>:     test   %eax,%eax
0xc02f09a1 <i2c_detect+97>:     cmove  0xffffffdc(%ebp),%eax
0xc02f09a5 <i2c_detect+101>:    mov    %eax,0xffffffdc(%ebp)
0xc02f09a8 <i2c_detect+104>:    mov    0x8(%edx),%eax
0xc02f09ab <i2c_detect+107>:    test   %eax,%eax
0xc02f09ad <i2c_detect+109>:    cmove  0xffffffd8(%ebp),%eax
0xc02f09b1 <i2c_detect+113>:    mov    %eax,0xffffffd8(%ebp)
0xc02f09b4 <i2c_detect+116>:    mov    0xc(%edx),%eax
0xc02f09b7 <i2c_detect+119>:    movl   $0x0,0xfffffff0(%ebp)
0xc02f09be <i2c_detect+126>:    test   %eax,%eax
0xc02f09c0 <i2c_detect+128>:    cmove  0xffffffd4(%ebp),%eax

I hope this helps,
            Miles

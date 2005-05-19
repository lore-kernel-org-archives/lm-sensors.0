From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd05032221123da2f1b2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I won't include the gdb code listing, since I checked and it hasn't
changed as a result of the patches.

Here is what I get with Jean and Andrew's patches combined:

Unable to handle kernel paging request at virtual address f8e813d4
c020c98d
*pde = 00000000
Oops: 0002 [#1]
CPU:     0
EIP:      0060:[<c020c98d>}    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202   (2.6.12-rc1)
eax: f8e81000 ebx: f7c00240 ecx: f7c00538 edx: 0000003f
esi: 00000001 edi: 00000001 epb: f7c21db0 esp: f7c21da8
Warning (Oops_set_regs): garbage 'epb: f7c21db0 esp: f7c21da8' at end
of register line ignored
ds: 007b es: 007b ss: 0068
Stack: f7c00708 00000001 f7c21dc4 c027f2e5 f7c00538 00000000 f7c00540 f7c21e20
       c027fd8a f7c00708 00000000 f7c21e35 ffffffff c03342e0 30000000 f7c23530
       f7c21e08 c0115d41 c17fca20 f7c21e08 c17fca20 00000286 00000000 f7c00540
Call trace:
[<c010400f>] show_stack+0x7f/0xa0
[<c01041aa>] show_registers+0x15a/0x1c0
[<c01043ac>] die+0xfc/0x190
[<c011438b>] do_page_fault+0x31b/0x670
[<c0103c43>] error_code+0x2b/0x30
[<c027f2e5>] i2c_start+0x25/0x60
[<c027fd8a>] bit_xfer+0x1a/0x690
[<c027bc48>] i2c_transfer+0x68/0xb0
[<c027cc39>] i2c_smbus_xfer_emulated+0xb9/0x3b0
[<c027d05f>] i2c_smbus_xfer+0x12f/0x220
[<c027e17a>] i2c_detect+0x23a/0x500
[<c027f051>] eeprom_attach_adapter+0x21/0x30
[<c027b303>] i2c_add_driver+0xd3/0x100
[<c0466452>] eeprom_init+0x12/0x40
[<c044c8ab>] do_initcalls+0x2b/0xc0
[<c0100302>] init+0x32/0x130
[<c0101301>] kernel_thread_helper+0x5/0x14
Code: 00 00 8b 74 24 04 8b 1c 24 c9 c3 8d 76 00 55 89 e5 83 ec 08 8b
4d 08 89 1c 24 89 74 24 04 8b 19 0f b6 51 04 8b 83 00 09 00 00 42 <88>
90 d4 03 00 00 8b b3 00 09 00 00 0f b6 86 d5 03 00 00 0f b6


>>EIP; c020c98d <nvidia_gpio_setsda+1d/70>   <==
>>eax; f8e81000 <pg0+389c7000/3fb44400>
>>ebx; f7c00240 <pg0+37746240/3fb44400>
>>ecx; f7c00538 <pg0+37746538/3fb44400>

Trace; c010400f <show_stack+7f/a0>
Trace; c01041aa <show_registers+15a/1c0>
Trace; c01043ac <die+fc/190>
Trace; c011438b <do_page_fault+31b/670>
Trace; c0103c43 <error_code+2b/30>
Trace; c027f2e5 <i2c_start+25/60>
Trace; c027fd8a <bit_xfer+1a/690>
Trace; c027bc48 <i2c_transfer+68/b0>
Trace; c027cc39 <i2c_smbus_xfer_emulated+b9/3b0>
Trace; c027d05f <i2c_smbus_xfer+12f/220>
Trace; c027e17a <i2c_detect+23a/500>
Trace; c027f051 <eeprom_attach_adapter+21/30>
Trace; c027b303 <i2c_add_driver+d3/100>
Trace; c0466452 <eeprom_init+12/40>
Trace; c044c8ab <do_initcalls+2b/c0>
Trace; c0100302 <init+32/130>
Trace; c0101301 <kernel_thread_helper+5/14>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c020c962 <nvidia_gpio_setscl+62/70>
00000000 <_EIP>:
Code;  c020c962 <nvidia_gpio_setscl+62/70>
   0:   00 00                     add    %al,(%eax)
Code;  c020c964 <nvidia_gpio_setscl+64/70>
   2:   8b 74 24 04               mov    0x4(%esp),%esi
Code;  c020c968 <nvidia_gpio_setscl+68/70>
   6:   8b 1c 24                  mov    (%esp),%ebx
Code;  c020c96b <nvidia_gpio_setscl+6b/70>
   9:   c9                        leave
Code;  c020c96c <nvidia_gpio_setscl+6c/70>
   a:   c3                        ret
Code;  c020c96d <nvidia_gpio_setscl+6d/70>
   b:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c020c970 <nvidia_gpio_setsda+0/70>
   e:   55                        push   %ebp
Code;  c020c971 <nvidia_gpio_setsda+1/70>
   f:   89 e5                     mov    %esp,%ebp
Code;  c020c973 <nvidia_gpio_setsda+3/70>
  11:   83 ec 08                  sub    $0x8,%esp
Code;  c020c976 <nvidia_gpio_setsda+6/70>
  14:   8b 4d 08                  mov    0x8(%ebp),%ecx
Code;  c020c979 <nvidia_gpio_setsda+9/70>
  17:   89 1c 24                  mov    %ebx,(%esp)
Code;  c020c97c <nvidia_gpio_setsda+c/70>
  1a:   89 74 24 04               mov    %esi,0x4(%esp)
Code;  c020c980 <nvidia_gpio_setsda+10/70>
  1e:   8b 19                     mov    (%ecx),%ebx
Code;  c020c982 <nvidia_gpio_setsda+12/70>
  20:   0f b6 51 04               movzbl 0x4(%ecx),%edx
Code;  c020c986 <nvidia_gpio_setsda+16/70>
  24:   8b 83 00 09 00 00         mov    0x900(%ebx),%eax
Code;  c020c98c <nvidia_gpio_setsda+1c/70>
  2a:   42                        inc    %edx

This decode from eip onwards should be reliable

Code;  c020c98d <nvidia_gpio_setsda+1d/70>
00000000 <_EIP>:
Code;  c020c98d <nvidia_gpio_setsda+1d/70>   <==   0:   88 90 d4 03 00 00         mov    %dl,0x3d4(%eax)   <==Code;  c020c993 <nvidia_gpio_setsda+23/70>
   6:   8b b3 00 09 00 00         mov    0x900(%ebx),%esi
Code;  c020c999 <nvidia_gpio_setsda+29/70>
   c:   0f b6 86 d5 03 00 00      movzbl 0x3d5(%esi),%eax
Code;  c020c9a0 <nvidia_gpio_setsda+30/70>
  13:   0f                        .byte 0xf
Code;  c020c9a1 <nvidia_gpio_setsda+31/70>
  14:   b6                        .byte 0xb6

<0>Kernel panic - not syncing: Attempted to kill init!

From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd05032315198e0b431@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I tried building nvidiafb into the kernel and using nvidiafb in the
"append" arguments.  I set "CONFIG_I2C_CHARDEV=3Dm" to get around the
immediate crash.  When I booted, the nvidiafb driver worked, but the
crash still occurred when the DS1621 sensor driver came into
operation.  The Code: listing is identical to the previous scenario.

CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_ALGOBIT=3Dy
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ALGOPCA=3Dy
CONFIG_I2C_ISA=3Dy
CONFIG_I2C_NFORCE2=3Dy
CONFIG_SENSORS_DS1621=3Dy

drivers/is/i2c-algo-pca.c:382: c0434240
drivers/i2c/algos/i2c-algo-bit.c:553: c04341a0
Unable to handle kernel paging request at virtual address f8e813d4
 printing eip:
c020cccd
*pde =3D 37e4d067
*pte =3D 00000000
Oops: 0002 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:     0
EIP:      0060:[<c020cccd>}    Not tainted VLI
EFLAGS: 00010206   (2.6.12-rc1)
EIP is at nvidia_gpio_setsda+0x1d/0x70
eax: f8e81000 ebx: f7c00244 ecx: f7c0053c edx: 0000003f
esi: 00000001 edi: 00000001 epb: f7c21db0 esp: f7c21da8
ds: 007b es: 007b ss: 0068
Process swapper (pid: 1, threadinfo=F7c20000 task=C17fca20)
Stack: f7c0070c 00000001 f7c21dc4 c02be0a5 f7c0053c 00000000 f7c00544 f7c21=
e20
           c02beb4a f7c0070c 00000000 f7c21e35 ffffffff c0373a20
30000000 f7c23438
           f7c21e08 c0115d41 c17fca20 f7c21e08 c17fca20 00000086
00000000 f7c00544
Call trace:
[<c010400f>] show_stack+0x7f/0xa0
[<c01041aa>] show_registers+0x15a/0x1c0
[<c01043ac>] die+0xfc/0x190
[<c011438b>] do_page_fault+0x31b/0x670
[<c0103c43>] error_code+0x2b/0x30
[<c02be0a5>] i2c_start+0x25/0x60
[<c02beb4a>] bit_xfer+0x1a/0x690
[<c027bf88>] i2c_transfer+0x68/0xb0
[<c027cf79>] i2c_smbus_xfer_emulated+0xb9/0x3b0
[<c027d39f>] i2c_smbus_xfer+0x12f/0x220
[<c027d8fa>] i2c_detect+0x23a/0x500
[<c029c251>] ds1621_attach_adapter+0x21/0x30
[<c027b643>] i2c_add_driver+0xd3/0x100
[<c04cb0b2>] ds1621_init+0x12/0x40
[<c04b08ab>] do_initcalls+0x2b/0xc0
[<c0100302>] init+0x32/0x130
[<c0101301>] kernel_thread_helper+0x5/0x14
Code: 00 00 8b 74 24 04 8b 1c 24 c9 c3 8d 76 00 55 89 e5 83 ec 08 8b
4d 08 89 1c 24 89 74 24 04 8b 19 0f b6 51 04 8b 83 00 09 00 00 42 <88>
90 d4 03 00 00 8b b3 00 09 00 00 0f b6 86 d5 03 00 00 0f b6
<0>Kernel panic - not syncing: Attempted to kill init!

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: 2.5.64 - oops in i2c-proc.o
Message-Id: <20030307084701.GA16877@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I was trying to add some of the i2c drivers that are currently in your
CVS tree, to the main kernel tree, but when testing them, I would get an
oops in i2c_register_entry() on the line:
	client_tbl->de->owner =3D client->driver->owner;
right at the end of the function.  I've included the oops in full at the en=
d of
this message.

If I enable DEBUG in that file, I get the message:
i2c-proc.o: NULL pointer when trying to install fill_inode fix!
so I'm guessing something isn't being set up correctly somewhere :)

In looking at the differences between the CVS and kernel code, I don't
see any differences around setting up drivers and their syctl files.

I'm seeing this when using the i2c-piix4 and eeprom modules, and when
using the i2c-isa and w83781d modules (they are all that I have the
hardware for right now.)

Any suggestions?

thanks,

greg k-h

------------
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
f0c4630a
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<f0c4630a>]    Not tainted
EFLAGS: 00010282
EIP is at i2c_register_entry+0x1ca/0x1e0 [i2c_proc]
eax: f0c58880   ebx: edb6a000   ecx: ed414000   edx: 00000000
esi: edb6a000   edi: 00000000   ebp: 00000019   esp: ebd57ef4
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 895, threadinfo=EBd56000 task=ECd878c0)
Stack: edb6a108 0000044c 00000100 00000019 ec157740 00000001 00000000 ed414=
000=20
       ed414000 f0c53817 ed414000 f0c55933 f0c5781c 00000001 f0c5593b f0c55=
933=20
       ed41403c ed414000 00000030 00000000 00000290 f0c3a540 00000290 f0c47=
1c2=20
Call Trace:
 [<f0c53817>] w83781d_detect+0x7f7/0x8c0 [w83781d]
 [<f0c55933>] +0x109/0x256 [w83781d]
 [<f0c5781c>] w83782d_isa_dir_table_template+0x0/0x478 [w83781d]
 [<f0c5593b>] +0x111/0x256 [w83781d]
 [<f0c55933>] +0x109/0x256 [w83781d]
 [<f0c3a540>] isa_adapter+0x0/0x100 [i2c_isa]
 [<f0c471c2>] i2c_detect+0x442/0x480 [i2c_proc]
 [<f0c3a540>] isa_adapter+0x0/0x100 [i2c_isa]
 [<f0c57080>] w83781d_driver+0x0/0x38 [w83781d]
 [<f0c53014>] +0x14/0x20 [w83781d]
 [<f0c3a540>] isa_adapter+0x0/0x100 [i2c_isa]
 [<f0c56fc0>] addr_data+0x0/0x40 [w83781d]
 [<f0c53020>] w83781d_detect+0x0/0x8c0 [w83781d]
 [<f0c404cf>] i2c_add_driver+0xef/0x110 [i2c_core]
 [<f0c3a540>] isa_adapter+0x0/0x100 [i2c_isa]
 [<f0c58880>] +0x0/0x120 [w83781d]
 [<f0c38014>] +0x14/0x20 [w83781d]
 [<f0c57080>] w83781d_driver+0x0/0x38 [w83781d]
 [<f0c559fe>] +0x1d4/0x256 [w83781d]
 [<c012fb57>] sys_init_module+0x147/0x210
 [<c0109087>] syscall_call+0x7/0xb

Code: 89 42 24 8b 44 24 08 83 c4 14 5b 5e 5f 5d c3 8d b4 26 00 00=20

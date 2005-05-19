From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050315050746.GB13009@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Mar 14, 2005 at 05:18:23PM -0800, Andrew Morton wrote:
>=20
> I shall cheerily add Greg to the Cc and add this to my
> stuff-to-fix-for-2.6.12 pile, thanks.
>=20
> (If it turns out to be a -mm-only bug then it'll still get attention when
> the great bugspam starts, so no loss)
>=20
> Miles Lane <miles.lane@gmail.com> wrote:
> >
> > I tried Jean Delvare and Philip Edelbrock but have gotten no reply.
> >=20
> > I2c /dev/ entries driver
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
> >  Printing eip:
> > C028bbc2
> > *pde =3D 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > Modules linked in:
> > CPU:     0
> > EIP:     0060:[<c028bbc2>]   Not tainted VLI
> > EFLAGS:  00010282   (2.6.11-mm3)
> > EIP is at i2c_add_driver+0xa2/0xd0
> > Eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7e99504
> > Esi: c03f5260   edi: 00000000   ebp: f7c21fa4   esp: f7c21f90
> > Ds: 007b   es: 007b   ss: 0068
> > Process swapper (pid: 1, threadinfo=F7c20000 task=C17fca40)
> > Stack: f7c00540 c03f5264 00000000 00000000 00000000 f7c21fbc c0480695 c=
03f5260
> >        c03724f8 c03f5140 c048d204 f7c21fd8 c04668ab c01002d0 00000000 0=
0000000
> >        c01002d0 00000000 f7c21fec c0100302 0000007b 0000007b ffffffff 0=
0000000
> > Call Trace:
> >  [<c010404f>] show_stack+0x7f/0xa0
> >  [<c01041ea>] show_registers+0x15a/0x1c0
> >  [<c01043e0>] die+0xf0/0x190
> >  [<c011450b>] do_page_fault+0x31b/0x670
> >  [<c0103c83>] error_code+0x2b/0x30
> >  [<c0480695>] i2c_dev_init+0x55/0xa0
> >  [<c04668ab>] do_initcalls+0x2b/0xc0
> >  [<c0100302>] init+0x32/0x130
> >  [<c0101351>] kernel_thread_helper+0x5/0x14
> > Code: e5 e8 ff f6 46 2c 01 74 30 8b 1d a0 4e 3f c0 8b 03 0f 18 00 90
> > 81 fb a0 4e 3f c0 74 1c 8d 83 94 fe ff ff 89 04 24 ff 56 30 1b <8b> 03
> > 0f 18 00 90 81 fb a0 4e 3f c0 75 e4 ff 05 b0 4e 3f c0 0f
> > <0>Kernel panic ?___" not syncing: Attempted to kill init!

If you make the i2c core a module, does that change anything?  I can't
duplicate this here.

thanks,

greg k-h

(.config is below...)


> >=20
> > CONFIG_I2C=3Dy
> > CONFIG_I2C_CHARDEV=3Dy
> >=20
> > #
> > # I2C Algorithms
> > #
> > CONFIG_I2C_ALGOBIT=3Dy
> > CONFIG_I2C_ALGOPCF=3Dy
> > CONFIG_I2C_ALGOPCA=3Dy
> >=20
> > #
> > # I2C Hardware Bus support
> > #
> > CONFIG_I2C_ISA=3Dm
> > CONFIG_I2C_NFORCE2=3Dy
> >=20
> > #
> > # Hardware Sensors Chip support
> > #
> > CONFIG_I2C_SENSOR=3Dm
> > CONFIG_SENSORS_ADM1021=3Dm
> > CONFIG_SENSORS_ADM1025=3Dm
> > CONFIG_SENSORS_ADM1026=3Dm
> > CONFIG_SENSORS_ADM1031=3Dm
> > CONFIG_SENSORS_ASB100=3Dm
> > CONFIG_SENSORS_DS1621=3Dm
> > CONFIG_SENSORS_FSCHER=3Dm
> > CONFIG_SENSORS_GL518SM=3Dm
> > CONFIG_SENSORS_IT87=3Dm
> > CONFIG_SENSORS_LM75=3Dm
> > CONFIG_SENSORS_LM77=3Dm
> > CONFIG_SENSORS_LM78=3Dm
> > CONFIG_SENSORS_LM80=3Dm
> > CONFIG_SENSORS_LM83=3Dm
> > CONFIG_SENSORS_LM85=3Dm
> > CONFIG_SENSORS_LM87=3Dm
> > CONFIG_SENSORS_LM90=3Dm
> > CONFIG_SENSORS_MAX1619=3Dm
> > CONFIG_SENSORS_PC87360=3Dm
> > CONFIG_SENSORS_SMSC47B397=3Dm
> > CONFIG_SENSORS_SIS5595=3Dm
> > CONFIG_SENSORS_SMSC47M1=3Dm
> > CONFIG_SENSORS_VIA686A=3Dm
> > CONFIG_SENSORS_W83781D=3Dm
> > CONFIG_SENSORS_W83L785TS=3Dm
> > CONFIG_SENSORS_W83627HF=3Dm
> >=20
> > #
> > # Other I2C Chip support
> > #
> > CONFIG_I2C_DEBUG_CORE=3Dy
> > CONFIG_I2C_DEBUG_ALGO=3Dy
> > CONFIG_I2C_DEBUG_BUS=3Dy
> > CONFIG_I2C_DEBUG_CHIP=3Dy

--=20

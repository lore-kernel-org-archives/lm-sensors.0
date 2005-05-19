From: Alexander.Povolotsky@marconi.com (Povolotsky, Alexander)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: question re usage of  interruptible_sleep_on( ) function call  in
Message-Id: <313680C9A886D511A06000204840E1CF0A6475F3@whq-msgusr-02.pit.comms.marconi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Hello,
> =20
> I have MPC880 microprocessor based board with single 24C02 I2C EEPROM,
> connected to the I2C bus.
>=20
Per suggestion from Tom Rini I copied i2c-algo-8xx.h from Linux 2.4.26
 into 2.6.10-rc3 code source and made couple small changes
to allow building of the 8xx code with I2C configured, please see:=20
http://archives.andrew.net.au/lm-sensors/msg28725.html
> =20
> Currently booting of the board hangs in the I2C driver after invocation of
> interruptible_sleep_on( )
>  function call  in cpm_iic_tryaddress( ) function (in i2c-algo-8xx.c
> file).
>=20
> Is it appropriate to use the interruptible_sleep_on( ) function at the
> kernel booting stage ?
>  (I personally do not think so - since such usage prevents further kernel
> booting - as observed).
> What should be done in this code to avoid slleping ?
>=20
> I presume that the usage of the interruptible_sleep_on( ) function would
> be appropriate if the=20
> I2C would be configured as a module (after the kernel booting is
> completed) ?
> Follow up question:  is it really expected to do I2C initialization ONLY
> as a module after the kernel booting ?
> (is it documented anyplace ?)=20
>=20
> The (end of) log buffer shows following:
> ....
> <6>i2c /dev entries driver.
> <7>device class 'i2c-dev': registering.
> <7>bus i2c:add driver dev_driver.
> <7>i2c-core: driver dev_driver registered
> <6>i2c-rpx: i2c MPC8xx driver.
> <7>DEV: registering device: ID =3D'i2c-0'.
> <7>CLASS: registering class device: ID=3D 'i2c-0'.
> <7>i2c_adapter i2c-0:Registered as minor 0.
> <7>CLASS:registering class device: ID =3D 'i2c-0'
> <7>i2c_adapter i2c-0: registered as adapter #0.
> <4>cpm_iic_init() - iip=FA203c80.
> <4>cpm_iic_init[132] Install ISR for IRQ 16.
> <6>CPM interrupt c0105d90 replacing c01f7a8c.
> <3>request_irq() returned -22  for CPM vector 32.
> <6> i2c-algo-8xx.o: scanning bus m8xx........
> <4>cpm_iic_tryaddress(cpm=C019b9f8,addr=3D0).
> <4>iip fa203c80, dp_addr 0x800.
> <4>iic_tbase 2048, r_tbase 2048
> <4>about to sleep
> .ABOVE LINE IS THE LAST ENTRY IN THE LOG BUFFER - THE BOOT HANGS
> THEREAFTER ...=20
>=20
> Here is the fragment of the cpm_iic_tryaddress( ) function in
> i2c-algo-8xx.c,
> where the problem takes place:
> ....=20
> //      save_flags(flags); cli();
>         i2c->i2c_i2cer =3D 0xff;
>         i2c->i2c_i2cmr =3D 0x13;  /* Enable some interupts */
>         i2c->i2c_i2mod =3D 1;     /* Enable */
>         i2c->i2c_i2com =3D 0x81;  /* Start master */
> //      restore_flags(flags);
>=20
>         if (cpm_debug > 1) printk("about to sleep\n");
>=20
>         /* wait for IIC transfer */
> interruptible_sleep_on(&iic_wait);
> if (signal_pending(current))
>         return -EIO;
>=20
> if (cpm_debug > 1) printk("back from sleep\n");
>=20
> if (tbdf->cbd_sc & BD_SC_NAK) {
>         if (cpm_debug > 1) printk("IIC try; no ack\n");
>         return 0;
> }
>=20
> if (tbdf->cbd_sc & BD_SC_READY) {
>         printk("IIC try; complete but tbuf ready\n");
> }
>=20
> return 1;
>=20
> ........
> Thanks,
> Best Regards,
> Alex=20
>=20
>=20

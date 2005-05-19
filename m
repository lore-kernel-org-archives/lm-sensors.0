From: Alexander.Povolotsky@marconi.com (Povolotsky, Alexander)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: 2.6.10-rc3 8xx (MPC 880) i2c driver - "about to sleep"
Message-Id: <313680C9A886D511A06000204840E1CF0A6475D6@whq-msgusr-02.pit.comms.marconi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Hi,
>=20
> Sorry for bothering you  again - I will appreciate your
> opinion/advise/guidance !
>=20
> What is your interpretation of entries I found in the log buf with regards
> to I2C driver ?=20
> .....
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
> ........
BOOTING HANGS FROM HERE !!!!

> The board is equipped with M24Cxx-x Serial I2C bus EEPROM=20
> - does above means that the EEPROM device was not detected on the I2C bus
> ?
Do I need to supply in the code the addresses to be scanned ?

> Thanks,
> Alex
>=20

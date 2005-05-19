From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE36F913@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf:

Please check the attached log files
i2cdump 0 0x50   ---> message1
i2cdump 0 0x50 c   ---> message2
i2cdump 0 0x50   ---> message3
i2cdump 0 0x50 c   ---> message4

The following is the dump output.

[root@ /usr/src/linux]# lsmod|grep i2c
i2c_dev                12800  0
i2c_ali1563             8452  0
i2c_core               25728  2 i2c_dev,i2c_ali1563
[root@ /usr/src/linux]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 ff 07 0d 0b 01 48 00 04 75 75 02 82 04 04 01    ..????H.?uu?????
10: 0e 04 0c 01 02 26 c0 a0 75 00 00 50 3c 50 2d 80    ?????&??u..P<P-?
20: ac 00 50 50 00 00 00 00 00 46 50 30 32 75 00 00    ?.PP.....FP02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3d    ...............40: 0=
1 00 7f 7f 9e 00 00 00 00 31 30 38 31 30 20 20    ?.???....10810
50: 20 20 20 20 20 20 20 20 20 20 20 00 55 05 03 00               .U??.
60: ac 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
70: 00 00 00 00 00 00 00 00 00 00 00 20 4f 02 00 00    ........... O?..
80: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff    ................
a0: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: ac 00 00 00 00 00 00 00 00 00 00 28 ff 00 00 00    ?..........(....
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: ac 00 8b ff 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 28    ..............?(
[root@ /usr/src/linux]# i2cdump 0 0x50 c
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
10: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
20: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
30: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
40: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
50: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
60: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
70: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
80: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
90: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
a0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
b0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
c0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
d0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
e0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
f0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
[root@ /usr/src/linux]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 28 00 07 0d 0b 01 48 00 04 75 75 02 82 04 04 01    (.????H.?uu?????
10: 0e 04 0c 01 02 26 c0 a0 75 00 00 50 3c 50 2d 80    ?????&??u..P<P-?
20: ac 00 50 50 00 00 00 00 00 46 50 30 32 75 00 00    ?.PP.....FP02u..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3d    ...............40: 0=
1 00 7f 7f 9e 00 00 00 00 31 30 38 31 30 20 20    ?.???....10810
50: 20 20 20 20 20 20 20 20 20 20 20 00 55 05 03 00               .U??.
60: ac 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
70: 00 00 00 00 00 00 00 00 00 00 00 20 4f 02 00 00    ........... O?..
80: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff    ................
a0: ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: ac 00 00 00 00 00 00 00 00 00 00 28 ff 00 00 00    ?..........(....
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: ac 00 8b ff 00 00 00 00 00 00 00 00 00 00 00 00    ?.?.............
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 28    ..............?(
[root@ /usr/src/linux]# i2cdump 0 0x50 c
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
10: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
20: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
30: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
40: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
50: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
60: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
70: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
80: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
90: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
a0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
b0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
c0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
d0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
e0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
f0: 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28    ((((((((((((((((
[root@ /usr/src/linux]#



Best Regards
Chunhao



> -----Original Message-----
> From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> Sent: 2005?4?6? 16:11
> To: PI14 HUANG0
> Subject: RE: We will port w83792d.c to linux-2.6
>=20
> Hi,
>=20
> Sorry I was too creative, just woken up :).
>=20
> What we need is, when we write command to the register, to be sure that
> what we wrote hardware accepted.
>=20
>         outb_p(((addr & 0x7f) << 1) | (rw & 0x01), SMB_HST_ADD);
>         outb_p(inb_p(SMB_HST_CNTL2) | (size << 3), SMB_HST_CNTL2);
>=20
> So above command will not change the register. Resulting in that strange
> behaviur. That I concluded from logs last week (friday email)
>=20
>         /* Write the command register */
>=20
>   if (inb_p(SMB_HST_CNTL2)&0x38!=3D(size<<3)) {
>   dev_warn(&a->dev, "SMBUS command not accepted: WAS: %02x, STS=3D%02x,
> CNTL1=3D%02x, "
>                 "CNTL2=3D%02x, CMD=3D%02x, ADD=3D%02x, DAT0=3D%02x, DAT1=
=3D%02x\n",
>                 size<<3,inb_p(SMB_HST_STS), inb_p(SMB_HST_CNTL1),
> 		inb_p(SMB_HST_CNTL2),
>                 inb_p(SMB_HST_CMD), inb_p(SMB_HST_ADD),
> 		inb_p(SMB_HST_DAT0),
>                 inb_p(SMB_HST_DAT1));
>=20
>   }
>=20
> Please check if my 0x38 mask really masks bits 5-3 but I think so :)
>=20
> > > i2cdump 0 0x50
> > > i2cdump 0 0x50 c
> > > i2cdump 0 0x50
> > > i2cdump 0 0x50 c
>=20
> Please do that dumps (please omit loading the eeprom module and also your
> chip module)
>=20
> Again sorry that I confused you.
>=20
> Regards
>=20
> Rudolf
>=20
> On Wed, 6 Apr 2005 Huang0@Winbond.com.tw wrote:
>=20
> > Hi Rudolf
> >
> > > Please can you modify the driver to check if the written value matche=
s?
> > > (readback of HST_CNTL2) bits 5-3
> > >
> > > outb ( .. value...)
> > >
> > > if (inp(/...)&0x38  !=3D value&0x38 printk("BAD FAULT IN DOS EXTENDER=
 :)");
> >
> >
> > I'm sorry, I'm completely fazed by my smart card project all these days.
> >
> > Do you mean I should add the above debug codes at the beginning of
> > ali1563_transaction() just like this? Or could you give me more informa=
tion
> > about it?
> >
> > static int ali1563_transaction(struct i2c_adapter * a)
> > {
> >         u32 data;
> >         int timeout;
> >
> > 		outb_p( 0x33,SMB_HST_CNTL2); //0x33 is a random value
> > 		if (inb_p(SMB_HST_CNTL2)&0x38  !=3D 0x33&0x38
> > 			printk("BAD FAULT IN DOS EXTENDER :)");
> >
> > 		dev_dbg(&a->dev, "Transaction (pre): STS=3D%02x, CNTL1=3D%02x, "
> > ........................................
> >
> > Thanks
> > Best Regards
> > Chunhao
> >
> >
> > > -----Original Message-----
> > > From: Rudolf Marek [mailto:R.Marek@sh.cvut.cz]
> > > Sent: 2005?4?6? 15:25
> > > To: PI14 HUANG0
> > > Cc: sensors@Stimpy.netroedge.com; PI10 LHHsu; PI14 DZSHEN
> > > Subject: RE: We will port w83792d.c to linux-2.6
> > >
> > >
> > > >
> > > > Hi Chunhao,
> > >
> > > Have you tried something with the ALI1563?  Our main question is why =
it
> > > sometimes ignores setting of mode of operation in status2 register.
> > >
> > > Please can you modify the driver to check if the written value matche=
s?
> > > (readback of HST_CNTL2) bits 5-3
> > >
> > > outb ( .. value...)
> > >
> > > if (inp(/...)&0x38  !=3D value&0x38 printk("BAD FAULT IN DOS EXTENDER=
 :)");
> > >
> > > you can test this with
> > >
> > > i2cdump 0 0x50
> > > i2cdump 0 0x50 c
> > > i2cdump 0 0x50
> > > i2cdump 0 0x50 c
> > >
> > > And then you should see if the command field has really changed or no=
t.
> > >
> > > thanks
> > >
> > > Rudolf
> > >
> > > >
> > > > > Btw, the ABit motherboard User Guild says that it supports 144-bi=
t wide
> > > > > Dual channel DDR 400/333 memory, but neither of the above two kin=
d memory
> > > > > is DDR 400/333. Although the above two kind of memory can work on=
 this
> > > > > Abit motherboard, Does it have something to do with our problem?
> > > > > We have no other ECC DDR memory here but the above two kind.
> > > >
> > > > No this is simply matter of SPD EEPROM on the memory module, if it =
works
> > > > it cant influence our bussiness.
> > > >
> > > >
> > > > >
> > > > > The dump result is(I dump is for three times, the result are same=
):
> > > > > Here I have a question:
> > > > > I'm using the address 50 to do the dump operation. How to judge t=
he
> address
> > > > > 50 is correct? I do not have a motherboard spec here.
> > > >
> > > > It is standart address for first slot.
> > > > http://download.micron.com/pdf/technotes/TN_04_42.pdf
> > > >
> > > > > [root@ /usr/src/linux]# sensors
> > > > > eeprom-i2c-0-50
> > > > > Adapter: SMBus ALi 1563 Adapter @ 5000
> > > > > Unknown EEPROM type (255).
> > > > COnsecutive byte read failed and I know why :)
> > > >
> > > >
> > > > > eeprom-i2c-0-50
> > > > > Adapter: SMBus ALi 1563 Adapter @ 5000
> > > > > Unknown EEPROM type (172)
> > > >
> > > > It is telling us favourite value "AC"
> > > >
> > > > >
> > > > > [root@ /usr/src/linux]# i2cdump 0 0x50
> > > > > No size specified (using byte-data access)
> > > > > WARNING! This program can confuse your I2C bus, cause data loss a=
nd
> worse!
> > > > > I will probe file /dev/i2c-0, address 0x50, mode byte
> > > > > Continue? [Y/n]
> > > > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 0123456789abcdef
> > > > > 00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?u=
u?????
> > > >
> > > > and here again.
> > > >
> > > > I bet that if you would do just after this "AC infected" dump the d=
ump
> in
> > > > "continuous mode" i2cdump 0 0x50 c we would get all "ac" values that
> > > > explains why we have them now in other
> > > > fields like byte #2.
> > > >
> > > > So I went again through the logs from wendnesday
> > > >
> > > > http://archives.andrew.net.au/lm-sensors/msg30326.html
> > > >
> > > > And I found that status register2 does NOT change when changing the=
 mode
> > > > ..BYTE_DATA versus to ..._DATA.
> > > >
> > > > Once we can get "consecutive byte reads" working
> > > >
> > > > i2cdump 0 0x50 c the memory detection will be working again because=
 the
> > > > driver uses this mode. (you can check the the binary
> > > >  cat /sys/bus/i2c/drivers/eeprom/0-0050/
> > > > detach_state  driver/       eeprom        name          power/
> > > > "eeprom" file in this directory.
> > > >
> > > > take a look to messgage3 from the 30th march.
> > > >
> > > >
> > > > In fact this files contains rest of i2cdump 0 0x50 for some reason
> > > > and this log ends just
> > > >
> > > > Mar 30 13:19:26 pi140001 kernel
> > > >
> > > > Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: size is
> > > I2C_SMBUS_BYTE_DATA!
> > > > Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: size is
> > > HST_CNTL2_BYTE_DATA!
> > > >
> > > ^^^^^^^^^^^^^^^^^^^^^^^
> > > >
> > > >  size is I2C_SMBUS_BYTE_DATA!
> > > > i2c_adapter i2c-0: size is HST_CNTL2_BYTE_DATA!
> > > > kernel: i2c_adapter i2c-0: rw =3D I2C_SMBUS_READ!
> > > > kernel: i2c-ali1563: ENTERING ali1563_transaction, line: 77
> > > > Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: Transaction (pr=
e):
> > > > STS=00, CNTL1=00, CNTL2=18, CMD=FF
> > > > , ADD=A1, DAT0=FF, DAT1=FF
> > > > Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: Transaction (po=
st):
> > > > STSB, CNTL1=00, CNTL2=18, CMD=FF, ADD=A1, DAT0=FF, DAT1=00
> > > >                   ^^^^^^^^
> > > > And after that the i2cdump 0 0x50 c  was invoked
> > > >
> > > > Mar 30 13:19:39 pi140001 kernel: i2c-ali1563: ENTERING ali1563_acce=
ss,
> line:
> > > 251
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is
> I2C_SMBUS_BYTE!
> > > >
> > > ^^^^^^^^^^^^^^^^
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is
> HST_CNTL2_BYTE!
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: rw =3D I2C_SMBU=
S_WRITE!
> > > > Mar 30 13:19:39 pi140001 kernel: i2c-ali1563: ENTERING
> ali1563_transaction,
> > > line: 77
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (pr=
e):
> > > > STS=00, CNTL1=00, CNTL2=18, CMD=00, ADD=A0, DAT0=FF, DAT1=00
> > > >                   ^^^^^^^^^
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (po=
st):
> > > > STSB, CNTL1=00, CNTL2=18, CMD=00, ADD=A0, DAT0=FF, DAT1=00
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is
> I2C_SMBUS_BYTE!
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is
> HST_CNTL2_BYTE!
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: rw =3D I2C_SMBU=
S_READ!
> > > > Mar 30 13:19:39 pi140001 kernel: i2c-ali1563: ENTERING
> > > > ali1563_transaction, line: 77
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (pr=
e):
> > > > STS=00, CNTL1=00, CNTL2=18, CMD=00
> > > > , ADD=A1, DAT0=FF, DAT1=00
> > > > Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (po=
st):
> > > > STSB, CNTL1=00, CNTL2=18, CMD=3D0
> > > > 0, ADD=A1, DAT0=FF, DAT1=00
> > > >
> > > > And because DAT0 is FF we get FF all the way.
> > > >
> > > > I'm sorry I must stop with this now. I must go to school and really=
 work
> > > > for myself. I will have time again next week. Maybe I will be able =
to
> read
> > > > emails during weekend (GPRS) so if you have something you want to k=
now
> try
> > > > to write me a mail.
> > > >
> > > > If you grep through message1 and message2 you could find that the m=
ode
> > > > of CTNTL2 changes but in message3 it does NOT. I dont know why. Ple=
ase
> try
> > > > to find this.
> > > >
> > > > cat message3 | awk '{print $12}' |sort |uniq
> > > >
> > > > This prints mostly the CNTL2 and its states
> > > >
> > > > The smart card mail is still in my queue. best would be if you just=
 find
> > > > some mailning list for smartcard devel people and ask the for coope=
ration
> > > > like us. If you want some superio example look to mmc/ directory in=
 2.6
> > > > kernels there is driver for some memory card using DMA and windbond=
 chip.
> > > > I dont know if it helps you.
> > > >
> > > > regards
> > > >
> > > > Rudolf
> > > >
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged confidential information contai=
ned in this
> email is intended for use only by the addressees as indicated by the orig=
inal
> author of this email. If you are not the addressee indicated in this emai=
l or
> are not responsible for delivery of the email to such person, please kind=
ly
> reply the sender indicating accordingly and delete all copies of it from =
your
> computer and network server immediately. We thank you for your cooperatio=
n.
> It is advisable that any unauthorized use of confidential information of
> Winbond is strictly prohibited; and any information in this email that do=
es
> not relate to the official business of Winbond shall be deemed as neither=
 given
> nor endorsed by
> Winbond.=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DIf your computer is unable to deco=
de Chinese font,
> please ignore the following message. They essentially repeat the&nbsp; En=
glish
> statement above.???????????????????, ?????????
> ????????. ????????????????????????????
> ?????, ????????????????????????????. ??
> ????, ??????. ????, ????????????????????
> ?????????. ??????????????,?????????????
> ?.
> >
-------------- next part --------------
A non-text attachment was scrubbed...
Name: debug_log.tar.gz
Type: application/x-gzip
Size: 2224 bytes
Desc: debug_log.tar.gz
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050406=
/1a6fc51c/debug_log.tar.gz

From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0504011024520.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Chunhao.

> Btw, the ABit motherboard User Guild says that it supports 144-bit wide
> Dual channel DDR 400/333 memory, but neither of the above two kind memory
> is DDR 400/333. Although the above two kind of memory can work on this
> Abit motherboard, Does it have something to do with our problem?
> We have no other ECC DDR memory here but the above two kind.

No this is simply matter of SPD EEPROM on the memory module, if it works
it cant influence our bussiness.


>
> The dump result is(I dump is for three times, the result are same):
> Here I have a question:
> I'm using the address 50 to do the dump operation. How to judge the addre=
ss
> 50 is correct? I do not have a motherboard spec here.

It is standart address for first slot.
http://download.micron.com/pdf/technotes/TN_04_42.pdf

> [root@ /usr/src/linux]# sensors
> eeprom-i2c-0-50
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Unknown EEPROM type (255).
COnsecutive byte read failed and I know why :)


> eeprom-i2c-0-50
> Adapter: SMBus ALi 1563 Adapter @ 5000
> Unknown EEPROM type (172)

It is telling us favourite value "AC"

>
> [root@ /usr/src/linux]# i2cdump 0 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ac ff 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????

and here again.

I bet that if you would do just after this "AC infected" dump the dump in
"continuous mode" i2cdump 0 0x50 c we would get all "ac" values that
explains why we have them now in other
fields like byte #2.

So I went again through the logs from wendnesday

http://archives.andrew.net.au/lm-sensors/msg30326.html

And I found that status register2 does NOT change when changing the mode
.BYTE_DATA versus to ..._DATA.

Once we can get "consecutive byte reads" working

i2cdump 0 0x50 c the memory detection will be working again because the
driver uses this mode. (you can check the the binary
 cat /sys/bus/i2c/drivers/eeprom/0-0050/
detach_state  driver/       eeprom        name          power/
"eeprom" file in this directory.

take a look to messgage3 from the 30th march.


In fact this files contains rest of i2cdump 0 0x50 for some reason
and this log ends just

Mar 30 13:19:26 pi140001 kernel

Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: size is I2C_SMBUS_BYTE_=
DATA!
Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: size is HST_CNTL2_BYTE_=
DATA!
                                                       ^^^^^^^^^^^^^^^^^^^^=
^^^

 size is I2C_SMBUS_BYTE_DATA!
i2c_adapter i2c-0: size is HST_CNTL2_BYTE_DATA!
kernel: i2c_adapter i2c-0: rw =3D I2C_SMBUS_READ!
kernel: i2c-ali1563: ENTERING ali1563_transaction, line: 77
Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: Transaction (pre):
STS=00, CNTL1=00, CNTL2=18, CMD=FF
, ADD=A1, DAT0=FF, DAT1=FF
Mar 30 13:19:26 pi140001 kernel: i2c_adapter i2c-0: Transaction (post):
STSB, CNTL1=00, CNTL2=18, CMD=FF, ADD=A1, DAT0=FF, DAT1=00
                  ^^^^^^^^
And after that the i2cdump 0 0x50 c  was invoked

Mar 30 13:19:39 pi140001 kernel: i2c-ali1563: ENTERING ali1563_access, line=
: 251
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is I2C_SMBUS_BYTE!
                                                           ^^^^^^^^^^^^^^^^
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is HST_CNTL2_BYTE!
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: rw =3D I2C_SMBUS_WRITE!
Mar 30 13:19:39 pi140001 kernel: i2c-ali1563: ENTERING ali1563_transaction,=
 line: 77
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (pre):
STS=00, CNTL1=00, CNTL2=18, CMD=00, ADD=A0, DAT0=FF, DAT1=00
                  ^^^^^^^^^
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (post):
STSB, CNTL1=00, CNTL2=18, CMD=00, ADD=A0, DAT0=FF, DAT1=00
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is I2C_SMBUS_BYTE!
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: size is HST_CNTL2_BYTE!
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: rw =3D I2C_SMBUS_READ!
Mar 30 13:19:39 pi140001 kernel: i2c-ali1563: ENTERING
ali1563_transaction, line: 77
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (pre):
STS=00, CNTL1=00, CNTL2=18, CMD=00
, ADD=A1, DAT0=FF, DAT1=00
Mar 30 13:19:39 pi140001 kernel: i2c_adapter i2c-0: Transaction (post):
STSB, CNTL1=00, CNTL2=18, CMD=3D0
0, ADD=A1, DAT0=FF, DAT1=00

And because DAT0 is FF we get FF all the way.

I'm sorry I must stop with this now. I must go to school and really work
for myself. I will have time again next week. Maybe I will be able to read
emails during weekend (GPRS) so if you have something you want to know try
to write me a mail.

If you grep through message1 and message2 you could find that the mode
of CTNTL2 changes but in message3 it does NOT. I dont know why. Please try
to find this.

cat message3 | awk '{print $12}' |sort |uniq

This prints mostly the CNTL2 and its states

The smart card mail is still in my queue. best would be if you just find
some mailning list for smartcard devel people and ask the for cooperation
like us. If you want some superio example look to mmc/ directory in 2.6
kernels there is driver for some memory card using DMA and windbond chip.
I dont know if it helps you.

regards

Rudolf

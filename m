From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Wed, 07 Dec 2005 20:06:03 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051207200602.GA7664@dnil.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 07, 2005 at 05:59:50PM +0800, Ymu at Winbond.com.tw wrote:
> Hi Rudolf, Jean,
> 
> Can you give some hints now?
> Frankly I have no idea about this issue yet.
> It seems the SMI caused system hang?
> 
> 
> Hi Daniel,
> Yesterday I send the new datasheet to you.
> I received the reject mail from Jean just now, so let assume you have
> received the datasheet now :)
> In that mail I mentioned the SMI#/IRQ mask registers, how about set
> these mask? I'm trying to disable SMI.
> I'm hoping to get the read back value of these commands.
> 
> i2cset -y 0 0x2c 0x43 0xff
> i2cset -y 0 0x2c 0x44 0x7f
> i2cset -y 0 0x2c 0x9c 0xff

Hi Yuan,

Setting those 3 registers to mask off the interrupts worked, I have
the following register values after setting the masks:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 bf 00 00 63 00 ff 04 00 f5 00 8f b3    ..dd?..c..?.?.??
20: d4 d4 b9 b9 b7 b8 ce 18 42 ff 74 ff 00 96 64 d7    ????????B.t..?d?
30: af d9 b1 d9 b1 d7 af ff 00 25 00 f0 f0 f0 67 30    ???????..%.???g0
40: 03 00 00 ff 7f ff ff bb 2c 13 40 c3 51 ff 80 5c    ?...?..?,?@?Q.?\
50: ff ff ff ff ff ff ff ff 7a 40 ff bb bb c1 05 7f    ........z at .?????
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 81 8f 81 8f 00 00 00 00 11 11 ff ff 3c 3c 0a 0a    ????....??..<<??
90: 00 00 00 81 8f ff 00 00 11 ff 3c 00 ff 01 01 ff    ...??...?.<..??.
a0: 81 81 81 8f 8f 8f 8f ff 3e 42 00 e0 ff ff 00 00    ???????.>B.?....
b0: d3 cb ff ff ff 00 e2 b9 ff ff ff f0 f0 f0 ff ff    ??....??...???..
c0: 29 80 02 39 00 3c 00 ff 30 00 00 5d 00 60 00 ff    )??9.<..0..].`..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
f0: ff ff 00 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    .....?...?......

With the masks in place, I'm able to set all the sensor limits without
the machine hanging. I reproduced the hand to make sure that setting
those 3 registers actually did have an effect and it seem like that is
the case.


> If it does not work, let use following command to try other SMI mode.
> Now the mode of your board is two time interrupt mode.
> i2cset -y 0 0x2c 0x4c 0x01 #comparator interrupt mode

Tried this one as well, that did not solve the issue with the system
hanging but the register write did succeed. When performing this test
I did not change the mask registers though so that seems to still
point in the direction that it is the interrupt that is causing the hang.

> i2cset -y 0 0x2c 0x4c 0x81 #One time interrupt mode

Same result as above, system still hangs.

> Or BIOS will not let us do this too.... I don't know.
> 
> Or the SMI is triggered by fan limit/ voltage limit... The fan 4/5/6 low
> limit of your MB is not 0.
> Try to set all your fan limit value to zero.
> i2cset -y 0 0x2c 0x3b 0xff
> i2cset -y 0 0x2c 0x3c 0xff
> i2cset -y 0 0x2c 0x3d 0xff
> i2cset -y 0 0x2c 0xbb 0xff
> i2cset -y 0 0x2c 0xbc 0xff
> i2cset -y 0 0x2c 0xbd 0xff
> i2cset -y 0 0x2c 0xbf 0xff

This also seems to avoid the hang. After setting the above registers I
can proceed to set the other sensor limits.

My conclusion from this is that it is probably the interrupt that is
causing the system to hang and we can work around that in this case by
masking off those interrupts. I suppose this could be done in the
w83792d driver since that will prevent the hang from occuring once
that driver is loaded.

Now, thinking a little further here though, this motherboard and
potentially other motherboards comes with all these sensor interrupts
armed and all that seems to be required is for one fan to stop in the
system and the kernel will hang if the w83792d driver hasn't been
loaded... That's not a good thing... Wouldn't a better solution be for
the kernel to be able to survive this SMI interrupt? I really don't
know much about the complexity of that though, I did notice however
that Dell seems to support SMI on some of their servers with the
dcdbas driver.

Thanks!
Daniel


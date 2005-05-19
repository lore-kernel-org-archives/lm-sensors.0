From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: Asus Boards: A New Hope
Message-Id: <Pine.LNX.4.58.0503091025440.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

You board has same GPIO base addr so the trick might work too.
Because I dont know how to force isadump to dump only one byte
I made some program that could do the trick for you.

We dont know if this would work. In general  it is not good to
play with  GPIO when we dont know what they doing but the risk
is sometimes gain :)

#include <sys/io.h>
#include <stdio.h>
int main(void) {
unsigned char val;
iopl(3);
val=inb(0x4B9);
printf("Was %x\n",val);
val&=~0x4; //clear bit 2
val|=0x8; //set bit3
outb(val,0x4B9);
printf("Wrote %x, readback %x\n",val,inb(0x4B9));
return 0;
}

gcc trick.c -o trick
su
./trick

I would like to see the i2cdump (or if you have recent sensors-detect you
can try it also) and dump of this program.

Thanks

Rudolf

From: m.strong@tnsa.com.au (Mark Strong)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Asus Boards: A New Hope
Message-Id: <1111367525.17599.32.camel@tooheys.tnsa.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503091025440.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503091025440.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,
	sorry about the delay, must have missed that previous mail message.
Anyway I don't see any extra devices. Here's the result.
-------------------------------------------------
bambi:~/lm_sensors2# i2cdetect -l
i2c-1   dummy           ISA main adapter                        ISA bus algorithm
i2c-0   unknown         SMBus I801 adapter at 0400              Algorithm unavailable

i2cdetect 0
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 52 53 54 55 56 57 XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

bambi:~/lm_sensors2# ./trick
Was 3
Wrote b, readback 3

i2cdetect 0
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 52 53 54 55 56 57 XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

These are the commands you wanted, aren't they ?


Mark.

On Mon, 2005-03-21 at 00:00 +0100, Rudolf Marek wrote:
> Hi all,
> 
> Just wondering why the trick returns 3 instead of B.
> Anyone has some ideas?
> 
> Mark, I guess you cant see any devices after running the trick (i2cdetect
> on your bus) ?
> 
> Regards
> 
> Rudolf
> 
> > Rudolf,
> > 	here's the output of 'trick'
> >
> > bambi:~/lm_sensors2# ./trick
> > Was 3
> > Wrote b, readback 3
> > bambi:~/lm_sensors2#
> >
> >
> > Regards
> > Mark Strong
> >
> > On Wed, 2005-03-09 at 10:43 +0100, Rudolf Marek wrote:
> > > Hello,
> > >
> > > You board has same GPIO base addr so the trick might work too.
> > > Because I dont know how to force isadump to dump only one byte
> > > I made some program that could do the trick for you.
> > >
> > > We dont know if this would work. In general  it is not good to
> > > play with  GPIO when we dont know what they doing but the risk
> > > is sometimes gain :)
> > >
> > > #include <sys/io.h>
> > > #include <stdio.h>
> > > int main(void) {
> > > unsigned char val;
> > > iopl(3);
> > > val=inb(0x4B9);
> > > printf("Was %x\n",val);
> > > val&=~0x4; //clear bit 2
> > > val|=0x8; //set bit3
> > > outb(val,0x4B9);
> > > printf("Wrote %x, readback %x\n",val,inb(0x4B9));
> > > return 0;
> > > }
> > >
> > > gcc trick.c -o trick
> > > su
> > > ./trick
> > >
> > > I would like to see the i2cdump (or if you have recent sensors-detect you
> > > can try it also) and dump of this program.
> > >
> > > Thanks
> > >
> > > Rudolf
> >
> >

From: mrfaustino@uol.com.br (mrfaustino)
Date: Sat, 18 Feb 2006 00:30:40 +0000
Subject: [lm-sensors] Error with I2c-parport-light with kernel 2.6.15
Message-Id: <IUUXF4$55017A885EBB2B95269739D711A5492B@uol.com.br>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am developing embedded circuits that contains some I2C chips. 
I can configure these circuits attaching then to a Linux box
parallel port.
Nowadays my Linux box runs Red Hat 7.1 (kernel 2.4.2) and I
have no trouble 
with it, but I would like to upgrade my system to a Gentoo
distro 
(kernel 2.6.15).  When I began to work in the new system
some errors appeared.
Bellow I will show some details of the two systems
configuration:

In both system I ran the following example program:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>



#define NESCRAVO 0xCA

  int fd;
  char buf[10];

  void i2cinit(void)
  {
    long addr;  
  
    if ( (fd = open("/dev/i2c-0",O_RDWR)) < 0 ) 
    {
      perror("I2C: Abertura do dispositivo");
      exit(1);
    }

    addr = NESCRAVO >> 1;
    if ( ioctl(fd, I2C_SLAVE, addr) < 0 )
    {
      perror("I2C: Definicao do escravo");
      exit(2);
    }
  
  }
  
  void WriteBufByI2C( unsigned addr, unsigned char * buf,
unsigned count)
  {
    unsigned char *localbuf;
    int i, j;
    
    localbuf = (char *) malloc( count + 2);

    localbuf[0] = *((unsigned char *)&addr+1);  
    localbuf[1] = *((unsigned char *)&addr);
    
    for( i = 0; i < count; i++ )
      localbuf[i+2] = buf[i];


    if ( write(fd, localbuf, count+2) != count+2  )
    {
      perror("I2C: WriteBufByI2C");
      exit(3);
    }  

    free(localbuf);

    j = 255;
    while ( j-- );
  }

  void ReadBufByI2C(unsigned addr, unsigned char *buf,
unsigned count )
  {
    int j;
	  
    WriteBufByI2C( addr, buf, 0 );  
    j = 255;
    while ( --j );

    
    if ( read(fd, buf, count) != count  )
    {
      perror("I2C: ReadBufByI2C");
      exit(4);
    }  

    j = 255;
    while ( --j );
    
  }

#ifdef MAIN

  unsigned char testbuf[4] = { 1, 2, 3, 4 }, i;

  void main(void)
  {
    i2cinit();
    WriteBufByI2C( 0x8E, testbuf, 4);
    
    i = 255;
    while ( --i );
    
    ReadBufByI2C( 0x8E, testbuf, 4);
  }

#endif



I compiled that source with :



gcc -DMAIN i2c.c



I loaded the drivers in the Had Hat 7.1 with :



modprobe i2c-algo-bit i2c_debug=9
modprobe i2c-philips-par.o
modprobe i2c-dev



And after ran the a.out, I get the following dmesg report



S  i2c_outb:CA
1needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[ca] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 00
 i2c_outb:00
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[00] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 8E
 i2c_outb:8E
1needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
1needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[8e] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 01
 i2c_outb:01
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[01] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 02
 i2c_outb:02
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 1 jiffies
0needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[02] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 03
 i2c_outb:03
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
1needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[03] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 04
 i2c_outb:04
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[04] A i2c-algo-bit.o: wrote 6 bytes.
P
needed 0 jiffies
S  i2c_outb:CA
1needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[ca] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 00
 i2c_outb:00
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[00] A i2c-algo-bit.o: Philips Parallel port adapter
i2c_write: writing 8E
 i2c_outb:8E
1needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
1needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[8e] A i2c-algo-bit.o: wrote 2 bytes.
P
needed 0 jiffies
S  i2c_outb:CB
1needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
0needed 0 jiffies
1needed 0 jiffies
1needed 0 jiffies
needed 0 jiffies
 i2c_outb: getsda() =  0xffffffff
[cb] A i2c_inb.
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
 01 Am needed 0 jiffies
i2c_inb.
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
 02 Am needed 0 jiffies
i2c_inb.
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
 03 Am needed 0 jiffies
i2c_inb.
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
 04 NAm needed 0 jiffies
i2c-algo-bit.o: read 4 bytes.
P
needed 0 jiffies


No errors happened no matter how many times I ran the
program in the
Had Hat system ( kernel 2.4 ). When I try to do something
similar in the Gentoo
system (kernel 2.6.15 ) I get some errors.

I loaded the drivers in the Gentoo box with:




modprobe i2c-algo-bit i2c-debug=9
modprobe i2c-parport-light type=0
modprobe i2c-dev



And after the third time I run the same program showed above
(compiled in 
the Gentoo) I get the following message:



I2C: WriteBufByI2C: Bad address



The dmesg report produced was:



i2c_adapter i2c-0: ioctl, cmd=0x703, arg=0x65
i2c-dev: i2c-0 writing 6 bytes.
i2c_adapter i2c-0: master_xfer[0] W, addr=0x65, len=6
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xca , getsda() = 0
[ca]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 00
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x00 , getsda() = 0
[00]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 8E
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x8e , getsda() = 0
[8e]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 01
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x01 , getsda() = 0
[01]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 02
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x02 , getsda() = 0
[02]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 03
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x03 , getsda() = 0
[03]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 04
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x04 , getsda() = 0
[04]<7> A <7>i2c-algo-bit.o: wrote 6 bytes.
P
needed 0 jiffies
i2c-dev: i2c-0 writing 2 bytes.
i2c_adapter i2c-0: master_xfer[0] W, addr=0x65, len=2
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xca , getsda() = 0
[ca]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 00
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x00 , getsda() = 0
[00]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 8E
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x8e , getsda() = 0
[8e]<7> A <7>i2c-algo-bit.o: wrote 2 bytes.
P
needed 0 jiffies
i2c-dev: i2c-0 reading 4 bytes.
i2c_adapter i2c-0: master_xfer[0] R, addr=0x65, len=4
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xcb , getsda() = 0
[cb]<7> A <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x01
 0x01 Am <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x02
 0x02 Am <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x03
 0x03 Am <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x04
 0x04 NAm <7>needed 0 jiffies
i2c-algo-bit.o: read 4 bytes.
P
needed 0 jiffies
i2c_adapter i2c-0: ioctl, cmd=0x703, arg=0x65
i2c-dev: i2c-0 writing 6 bytes.
i2c_adapter i2c-0: master_xfer[0] W, addr=0x65, len=6
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xca , getsda() = 0
[ca]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 00
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x00 , getsda() = 0
[00]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 8E
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x8e , getsda() = 0
[8e]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 01
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x01 , getsda() = 0
[01]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 02
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x02 , getsda() = 0
[02]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 03
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x03 , getsda() = 0
[03]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 04
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x04 , getsda() = 0
[04]<7> A <7>i2c-algo-bit.o: wrote 6 bytes.
P
needed 0 jiffies
i2c-dev: i2c-0 writing 2 bytes.
i2c_adapter i2c-0: master_xfer[0] W, addr=0x65, len=2
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xca , getsda() = 0
[ca]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 00
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x00 , getsda() = 0
[00]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 8E
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x8e , getsda() = 0
[8e]<7> A <7>i2c-algo-bit.o: wrote 2 bytes.
P
needed 0 jiffies
i2c-dev: i2c-0 reading 4 bytes.
i2c_adapter i2c-0: master_xfer[0] R, addr=0x65, len=4
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xcb , getsda() = 0
[cb]<7> A <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x01
 0x01 Am <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x02
 0x02 Am <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x03
 0x03 Am <7>needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
needed 0 jiffies
i2c_inb: 0x04
 0x04 NAm <7>needed 0 jiffies
i2c-algo-bit.o: read 4 bytes.
P
needed 0 jiffies
i2c_adapter i2c-0: ioctl, cmd=0x703, arg=0x65
i2c-dev: i2c-0 writing 6 bytes.
i2c_adapter i2c-0: master_xfer[0] W, addr=0x65, len=6
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xca , getsda() = 0
[ca]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 00
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x00 , getsda() = 0
[00]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 8E
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outbO: 0x8e , getsda() = 0
[8e]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 01
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x01 , getsda() = 0
[01]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 02
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x02 , getsda() = 0
[02]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 03
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x03 , getsda() = 0
[03]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 04
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x04 , getsda() = 0
[04]<7> A <7>i2c-algo-bit.o: wrote 6 bytes.
P
needed 0 jiffies
i2c-dev: i2c-0 writing 2 bytes.
i2c_adapter i2c-0: master_xfer[0] W, addr=0x65, len=2
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xca , getsda() = 1
[ca]<7> NA P
needed 0 jiffies
S <7>1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0xca , getsda() = 0
[ca]<7> A <7>i2c-algo-bit.o: Used 2 tries to write client at
0x65 : success
i2c_adapter i2c-0: sendbytes: writing 00
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x00 , getsda() = 0
[00]<7> A <7>i2c_adapter i2c-0: sendbytes: writing 8E
1<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
0<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
1<7>needed 0 jiffies
0<7>needed 0 jiffies
needed 0 jiffies
 i2c_outb: 0x8e , getsda() = 1
[8e]<7> NA <3>i2c_adapter i2c-0: sendbytes: error - bailout.
P
needed 0 jiffies
i2c-algo-bit.o: wrote -14 bytes.





If somebody can show me a way to solve the error I would be
grateful.

   Marcos



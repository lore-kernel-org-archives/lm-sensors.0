From: ffl@aber.ac.uk (Fred Labrosse)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Reading a compass CMPS03
Message-Id: <16497.19215.209434.328945@aber.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm trying to access data from a compass (CMPS03), the documentation of
which being at <http://www.robot-electronics.co.uk/htm/cmps3doc.shtml>.
This device is supposed to be at address 0xC0.  I read at
<http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2003-May/015484.html>
that I should specify this as 0xC0 >> 1, which is 0x60 (0xC0 is clearly not
supported anywhere anyway ;-).

I have written a small program that should to that, but it doesn't work.
Here is what I did.  I attached it to my parallel port as in
i2c-2.8.4/doc/i2c-pport.  I loaded all the modules:

pcffl root # lsmod
Module                  Size  Used by    Tainted: P
i2c-pport               1297   0
i2c-proc                6836   0  (unused)
i2c-dev                 4608   0
i2c-algo-bit            7720   0  [i2c-pport]
i2c-core               15460   0  [i2c-proc i2c-dev i2c-algo-bit]

and the parallel port is detected:

pcffl root # cat /proc/bus/i2c
i2c-0   i2c             Primitive Parallel port adaptor         Bit-shift algorithm

My program is attached below:

-------------- next part --------------
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <time.h>
#include <linux/i2c-dev.h>

/* #include <stdio.h>  */
/* #include <sys/types.h>  */
/* #include <sys/stat.h>  */
/* #include <fcntl.h>  */
/* #include <linux/i2c.h>  */
/* #include <linux/i2c-dev.h>  */

#define DEFAULT_I2C_BUS "/dev/i2c-0"
#define DEFAULT_ADDR 0xC0       /* the compass sits on i2c address 0xC0 */

int main(int argc, char **argv) 
{
   int addr;
   int heading;

   int file;
   int adapter_nr = 0; /* probably dynamically determined */
   char filename[20];
  
   sprintf(filename,"/dev/i2c-%d",adapter_nr);
   if ((file = open(filename,O_RDWR)) < 0)
   {
      printf("Open failed for device %s!\n", filename);
      /* ERROR HANDLING; you can check errno to see what went wrong */
      exit(1);
   }

   // tell the kernel which device we would like to talk to.
   addr = DEFAULT_ADDR >> 1;
   /* The shift to the right is explained at
      <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2003-May/015484.html>
   */

   printf("Accessing device at 0x%X\n", addr); 
   if (ioctl(file, I2C_SLAVE, addr) < 0)
   {
      int errnumber = errno;
      printf("%s\n", strerror(errnumber));

      printf("I2C_SLAVE failed for 0x%X\n", addr); 
      /* ERROR HANDLING; you can check errno to see what went wrong */
      exit(2); 
   }

   heading = i2c_smbus_read_byte_data(file, 1);
   if (heading < 0)
   {
      printf("write error\n"); 
      exit(3); 
   }
   else
   {
      printf("Heading %d\n", heading);
   }

   // set all 8 legs to 1
/*    if (i2c_smbus_write_byte(file, 0xff)<0) */
/*    { */
/*       printf("write error\n");  */
/*       exit(3);  */
/*    } */

   // and quit
   close(file);
} 
-------------- next part --------------

All it does is output 0, whatever register I read.  Here is the output of
i2cdetect and i2cdump:


pcffl root # i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f
pcffl root # i2cdump 0 0x60
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x60, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

Now, the funny thing is that i2cdetect and i2cdump produce exactly the same
thing whether or not my device is plugged in!

One additional bit:

pcffl root # cat /proc/sys/dev/parport/parport0/modes
PCSPP,TRISTATE

I hope someone can help me with that.  Sorry for the long message.

Cheers,

Fred

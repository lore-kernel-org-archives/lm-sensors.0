From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: SOLVED: an issue + a bug in eepromer/eeprom.c from lm_sensors.tgz
Message-Id: <3ED81594.309@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
In-Reply-To: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok it's checked in.
BTW my interpretation of the Atmel datasheet is that only writes are limited to 8 bytes;
reads don't appear to have a limit (although the i2c layer has a 32 byte limit).

Our i2c-dev.h in our package got reduced to almost nothing by Kyosti,
I'm going to try and recover it in our 2.4 branch so we're back where
this compiles.

Christian Vogel wrote:
> Hi Mark,
> 
> On Thu, May 22, 2003 at 09:22:17AM -0400, Mark Studebaker wrote:
> 
>>In lm_sensors-2.7.0,
>>we've already made clear in the README files in prog/eepromer
>>that 'eeprom' is for small eeproms and 'eepromer' is for big eeproms.
> 
> 
> Nobody doubts that :-) The problem with "eeprom.c" is, that it's not
> working with *very* *small* eeproms. The small ones must be written/read
> 8 bytes at a time (which also works with the bigger ones) whereas my code uses 16.
> 
> Furthermore, Frank found another error (the condition in the
> for(;;)-loop) which should be corrected nevertheless. Therefore please
> consider applying the patch below which is exactly what Frank sent to
> you as a whole file.
> 
> Greetings,
>         Chris
> 
> --- eeprom.c    2003/05/22 13:01:44     1.1
> +++ eeprom.c    2003/05/22 14:04:20
> @@ -22,7 +22,9 @@
>  #define DEFAULT_EEPROM_ADDR  0x50         /* the 24C16 sits on i2c address 0x50 */
>  #define DEFAULT_NUM_PAGES    8            /* we default to a 24C16 eeprom which has 8 pages */
>  #define BYTES_PER_PAGE       256          /* one eeprom page is 256 byte */
> -#define MAX_BYTES            16           /* max number of bytes to write in one piece */
> +#define MAX_BYTES            8            /* max number of bytes to write in one chunk */
> +       /* ... note: 24C02 and 24C01 only allow 8 bytes to be written in one chunk.   *
> +        *  if you are going to write 24C04,8,16 you can change this to 16            */
>  
>  /* write len bytes (stored in buf) to eeprom at address addr, page-offset offset */
>  /* if len=0 (buf may be NULL in this case) you can reposition the eeprom's read-pointer */
> @@ -264,11 +266,11 @@
>                 for(j=0;j<sizeof(buf);j++)
>                     buf[j]=0;
>             }
> -           for(j=0;j<MAX_BYTES;j++)
> +           for(j=0;j<(BYTES_PER_PAGE/MAX_BYTES);j++)
>                 if(eeprom_write(d,addr+i,j*MAX_BYTES,buf+(j*MAX_BYTES),MAX_BYTES)<0)
>                     exit(1);
>         } else {
> -           for(j=0;j<MAX_BYTES;j++)
> +           for(j=0;j<(BYTES_PER_PAGE/MAX_BYTES);j++)
>                 if(eeprom_read(d,addr+i,j*MAX_BYTES,buf+(j*MAX_BYTES),MAX_BYTES)<0)
>                     exit(1);
>         }
> 

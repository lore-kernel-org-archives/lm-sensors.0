From: r.marek@assembler.cz (Rudolf Marek)
Date: Thu, 11 Jan 2007 15:34:44 +0000
Subject: [lm-sensors] FB-DIMM temperature
Message-Id: <45A65914.6040302@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Thanks for the improvements.

> 
> 	#include <sys/mman.h>
> 	#include <sys/stat.h>
> 	#include <fcntl.h>
> 	#include <stdio.h>
> 
> 	int main(void)
> 	{
> 	    int i;
> 	    unsigned char *addr;
> 	    int fd = open("/dev/mem", O_RDONLY);
> 
> 	    if ( fd = -1 ) {
> 		perror("failed to open /dev/mem");
> 		return 1;
> 	    }
> 
> 	    addr = mmap(0, 128*1024*1024, PROT_READ, MAP_PRIVATE, fd, 0xFE000000);
> 
> 	    if ( addr = MAP_FAILED ) {
> 		perror("mmap failed");
> 		return 1;
> 	    }
> 
> 	    /* we want function 3, 4 channels, 16AMB/channel */
> 	    for ( i = 0; i < 64; i++ ) {
> 		int idx = i*2048;
> 		if ( addr[idx] != 0xff || addr[idx+1] != 0xff ) {
> 		    printf("Intel sig at %i: %02x %02x\n",
> 	                   i, addr[idx], addr[idx+1]);

We should see the 86 80



> 		    /* offset 85h function 3 */
> 		    printf("Current temp is: %fC\n", addr[idx+(256*3)+0x85]/2.);
> 		}
> 	    }
> 
> 	    munmap(addr, 128*1024*1024);
> 
> 	    return 0;
> 	}
> 
> and here are the results:
> 
> 	# ./fbdt
> 	Intel sig at 0: 1d 11
> 	Current temp is: 71.500000C
> 	Intel sig at 16: 1d 11
> 	Current temp is: 0.000000C
> 	Intel sig at 32: 1d 11
> 	Current temp is: 61.000000C
> 	Intel sig at 48: 1d 11
> 	Current temp is: 0.000000C
> 

Hmm there is something wrong. Please provide output of lspci -vvv
and lspci -xxx

Do you have the windows software somewhere to download?

Rudolf



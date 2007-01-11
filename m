From: vz-sensors@zeitlins.org (Vadim Zeitlin)
Date: Thu, 11 Jan 2007 15:26:40 +0000
Subject: [lm-sensors] FB-DIMM temperature (was: Tyan S2696 and ADT7470)
Message-Id: <E1H51pA-0002fG-00@smtp.tt-solutions.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 07 Jan 2007 11:42:43 +0100 Rudolf Marek <r.marek at assembler.cz> wrote:

RM> > RM> > 	# sensors-detect
RM> > RM> > 	...
RM> > RM> > 	Now follows a summary of the probes I have just done.
RM> > RM> > 	Just press ENTER to continue:
RM> > RM> > 
RM> > RM> > 	Driver `to-be-written' (should be inserted):
RM> > RM> > 	  Detects correctly:
RM> > RM> > 	  * Bus `SMBus I801 adapter at 18c0'
RM> > RM> > 	    Busdriver `i2c-i801', I2C address 0x2e
RM> > RM> > 	    Chip `Analog Devices ADT7470' (confidence: 5)
RM> > RM> > 	  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
RM> > RM> 
RM> > RM> Wow :) Even the FB-DIMM are there.
RM> > 
RM> >  Yes, I was quite impressed by sensors-detect seeing them too. Too bad I
RM> > can't see their temperature as then I could try simply running the machine
RM> > without the (rear) fan, but I'm too afraid to fry the DIMMs -- they seem to
RM> > be quite hot.
...original program snipped...
RM> Compile this program and run as root. It should show the FB-DIMM temps.

 I've modified the program slightly to skip the signatures 0xffff as the
corresponding "temperature" values are also 0xffff and so are not very
interesting. Here is my modified version:

	#include <sys/mman.h>
	#include <sys/stat.h>
	#include <fcntl.h>
	#include <stdio.h>

	int main(void)
	{
	    int i;
	    unsigned char *addr;
	    int fd = open("/dev/mem", O_RDONLY);

	    if ( fd = -1 ) {
		perror("failed to open /dev/mem");
		return 1;
	    }

	    addr = mmap(0, 128*1024*1024, PROT_READ, MAP_PRIVATE, fd, 0xFE000000);

	    if ( addr = MAP_FAILED ) {
		perror("mmap failed");
		return 1;
	    }

	    /* we want function 3, 4 channels, 16AMB/channel */
	    for ( i = 0; i < 64; i++ ) {
		int idx = i*2048;
		if ( addr[idx] != 0xff || addr[idx+1] != 0xff ) {
		    printf("Intel sig at %i: %02x %02x\n",
	                   i, addr[idx], addr[idx+1]);
		    /* offset 85h function 3 */
		    printf("Current temp is: %fC\n", addr[idx+(256*3)+0x85]/2.);
		}
	    }

	    munmap(addr, 128*1024*1024);

	    return 0;
	}

and here are the results:

	# ./fbdt
	Intel sig at 0: 1d 11
	Current temp is: 71.500000C
	Intel sig at 16: 1d 11
	Current temp is: 0.000000C
	Intel sig at 32: 1d 11
	Current temp is: 61.000000C
	Intel sig at 48: 1d 11
	Current temp is: 0.000000C

 I don't know how to interpret this: zeros are clearly suspicious (I have 4
FB-DIMMs) but so are the other values both because they seem too high (the
DIMMs seem hot but not *that* hot) and because there is such big difference
between them. Unfortunately I don't know how to check the real temperature
as the BIOS doesn't show it and I don't want to install Windows on this
machine just to check if any of Windows hardware information programs can
show this temperature...

 Thanks,
VZ



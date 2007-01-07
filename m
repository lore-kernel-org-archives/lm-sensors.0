From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 07 Jan 2007 10:42:43 +0000
Subject: [lm-sensors] Tyan S2696 and ADT7470
Message-Id: <45A0CEA3.7050200@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
In-Reply-To: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>  As I work on a few free projects on my own, this is a situation I
> understand only too well...

Ok

> RM> Maybe you or your company can fund the driver devel? Hw/Money/whatever?
> 
>  Well, I have hardware and am definitely available to do any (preferably
> non destructive :-) tests on it. And I can contribute some of my own time.
> Unfortunately not much in the way of money.

Ok never mind.

> 
> RM> > 	# sensors-detect
> RM> > 	...
> RM> > 	Now follows a summary of the probes I have just done.
> RM> > 	Just press ENTER to continue:
> RM> > 
> RM> > 	Driver `to-be-written' (should be inserted):
> RM> > 	  Detects correctly:
> RM> > 	  * Bus `SMBus I801 adapter at 18c0'
> RM> > 	    Busdriver `i2c-i801', I2C address 0x2e
> RM> > 	    Chip `Analog Devices ADT7470' (confidence: 5)
> RM> > 	  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
> RM> 
> RM> Wow :) Even the FB-DIMM are there.
> 
>  Yes, I was quite impressed by sensors-detect seeing them too. Too bad I
> can't see their temperature as then I could try simply running the machine
> without the (rear) fan, but I'm too afraid to fry the DIMMs -- they seem to
> be quite hot.

#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

void main(void) {
unsigned char * addr;
int fd = open("/dev/mem", O_RDONLY);
int i;
int idx;
addr = mmap(0, 128*1024*1024, PROT_READ, MAP_PRIVATE, fd, 0xFE000000);
//addr = mmap(0, 128, PROT_READ, MAP_PRIVATE, fd, 0xd5000000);

//we want function 3,
//4 channels, 16AMB/channel
for (i=0;i<64;i++) {
idx = i*2048;
printf("Intel sig: %02x %02x\n", addr[idx],addr[idx+1]);
//offset 85h function 3
printf("Current temp is: %f (0x%02x)C\n", (addr[idx+(256*3)+0x85] / (float)
2.0), addr[idx+(256*3)+0x85]);

}
munmap(adr, 128*1024*1024);
}

Compile this program and run as root. It should show the FB-DIMM temps. One user
in http://www.lm-sensors.org/ticket/2143 reported that the program hanged the
machine when run multiple times. I added the munmap so maybe it won't anymore.
Please can you try that? If it never displays 8086 it means the base address is
wrong and I would need lspci -xxx to fix it.

> 
> RM> > Unfortunately it looks that the case fans -- which create the deafening
> RM> > noise making the machine all but unusable currently -- are connected to
> RM> > ADT7470 and not the W83627EHG
> 
>  FWIW, I got a reply from Tyan and this is indeed the case.
> 
> 
> RM> If you know how to code in C it should not be a problem to write a driver.
> 
>  Is there any sufficiently clean and simple driver I could use as an
> example/starting point by chance?

Yes maybe you can study the  w83l785ts.c  it is just temperature driver. Most
simple. Also you may read the docs in kernel Documentation/hwmon/ and /i2c/

I had in plan to create some example driver for i2c devices but no time yet :/

> RM> You can use also following commands to reprogram the fans to manual mode:
> RM> 
> RM> http://www.analog.com/en/prod/0,2877,ADT7470,00.html
> RM> 
> RM> CHeck page 23 of datasheet.
> 
>  Ah, I started reading the datasheet but didn't reach the most interesting
> part, thanks for the page link! I'm going to try it out and report back.

Yes just run the command it should do the trick.

Rudolf


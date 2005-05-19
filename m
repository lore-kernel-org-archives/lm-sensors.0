From: rysanek@fccps.cz (rysanek@fccps.cz)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: SOLVED: an issue + a bug in eepromer/eeprom.c from lm_sensors.tgz
Message-Id: <Pine.LNX.4.33.0305221414100.23255-200000@usti.fccps.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear Chris,

many thanks for writing eeprom.c in the first place.
It has saved me an indefinite amount of time when I needed
to access a 24C02 in a cursed notebook battery pack that
someone's trying to refurbish.

Many more thanks to the authors of lm_sensors and Linux i2c
for writing their software, of course.

I did have to modify eepromer/eeprom.c a bit though, to support
my 24C02. The essential gotcha was this: whereas the 24C16 that
you were using supports maximum burst size of 16 bytes (the same
applies to 24C08 and 24C04), the 24C02 and 24C01 only support
bursts up to 8 bytes long.
I assume that in fact you already know this, as in your code
there's a neat #define called MAX_BYTES to hold exactly this
burst length. And, this was the first thing I modified when
I was trying to solve my problem.
There's one more associated bug though, probably a result of
the fact that your code was not tested with MAX_BYTES values
other than 16. The two for(;;) cycles for reading/writing
consecutive bursts have a wrong terminal condition: they're
comparing the loop count against MAX_BYTES instead of
(BYTES_PER_PAGE/MAX_BYTES).

With this e-mail, I am enclosing the corrected eeprom.c.

My symptoms looked like this: I read the eeprom just fine.
I did my dirty work on two bytes in the eprom dump and
flashed it back. When I re-read the eprom contents,
I found garbage - or so it seemed.
At a closer look, I found out that every second
half-burst (the second 8 bytes of the 16) was correct and
every first 8 bytes was garbled. (Compared that using two
hex editors open on consoles 1 and 2.)
After a few more  seconds I found out that the two half-bursts
were really identical.
My final explanation is that each 16byte write resulted in
only the first half-burst being overwritten (the second was
left untouched), only the eeprom latched in all 16 bytes
obediently, so that its FIFO overflew and looped around
exactly once, which resulted in the *second* half-burst
being written into the *first* eight bytes...

Based largely on eeprom.c, I've already hacked a simple util
to write only those two or four bytes that matter to me (the
actual battery capacity and the write-protect stuff).

If the battery refurbishment works out, I'll update my website
to report this success, including all my code snippets.
Thanks again :)

Frank Rysanek
-------------- next part --------------
/*
This program is hereby placed into the public domain.
Of course the program is provided without warranty of any kind.
*/
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <time.h>
#include <linux/i2c-dev.h>

/*
  this program can read 24C16 (and probably smaller ones, too)
  I wrote it as a quick and dirty hack because my satellite receiver
  hung again... so I had to reprogram the eeprom where is stores it's
  settings.
 */

#define DEFAULT_I2C_BUS      "/dev/i2c-0"
#define DEFAULT_EEPROM_ADDR  0x50         /* the 24C16 sits on i2c address =
0x50 */
#define DEFAULT_NUM_PAGES    8            /* we default to a 24C16 eeprom w=
hich has 8 pages */
#define BYTES_PER_PAGE       256          /* one eeprom page is 256 byte */
#define MAX_BYTES            8            /* max number of bytes to write i=
n one piece */

/* write len bytes (stored in buf) to eeprom at address addr, page-offset o=
ffset */
/* if len=3D0 (buf may be NULL in this case) you can reposition the eeprom'=
s read-pointer */
/* return 0 on success, -1 on failure */
int eeprom_write(int fd,
		 unsigned int addr,
		 unsigned int offset,
		 unsigned char *buf,
		 unsigned char len
){
	struct i2c_rdwr_ioctl_data msg_rdwr;
	struct i2c_msg             i2cmsg;
	int i;
	char _buf[MAX_BYTES + 1];

	if(len>MAX_BYTES){
	    fprintf(stderr,"I can only write MAX_BYTES bytes at a time!\n");
	    return -1;
	}

	if(len+offset >256){
	    fprintf(stderr,"Sorry, len(%d)+offset(%d) > 256 (page boundary)\n",
			len,offset);
	    return -1;
	}

	_buf[0]=3Doffset;    /* _buf[0] is the offset into the eeprom page! */
	for(i=3D0;i<len;i++) /* copy buf[0..n] -> _buf[1..n+1] */
	    _buf[1+i]=3Dbuf[i];

	msg_rdwr.msgs =3D &i2cmsg;
	msg_rdwr.nmsgs =3D 1;

	i2cmsg.addr  =3D addr;
	i2cmsg.flags =3D 0;
	i2cmsg.len   =3D 1+len;
	i2cmsg.buf   =3D _buf;

	if((i=3Dioctl(fd,I2C_RDWR,&msg_rdwr))<0){
	    perror("ioctl()");
	    fprintf(stderr,"ioctl returned %d\n",i);
	    return -1;
	}

	if(len>0)
	    fprintf(stderr,"Wrote %d bytes to eeprom at 0x%02x, offset %08x\n",
		    len,addr,offset);
	else
	    fprintf(stderr,"Positioned pointer in eeprom at 0x%02x to offset %08x\=
n",
		    addr,offset);

	return 0;
}

/* read len bytes stored in eeprom at address addr, offset offset in array =
buf */
/* return -1 on error, 0 on success */
int eeprom_read(int fd,
		 unsigned int addr,
		 unsigned int offset,
		 unsigned char *buf,
		 unsigned char len
){
	struct i2c_rdwr_ioctl_data msg_rdwr;
	struct i2c_msg             i2cmsg;
	int i;

	if(len>MAX_BYTES){
	    fprintf(stderr,"I can only write MAX_BYTES bytes at a time!\n");
	    return -1;
	}

	if(eeprom_write(fd,addr,offset,NULL,0)<0)
	    return -1;

	msg_rdwr.msgs =3D &i2cmsg;
	msg_rdwr.nmsgs =3D 1;

	i2cmsg.addr  =3D addr;
	i2cmsg.flags =3D I2C_M_RD;
	i2cmsg.len   =3D len;
	i2cmsg.buf   =3D buf;

	if((i=3Dioctl(fd,I2C_RDWR,&msg_rdwr))<0){
	    perror("ioctl()");
	    fprintf(stderr,"ioctl returned %d\n",i);
	    return -1;
	}

	fprintf(stderr,"Read %d bytes from eeprom at 0x%02x, offset %08x\n",
		len,addr,offset);

	return 0;
}



int main(int argc, char **argv){
    int i,j;

    /* filedescriptor and name of device */
    int d;=20
    char *dn=DEFAULT_I2C_BUS;

    /* filedescriptor and name of data file */
    int f=3D-1;
    char *fn=3DNULL;

    unsigned int addr=DEFAULT_EEPROM_ADDR;
    int rwmode=3D0;
    int pages=DEFAULT_NUM_PAGES;

    int force=3D0; /* suppress warning on write! */
   =20
    while((i=3Dgetopt(argc,argv,"d:a:p:wyf:h"))>=3D0){
	switch(i){
	case 'h':
	    fprintf(stderr,"%s [-d dev] [-a adr] [-p pgs] [-w] [-y] [-f file]\n",a=
rgv[0]);
	    fprintf(stderr,"\tdev: device, e.g. /dev/i2c-0    (def)\n");
	    fprintf(stderr,"\tadr: base address of eeprom, eg 0xA0 (def)\n");
	    fprintf(stderr,"\tpgs: number of pages to read, eg 8 (def)\n");
	    fprintf(stderr,"\t-w : write to eeprom (default is reading!)\n");
	    fprintf(stderr,"\t-y : suppress warning when writing (default is to wa=
rn!)\n");
	    fprintf(stderr,"\t-f file: copy eeprom contents to/from file\n");
	    fprintf(stderr,"\t         (default for read is test only; for write i=
s all zeros)\n");
	    fprintf(stderr,"Note on pages/addresses:\n");
	    fprintf(stderr,"\teeproms with more than 256 byte appear as if they\n"=
);
	    fprintf(stderr,"\twere several eeproms with consecutive addresses on t=
he bus\n");
	    fprintf(stderr,"\tso we might as well address several seperate eeproms=
 with\n");
	    fprintf(stderr,"\tincreasing addresses....\n\n");
	    exit(1);
	    break;
	case 'd':
	    dn=3Doptarg;
	    break;
	case 'a':
	    if(sscanf(optarg,"0x%x",&addr)!=3D1){
		fprintf(stderr,"Cannot parse '%s' as addrs., example: 0xa0\n",
			optarg);
		exit(1);
	    }
	    break;
	case 'p':
	    if(sscanf(optarg,"%d",&pages)!=3D1){
		fprintf(stderr,"Cannot parse '%s' as number of pages, example: 8\n",
			optarg);
		exit(1);
	    }
	    break;
	case 'w':
	    rwmode++;
	    break;
	case 'f':
	    fn=3Doptarg;
	    break;
	case 'y':
	    force++;
	    break;
	}

    }
  =20
    fprintf(stderr,"base-address of eeproms       : 0x%02x\n",addr);
    fprintf(stderr,"number of pages to read       : %d (0x%02x .. 0x%02x)\n=
",
		    pages,addr,addr+pages-1);

    if(fn){
	if(!rwmode) /* if we are reading, *WRITE* to file */
	    f=3Dopen(fn,O_WRONLY|O_CREAT,0666);
	else /* if we are writing to eeprom, *READ* from file */
	    f=3Dopen(fn,O_RDONLY);
	if(f<0){
	    fprintf(stderr,"Could not open data-file %s for reading or writing\n",=
fn);
	    perror(fn);
	    exit(1);
	}
	fprintf(stderr,"file opened for %7s       : %s\n",rwmode?"reading":"writin=
g",fn);
	fprintf(stderr,"            on filedescriptor : %d\n",f);
    }

    if((d=3Dopen(dn,O_RDWR))<0){
	fprintf(stderr,"Could not open i2c at %s\n",dn);
	perror(dn);
	exit(1);
    }

    fprintf(stderr,"i2c-devicenode is             : %s\n",dn);
    fprintf(stderr,"            on filedescriptor : %d\n\n",d);

    /***
     *** I'm not the one to blame of you screw your computer!
     ***/
    if(rwmode & ! force){
	unsigned char warnbuf[4];
	fprintf(stderr,"**WARNING**\n");
	fprintf(stderr," - \tYou have chosen to WRITE to this eeprom.\n");
	fprintf(stderr,"\tMake sure that this tiny chip is *NOT* vital to the\n");
	fprintf(stderr,"\toperation of your computer as you can easily corrupt\n");
	fprintf(stderr,"\tthe configuration memory of your SDRAM-memory-module,\n"=
);
	fprintf(stderr,"\tyour IBM ThinkPad or whatnot...! Fixing these errors can=
 be\n");
	fprintf(stderr,"\ta time-consuming and very costly process!\n\n");
	fprintf(stderr,"Things to consider:\n");
	fprintf(stderr," - \tYou can have more than one i2c-bus, check in /proc/bu=
s/i2c\n");
	fprintf(stderr,"\tand specify the correct one with -d\n");
	fprintf(stderr,"\tright now you have chosen to use '%s'\n",dn);
	fprintf(stderr," - \tA eeprom can occupy several i2c-addresses (one per pa=
ge)\n");
	fprintf(stderr,"\tso please make sure that there is no vital eeprom in you=
r computer\n");
	fprintf(stderr,"\tsitting at addresses between 0x%02x and 0x%02x\n",addr,a=
ddr+pages-1);

	fprintf(stderr,"Enter 'yes' to continue:");
	fflush(stderr);
	if(!fgets(warnbuf,sizeof(warnbuf),stdin)){
	    fprintf(stderr,"\nCould not read confirmation from stdin!\n");
	    exit(1);
	}
	if(strncmp(warnbuf,"yes",3)){
	    fprintf(stderr,"\n** ABORTING WRITE! **, you did not answer 'yes'\n");
	    exit(1);
	}
    }

    for(i=3D0;i<pages;i++){
	unsigned char buf[BYTES_PER_PAGE];

	if(rwmode){

	    if(f>=3D0){
		j=3Dread(f,buf,sizeof(buf));
		if(j<0){
		    fprintf(stderr,"Cannot read from file '%s'\n",fn);
		    perror(fn);
		    exit(1);
		}
		if(j!=3Dsizeof(buf)){
		    fprintf(stderr,"File '%s' is too small, padding eeprom with zeroes\n"=
,fn);
		    while(j<sizeof(buf))
			buf[j++]=3D0;
		}
	    } else {
		for(j=3D0;j<sizeof(buf);j++)
		    buf[j]=3D0;
	    }
	    for(j=3D0;j<(BYTES_PER_PAGE/MAX_BYTES);j++)
		if(eeprom_write(d,addr+i,j*MAX_BYTES,buf+(j*MAX_BYTES),MAX_BYTES)<0)
		    exit(1);
	} else {
	    for(j=3D0;j<(BYTES_PER_PAGE/MAX_BYTES);j++)
		if(eeprom_read(d,addr+i,j*MAX_BYTES,buf+(j*MAX_BYTES),MAX_BYTES)<0)
		    exit(1);
	}


	if(!rwmode && f>=3D0){
	    j=3Dwrite(f,buf,sizeof(buf));
	    if(j!=3Dsizeof(buf)){
		fprintf(stderr,"Cannot write to file '%s'\n",fn);
		perror(fn);
		exit(1);
	    }
	}

    }

    if(f>=3D0)
	close(f);

    close(d);

    exit(0);

}

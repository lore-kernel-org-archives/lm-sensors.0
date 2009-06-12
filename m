From: "Michael S. Zick" <lkml@morethan.org>
Date: Fri, 12 Jun 2009 13:41:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <200906120841.08114.lkml@morethan.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_0rlMKDXGXZL9sZ3"
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org> <200906120646.48615.lkml@morethan.org> <20090612125450.GK30843@prithivi.gnumonks.org>
In-Reply-To: <20090612125450.GK30843@prithivi.gnumonks.org>
To: Harald Welte <HaraldWelte@viatech.com>
Cc: Jean Delvare <khali@linux-fr.org>, Tomaz Mertelj <tomaz.mertelj@guest.arnes.si>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--Boundary-00=_0rlMKDXGXZL9sZ3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri June 12 2009, Harald Welte wrote:
> On Fri, Jun 12, 2009 at 06:46:45AM -0500, Michael S. Zick wrote:
> > > Temperature values are supposed to be expressed in millidegrees C, not
> > > degrees C as it seems to be doing (although 25 degrees C seems pretty
> > > low for a CPU temperature?) The drivers needs to multiply values by
> > > 1000 before exporting them to sysfs. Then "sensors" will report the
> > > correct temperature value.
> > > 
> > 
> > Ah, 25 degrees C is room temperature - real hard for the junction temperature
> > to be 25 degrees C with power applied; lacking an infinitely perfect heatsink.
> > 
> > Look for an "off by one" error in shifting or masking the value.
> 
> there is no shifting and the masking is 0xffffffff :)
> 
> it might be that the BIOS is doing something wrong when programming the
> calibration MSR's at early botoup.  I would need the contents of MSR 
> 0x1160 ... 0x116C as well as 0x1152 and 0x1153 to be able to determine that.
> 

root@cb01:~# for r in 0x1160 0x1161 0x1162 0x1163 0x1164 0x1165 0x1166 0x1167 0x1168 0x1169 0x116a 0x116b 0x116c 0x1152 0x1153 ; do ./rdmsr $r ; done
MSR register 0x1160 => 08:04:98:10:b7:ef:8f:f4
MSR register 0x1161 => 08:04:98:10:b7:fb:af:f4
MSR register 0x1162 => 08:04:98:10:b7:ec:ff:f4
MSR register 0x1163 => 08:04:98:10:b7:fa:cf:f4
MSR register 0x1164 => 08:04:98:10:b7:f4:cf:f4
MSR register 0x1165 => 08:04:98:10:b7:f3:2f:f4
MSR register 0x1166 => 08:04:98:10:b7:f1:7f:f4
MSR register 0x1167 => 08:04:98:10:b7:f2:0f:f4
MSR register 0x1168 => 08:04:98:10:b7:ef:0f:f4
MSR register 0x1169 => 08:04:98:10:b7:fc:8f:f4
MSR register 0x116a => 08:04:98:10:b7:ef:8f:f4
MSR register 0x116b => 08:04:98:10:b7:f8:bf:f4
MSR register 0x116c => 08:04:98:10:b7:f9:df:f4
MSR register 0x1152 => 08:04:98:10:b7:ed:5f:f4
MSR register 0x1153 => 08:04:98:10:b7:ed:cf:f4

The high 32b look strange in that output - might be
the utility I used (attached).

Mike


--Boundary-00=_0rlMKDXGXZL9sZ3
Content-Type: text/x-csrc;
  charset="iso 8859-15";
  name="rdmsr.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rdmsr.c"

/* By Ron Minnich @ wiki.laptop.org */
/* No rights or license mentioned.  */

#define _LARGEFILE64_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{
    unsigned char buf[8];
    int fd_msr, i;
    unsigned long addr = 0;

    if (argc < 2) {
        printf("usage:rdmsr reg\n");
        exit(1);
    }
    addr = strtoul(argv[1], NULL, 0);

    fd_msr = open("/dev/cpu/0/msr", O_RDONLY);
    lseek64(fd_msr, (off64_t)addr, SEEK_SET);
    read(fd_msr, buf, 8);

    printf("MSR register 0x%lx => ", addr);
    for (i = 7; i > 0; i--)
        printf("%2.2x:", buf[i]);
    printf("%2.2x\n", buf[i]);

    return(0);
}


--Boundary-00=_0rlMKDXGXZL9sZ3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_0rlMKDXGXZL9sZ3--

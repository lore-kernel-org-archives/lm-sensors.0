From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: bmcsensors.c won't compile in 2.9.0
Message-Id: <253818670504102329789e3f8a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1113198255.3499.231562842@webmail.messagingengine.com>
In-Reply-To: <1113198255.3499.231562842@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Please search through the list archives, this has been brought up
before, and it was fixed a while ago in CVS (as well as other
updates). Unfortunately the module author (MDS) hasn't got access to
an IPMI machine anymore and so he is having to rely on others testing
the driver. I'd suggest you try out the CVS version and let us know if
you encounter any problems, especially since we are very close to a
new lm_sensors release.

Yani

On Apr 11, 2005 1:44 AM, Mark D. Anderson <mda@discerning.com> wrote:
> In 2.9.0, bmcsensors.c won't compile because of an
> undefined symbol:
> 
> gcc  -D__SMP__ -DMODVERSIONS -include
> /lib/modules/2.4.29-5asl-mda/build/include/linux/modversions.h
> -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikerne\
> l/include -I/usr/local/include
> -I/lib/modules/2.4.29-5asl-mda/build/include -nostdinc -I
> /usr/lib/gcc-lib/i386-redhat-linux/3.2.3/include  -Wall -O2  -c
> kernel/chips/bmcs\
> ensors.c -o kernel/chips/bmcsensors.o
> kernel/chips/bmcsensors.c: In function `ipmi_sprintf':
> kernel/chips/bmcsensors.c:220: warning: operation on `from' may be
> undefined
> kernel/chips/bmcsensors.c:221: warning: operation on `from' may be
> undefined
> kernel/chips/bmcsensors.c: In function `bmcsensors_select_thresholds':
> kernel/chips/bmcsensors.c:300: `m' undeclared (first use in this
> function)
> kernel/chips/bmcsensors.c:300: (Each undeclared identifier is reported
> only once
> kernel/chips/bmcsensors.c:300: for each function it appears in.)
> kernel/chips/bmcsensors.c: At top level:
> kernel/chips/bmcsensors.c:45: warning: `addr_data' defined but not used
> 
> I fixed this by inserting a line in bmcsensors_select_threshold
> to pull "m" out of the sd struct; beats me if that is correct:
> 
> static void bmcsensors_select_thresholds(struct sdrdata * sd)
> {
> +        long m = sd->m;
>         u8 capab = sd->capab;
>         u16 mask = sd->thresh_mask;
> 
> but this is making me if I'm doing something wrong -- why
> would the most recent release have a fatal compile problem
> for over 3 months?
> 
> -mda
> 
>

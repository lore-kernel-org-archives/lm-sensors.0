From: lepalom@vilma.upc.es (Leopold Palomo Avellaneda)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Problems with a drivers
Message-Id: <200309301115.38841.lepalom@vilma.upc.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309261107.40242.lepalom@vilma.upc.es>
In-Reply-To: <200309261107.40242.lepalom@vilma.upc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

first of all thank's for your answer. Finally all is now working. 

I think that I did a mistake. I used a vanilla kernel and not a kernel from 
debian. I did it because I needed to patch with the openmosix patch. So, 
after when I compiled and used the debian packages with my kernel I found 
that first I have some problems to compile it (differents i2c.h headers) and 
after a core dump.

So, as you said, I followed the instruccions and I patch the kernel, althought 
I use the deb packages of lmsensors and i2c.

Otherwise i have now my cluster running with openmosix and the lmsensors 
working together (ker2.4.21 and lm 2.8).

Thank's again.

Leo



A Diumenge 28 Setembre 2003 22:45, Jean Delvare va escriure:
> [Resent on your request.]
>
> > I have compiled my own kernel 2.4.21 with two pathes:
> > - openmosix
> > - lm_sensor
> >
> > I'm using debian woody and it's compiled wig gcc 2.95. I'm using the
> > sources lm_sensors 2.8 from debian unstable and i2c too.
> >
> > My own kernel with openmosix and the i2c modules works well, no
> > problems (As I known by now). I have only a problem with the driver:
> > w83781d
> >
> > because it's all the time inicialitzating. I have test to do and
> > init=0, too, but I had a segmentation fault:
> > e01:~# modprobe w83781d init=0
> > Segmentation fault
> >
> > I'm a bit lost and I don't know what to do. Could you help me please?
>
> Known problem. Reading this page should help:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> Basically, you'll want to patch your kernel sources with my i2c patch
> instead of using Debian's source, so that everyone uses compatible i2c
> structures.
>
> Strange that debian provides sources for lm_sensors 2.8 through apt and
> don't patch the kernel as required.

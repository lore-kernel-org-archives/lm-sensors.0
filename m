From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Problems with a drivers
Message-Id: <20030926182353.33815d3d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309261107.40242.lepalom@vilma.upc.es>
In-Reply-To: <200309261107.40242.lepalom@vilma.upc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have compiled my own kernel 2.4.21 with two pathes:
> - openmosix
> - lm_sensor
> 
> I'm using debian woody and it's compiled wig gcc 2.95. I'm using the
> sources lm_sensors 2.8 from debian unstable and i2c too.
> 
> My own kernel with openmosix and the i2c modules works well, no
> problems (As I known by now). I have only a problem with the driver:
> w83781d 
> 
> because it's all the time inicialitzating. I have test to do and
> init=0, too, but I had a segmentation fault:
> e01:~# modprobe w83781d init=0
> Segmentation fault
> 
> I'm a bit lost and I don't know what to do. Could you help me please?

Known problem. Reading this page should help:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
Basically, you'll want to patch your kernel sources with my i2c patch
instead of using Debian's source, so that everyone uses compatible i2c
structures.

Strange that debian provides sources for lm_sensors 2.8 through apt and
don't patch the kernel as required.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030807091443.7c41814c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I ended using
> make LINUX=`pwd`/empty LINUX_HEADERS=`pwd`/empty
> I2C_HEADERS=`pwd`i2c-%{version}/kernel \
>      COMPILE_KERNEL=0 MODVER:=1 SMP:=0 WARN=1 \
>      KERNELCHIPSDIR=kernel/chips SRCDIRS='mkpatch kernel/include lib
>      prog/sensors prog/dump prog/detect ${PROG_EXTRA:%=prog/%} etc'
>      PROG_EXTRA=sensord \ user
> 
> and similar for make user_install. Before that I unpackged i2c into
> lm_sensors topdir. This seems to work, also does the right thing with
> respect to the missing sensors.h (Ticket 1344).

Ticket is under resolution. I'd expect you get the same result with:
make LINUX=`pwd`/empty LINUX_HEADERS=`pwd`/empty
      I2C_HEADERS=`pwd`i2c-%{version}/kernel \
      MODVER:=1 SMP:=0 WARN=1 \
      PROG_EXTRA=sensord \
      user
(That is, don't use COMPILE_KERNEL nor SRCDIRS.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: double file name in "/proc/sys/dev/sensors/"
Message-Id: <20030227100307.3d01b4b3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E5CA690.5060608@mytrix.ru>
In-Reply-To: <3E5CA690.5060608@mytrix.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[Please answer to the list instead of just me.]

> > > I am use "linux-2.4.20-suse1/2" from Hubert Mante. (SuSE).
> >
> > It is Mantel, isn't it?
>
> yes

> > > How can be two files with the identical name?
> >
> > This can happen because the /proc filesystem is virtual. It
> > shouldn't happen though. Could you please check you don't have two
> > different versions of libsensors installed in two different places
> > (usually/usr/lib and /usr/local/lib)?
> 
> no, only one version library.
> dpkg -l |grep sensors
> ii  libsensors-dev 2.6.3-5        Lm-sensors development kit
> ii  libsensors1    2.6.3-5        Library to read
> temperature/voltage/fan sens

You could have an old file installed from the sources, not from a debian
package.

On the other hand, 2.6.3 is a bit old and the bug has possibly been
fixed since. Trying 2.6.5 wouldn't hurt.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

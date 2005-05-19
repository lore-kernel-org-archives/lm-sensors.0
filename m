From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: bug
Message-Id: <20030630122156.07ee5921.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
In-Reply-To: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > You can install i2c from our i2c-2.7.0 package. It doesn't require
> > to patch the kernel. Just make sure you don't have any I2C module
> > built into the kernel itself, and install all the modules from our
> > package(make && make install && depmod -ae should just do it).
> 
> 
>         i compiled & instaled i2c-2.7.0 and when doing 'make' in
>         lm-sensors
> shows the same error:

Please make sure you don't have an old set of i2c header files in
/usr/include, this is a common mistake. Also, take a look at the news
item of May 31st, 2003 on our news pages:
http://secure.netroedge.com/~lm78/

This seems to describe your problem quite well.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

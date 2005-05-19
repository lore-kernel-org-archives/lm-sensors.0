From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: bug
Message-Id: <20030630114713.031eebd6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
In-Reply-To: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Well, I think the error message is explicit. You need to upgrade i2c
> > to 2.7.0.
> 
> 
>         yes, but i'm using kernel 2.4.21 and for now only have i2c
>         patches
> for 2.4.20

You can install i2c from our i2c-2.7.0 package. It doesn't require to
patch the kernel. Just make sure you don't have any I2C module built
into the kernel itself, and install all the modules from our package
(make && make install && depmod -ae should just do it).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

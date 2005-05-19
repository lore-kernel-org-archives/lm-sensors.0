From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: I2C_ALGO_MAX
Message-Id: <20030823224512.103dbc96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806164123.5f88f7b8.khali@linux-fr.org>
In-Reply-To: <20030806164123.5f88f7b8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I2C_ALGO_MAX, defined in i2c.h, doesn't seem to be used anywhere.
> > Same for I2C_DUMMY_MAX. Should we simply remove them?
>
> agreed. apparently these aren't registered in a static table like
> drivers are.

Done.
 
> BTW if we want to make things better for the foolish people that want
> to compile-in every driver we should increase the other xxx_MAX
> defines.

Compiling all sensor chip drivers into the kernel is BAD. Do we want to
help people doing a BAD thing?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

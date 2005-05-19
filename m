From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <dYbGB54J.1115210735.5051680.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42775670.5070709@inf.ed.ac.uk>
In-Reply-To: <42775670.5070709@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Nils,

> Linux-2.6.XXXX/Documentation/i2c is what i read.
> the problem is that #include <linux/i2c-dev.h> causes
> compiler errors because of the missing I2C_SMBUS_... macros in 2.6.x
> (if you want i include the error output, my example program or
>  the linux/i2c-dev.h file i am using)
> although all this is fixable, i am surprised that i couldn't find
> any howto/tutorial/advice on that - or am i the only one having this
> problem ?

There are two i2c-dev.h files, one for kernel-space and one for
user-space. If you are writing a user-space tool which will access
/dev/i2c-*, you need the user-space version of i2c-dev.h, which is
distributed with lm_sensors for historical reasons, although I believe
the kernel-headers package has a copy as well. This version will work
regardless of the version of the kernel you are using.

Hope that helps,
--
Jean Delvare

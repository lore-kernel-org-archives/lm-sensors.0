From: nroeder@inf.ed.ac.uk (Nils Roeder)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <4278BCA4.4000708@inf.ed.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <42775670.5070709@inf.ed.ac.uk>
In-Reply-To: <42775670.5070709@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
[snip]
> Have you read linux-2.6.XXXX/Documentation/i2c ?
> 
> There is file called dev-interface, that should help you.
> If you have any more questions, just write again.
> 

thanks for replying.
Linux-2.6.XXXX/Documentation/i2c is what i read.
the problem is that #include <linux/i2c-dev.h> causes
compiler errors because of the missing I2C_SMBUS_... macros in 2.6.x
(if you want i include the error output, my example program or
  the linux/i2c-dev.h file i am using)
although all this is fixable, i am surprised that i couldn't find
any howto/tutorial/advice on that - or am i the only one having this
problem ?

thanks,
   nils

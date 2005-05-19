From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: location of modules with make install
Message-Id: <3E01CE16.8060208@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040275150.16788.41.camel@linux.local>
In-Reply-To: <1040275150.16788.41.camel@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

what docs are wrong? I couldn't find any.
doc/modules in particular looks correct to me.
Don't know why you would have to move them for depmod to work.
I assume "../../" below means "/lib/modules/`uname -r`/" ?

Ed Harrison wrote:
> Apart from the problem I am having with the as99127f, make install isn't putting the drivers where the docs say they go.
> 
> buss drivers end up in ../../kernel/drivers/i2c (which I then have to mv to ../i2c/busses, and
> chip drivers end up in ../../kernel/drivers/sensors (which I mv to ../i2c/chips, thenm do a depmod -ae.
> 
> I may not be compiling correctly.  The inline comments in Makefile confuse me as to whether I want the kernel modules or not.

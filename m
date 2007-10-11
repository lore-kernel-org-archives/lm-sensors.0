From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Oct 2007 07:45:43 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071011094543.23fc9d94@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Wed, 10 Oct 2007 10:12:05 -0700, Juerg Haefliger wrote:
> I don't know if there's an easier way but I usually do it the following way:
> 1) copy the i2c-nforce2.c file from the kernel source to a temp dir.
> 2) add a Makefile to the temp dir with the following content:
> 
> obj-m := i2c-nforce2.o
> EXTRA_CFLAGS += -DDEBUG
> all:
> 	make -C /lib/modules/`uname -r`/build M=`pwd` modules
> 
> 3) compile the module by running make
> 4) reload the new module. You have to remove the dme1737 module before
> unloading the i2c-nforce2 module.

You don't actually have to remove the dme1737 module. The i2c subsystem
is designed is such a way that bus drivers and chip drivers can be
loaded in any order.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

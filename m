From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: problem installing i2c and sensors, please help!!
Message-Id: <20030307221252.A31003@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030308025008.47671.qmail@web14904.mail.yahoo.com>
In-Reply-To: <20030308025008.47671.qmail@web14904.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Kanda Nikornpongsin <ni_kanda@yahoo.com> [2003-03-07 18:50:08 -0800]:
> 
> I followed the instruction and read FAQ over and over
> again. However I am still not able to successfully
> compile i2c-2.7.0
> 
> General info
> it's intel an mother board 810E chipset running RH8.0
> 
> I downloaded i2c-2.7.0.tar.gz. 
> run "make all" (with no complaint)
> however when run "make install"

You need to uncomment this line in the Makefile...

MODPREF := /lib/modules/$(KERNELVERSION)

.. and comment (using '#') the line before it.  Also look at the
SMP and MODVER lines (just above) while you're at it.  Stock RedHat
kernels tend to make this necessary.  You'll need to do this for 
lm_sensors2 Makefile also.  Remember to 'make clean' before you 'make' 
after you have modified the Makefile.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

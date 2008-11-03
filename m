From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 03 Nov 2008 08:36:01 +0000
Subject: Re: [lm-sensors] Andigilog driver by George Joseph
Message-Id: <490EB7F1.9040702@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020901060203090208020800"
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0811022213310.5906@belenos.adsl.univie.ac.at>
In-Reply-To: <Pine.LNX.4.64.0811022213310.5906@belenos.adsl.univie.ac.at>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901060203090208020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Wolfgang Pichl wrote:
> Hi,
> I would be extremely interested in the driver for the asc7621 which is 
> under development, because I have the Intel 975XBX2 motherboard.

Great, note that it is far easier to try this outside of an kernel tree. If you 
have a pre build distro kernel + headers, then just drop asc7621.c (which 
should be generated successfully by the patch) and the attached makefile in a dir.

Then in that dir type "make" followed by "insmod asc7621.ko"

> N.B. Is there any userspace support for this driver, perhaps a patch to 
> libsensors, already available?

If you use lm_sensors-3.0.x it will automatically work with any new drivers, 
per chip userspace support luckily is a thing of the past.

Regards,

Hans

--------------020901060203090208020800
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

obj-m += asc7621.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

--------------020901060203090208020800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020901060203090208020800--

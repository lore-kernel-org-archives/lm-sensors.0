From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: lm sensors error
Message-Id: <3DE3C55E.1040407@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm not the expert on the i2c-801 driver, but usually an occational 
collision/lock-up means that your bus is noisy or a faulty i2c chip is 
present on the bus.  If the bus really locks up (all readings are wrong 
until a hard reboot), then it's most likely a hardware error.  If it is 
temporary (readings return to normal after a few seconds), then it may 
be a bug in the code or a noisy bus.

I suggest trying the latest version of Lm_sensors (or at least i2c-801). 
 We are nearing the releasae of 2.7.0, so the code in CVS right now 
should be fairly stable if you'd like to try that.


Phil


Bryan Dang wrote:

>Hi Phil,
>
>We use the linux adm1021.c and i2c-801.c drivers to monitor the temperature
>and run into this SMBUS collision error messages occasionally. How serious
>is this error? Would that cause false temperature reading temporarily or
>permanently? Could this cause a problem else where such as PCI bus?
>
>	if (temp & 0x08) {
>		result = -1;
>		printk
>		    (KERN_ERR "i2c-i801.o: Bus collision! SMBus may be
>locked until next hard\n"
>		     "reset. (sorry!)\n");
>		/* Clock stops and slave is stuck in mid-transmission */
>	}
>
>Thank you,
>
>
>Bryan Dang
>Manager, Software Development
>Disk-based Libraries
>Quantum Corporation
>Storage Solutions Group
>P.O. Box 57100, Irvine, CA 92619-7100
>Tel: (949) 856-7807
>Fax: (949) 856-7799
>Email: bryan.dang@quantum.com
>Website: www.quantum.com
>
>  
>

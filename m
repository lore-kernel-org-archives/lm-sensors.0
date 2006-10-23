From: barrow_dj@yahoo.com (D.J. Barrow)
Date: Mon, 23 Oct 2006 11:58:52 +0000
Subject: [lm-sensors] lm93 porting questions
Message-Id: <20061023115852.52689.qmail@web51106.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark/Eric & others,
I am looking at backporting the lm93 driver 
( lm93-driver-2.6.13-rc3-mm3-0001.bin ) to Linux version 2.6.9-34
Red Hat Enterprise Linux 4 to meet a customer requirement.

The biggest problem with the port to date seems to be incompatible sysfs apis.
The attr stuff below being the primary source of the problems I think.
 struct device_attribute *attr
	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
How would one go about dealing with this?

sensors -v is reporting the following version
sensors version 2.8.7 with libsensors version 2.8.7

Do the kernel drivers & the user applications libsensors have to be matched,
is the driver interface exposed to libsensors stable?
Is backporting a bad idea as the libsensors etc. now
have to be modified to support the new lm93 driver & left the same
in parts to suppport the older sensor drivers.

If you advise we move to the latest kernel & sensors user applications we will
need to upgrade other drivers, do any of you know if there will be glibc compatibility
issues on upgrading the kernel.

Thanks in advance for your help,
D.J. Barrow


D.J. Barrow Linux kernel developer
email: dj_barrow at ariasoft.ie
email(work) denis.barrow at thalescomputers.fr
Work: +33-498-163412
Home: +353-22-47196.
Mobile (IRL) +353-(0)86 1715438

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


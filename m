From: matt@aclaro.com (Matthew Mastracci)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Patch for I2C + sysfs
Message-Id: <3FFF46DE.7010804@aclaro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109231724.GC4693@kroah.com>
In-Reply-To: <20040109231724.GC4693@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:

> This is why that class directory was created.  In order that userspace
> can find all of the i2c adapters.

Okay, good explaination.  Sorry to bother you with this question - I 
have a better understanding of what the /sys/bus directory is for.  :)

In fact, on further examination, i2c-adapter class devices are similar 
to scsi_host class devices.  scsi_hosts don't appear on the scsi bus - 
only scsi_devices do.

Thanks for your time,
Matt.

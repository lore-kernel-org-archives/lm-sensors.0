From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 24 Jul 2013 05:50:30 +0000
Subject: Re: [lm-sensors] Unable to get voltage on Intel QM67 / HM65 Express chipset
Message-Id: <20130724055030.GA9898@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20130721T012819-570@post.gmane.org>
In-Reply-To: <loom.20130721T012819-570@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 23, 2013 at 09:46:43PM -0700, Joseph Schmoley wrote:
> Hi Guenter,
> 
> Thanks for your reply.  I'm not a Linux guru by any means so I'm not quite
> sure what would be considered "interesting" in output of dmesg, so I ran
> the command and captured the output.  Please let me know if you see
> anything interesting in it:
> 
Here is the interesting part, which explains why you can not load the f71882fg driver.

[   23.589819] ACPI: resource f71882fg [io  0x0a10-0x0a17] conflicts with
ACPI region SEN1 [io 0xa15-0xa16]
[   23.589822] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver

http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

explains the reasons, and what you can do about it if you choose to do so.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

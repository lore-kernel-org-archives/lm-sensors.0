From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 15 May 2007 16:53:23 +0000
Subject: Re: [lm-sensors] Fintek F71882FG Driver -> Problems with
Message-Id: <4649E583.8090603@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c796e2$2af45760$20140a0a@EA002>
In-Reply-To: <000f01c796e2$2af45760$20140a0a@EA002>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans Edgington wrote:
> Hi,
> 
>> Ah, I think I understand now. And those addresses, 0a00-0a01 is where
>> you're 
>> driver detects the hwmon part of the fintek, correct?
> 
> Yes
> 
>> IOW, this printk in your driver, gets printed on those MSI boards:
>> printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x\n", *address);
>> With an address of 0x0a00, correct?
> 
>> And then when creating the platform device in f71882fg_device_add, the
>> device 
>> resource allocation fails, triggering this error printk:
>> 		printk(KERN_ERR DRVNAME ": Device resource addition failed
>> %d\n", err);
> 
>> Do I have it correct, that this is the problem the MSI users are seeing?
> 
> The resource addition failed message is not shown on the test system. 
> 

<sigh>, then what message is shown, what _exactly_ is the problem? Perhaps it
would help if instead of communicating with your testers in private, you would
CC the list on your communications. It would be very handy to be able to read
the problem as described  by the end users / testers. Also do these machines
have BIOS readings for their sensors? What is the exact dmesg output when
loading the driver, etc, etc. We need more details.

Regards,

Hans




> Regards,
> Hans
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

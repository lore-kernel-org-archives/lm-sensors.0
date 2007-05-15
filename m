From: "Hans Edgington" <hans@edgington.nl>
Date: Tue, 15 May 2007 11:13:49 +0000
Subject: Re: [lm-sensors] Fintek F71882FG Driver -> Problems with
Message-Id: <000f01c796e2$2af45760$20140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

>Ah, I think I understand now. And those addresses, 0a00-0a01 is where
>you're 
>driver detects the hwmon part of the fintek, correct?

Yes

>IOW, this printk in your driver, gets printed on those MSI boards:
>printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x\n", *address);
>With an address of 0x0a00, correct?

>And then when creating the platform device in f71882fg_device_add, the
>device 
>resource allocation fails, triggering this error printk:
>		printk(KERN_ERR DRVNAME ": Device resource addition failed
>%d\n", err);

>Do I have it correct, that this is the problem the MSI users are seeing?

The resource addition failed message is not shown on the test system. 

Regards,
Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

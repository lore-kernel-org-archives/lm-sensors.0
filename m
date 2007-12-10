From: Ed Sweetman <safemode2@comcast.net>
Date: Mon, 10 Dec 2007 01:32:41 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <475C9739.4030306@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com>	<20071209000554.GF20441@stusta.de>	<20071208212234.e00b74cd.mikeserv@bmts.com>	<20071209105028.06ed52a6@hyperion.delvare>	<E1J1TRp-0000ZF-6J@asgard.prans.org>	<20071209234215.748ed407@hyperion.delvare> <20071209191959.eba5a41f.mikeserv@bmts.com>
In-Reply-To: <20071209191959.eba5a41f.mikeserv@bmts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Houston <mikeserv@bmts.com>
Cc: Jean Delvare <khali@linux-fr.org>, Elvis Pranskevichus <el@prans.net>, Adrian Bunk <bunk@stusta.de>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>

Mike Houston wrote:
> On Sun, 9 Dec 2007 23:42:15 +0100
> Jean Delvare <khali@linux-fr.org> wrote:
>
>   
>> On Sun, 09 Dec 2007 16:12:25 -0500, Elvis Pranskevichus wrote:
>>     
>
>   
>>> This indeed looks like a broken ACPI BIOS since the
>>> aforementioned commit touches only the PNP ACPI driver. I'm not
>>> sure how to work around this, though. Ideas?
>>>       
>> Complaining to Gigabyte seems to be the best approach.
>>     
>
> I just happen to have a Windows Vista installation on this box as
> well, and I just thought to check. Sorry, I wish I'd have thought of
> it sooner but I don't go there often. You folks might be interested
> to know that Windows appears to have the same silly problem with the
> i/o resources (from Device Manager):
>
> [000000290 - 000000294]  Motherboard resources
> [000000290 - 00000029F]  Motherboard resources
>
> I don't have anything that reads sensors in Windows though, so I
> couldn't tell you if it could access that it87 chip or not.
>
> So this pretty much confirms that it's a motherboard/bios issue.
>
> Mike Houston
>
>   

I'm seeing this exact problem on an Asus Nforce4 based board. Prior to 
moving to 2.6.24-rc4 it worked just fine.  No additional acpi options 
were selected in kernel config.  

So add Asus A8N-E to the list of broken pnpacpi


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

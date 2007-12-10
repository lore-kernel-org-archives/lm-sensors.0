From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Dec 2007 14:55:50 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <20071210155550.1844b561@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com>
	<20071209000554.GF20441@stusta.de>
	<20071208212234.e00b74cd.mikeserv@bmts.com>
	<20071209105028.06ed52a6@hyperion.delvare>
	<E1J1TRp-0000ZF-6J@asgard.prans.org>
	<20071209234215.748ed407@hyperion.delvare>
	<20071209191959.eba5a41f.mikeserv@bmts.com>
	<475C9739.4030306@comcast.net>
In-Reply-To: <475C9739.4030306@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ed Sweetman <safemode2@comcast.net>
Cc: Mike Houston <mikeserv@bmts.com>, Elvis Pranskevichus <el@prans.net>, Adrian Bunk <bunk@stusta.de>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>

Hi Ed,

On Sun, 09 Dec 2007 20:32:41 -0500, Ed Sweetman wrote:
> I'm seeing this exact problem on an Asus Nforce4 based board. Prior to 
> moving to 2.6.24-rc4 it worked just fine.  No additional acpi options 
> were selected in kernel config.  
> 
> So add Asus A8N-E to the list of broken pnpacpi

For the records, can you please paste the offending lines (from the
boot logs or /proc/ioports)?

Then please give a try to Shaohua's patch and report:
http://lkml.org/lkml/diff/2007/12/9/186/1

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

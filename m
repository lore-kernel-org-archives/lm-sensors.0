From: Gabriel C <crazy@frugalware.org>
Date: Mon, 23 Jun 2008 12:41:29 +0000
Subject: Re: [lm-sensors] Asus atk0110 driver
Message-Id: <485F99F9.40704@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080618212629.GA7917@dreamland.darkstar.lan>
In-Reply-To: <20080618212629.GA7917@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Hi Gabriel,
> 
> On Sun, 22 Jun 2008 18:15:51 +0200, Gabriel C wrote:
>> I've tested the driver with linux-next on my P5E-VM DO motherboard.
>>
>> The driver seems to work , the values / data in  /sys/class/hwmon/hwmon0/device/*
>> seems to be the same like what the BIOS reports.
>>
>> However how do I get sensors to display the data from atk driver ?
>> I guess I have to patch lm-sensors ?
> 
> For lm-sensors 2.10.x, yes, you'd need to patch libsensors and sensors
> and virtually every monitoring application out there.
> 
> But the preferred solution is to just upgrade to lm-sensors 3.0.x,
> which automatically detects the device features, so every new driver is
> supported right away.


I've tested with 3.0.2 since 2.10* gave only a parse error.
Maybe is a problem with linux-next or something I'm missing in the config file ,
I will retest with linus tree soon.

> 
>> Luca what do you think about creating  a proper patch for the driver too and send it over to 
>> Greg to be included in his linux-staging tree ? I think that way it will get more testing.
> 
> Don't know which Greg you're thinking of? 


Greg Kroah-Hartman

>This is an ACPI-based
> hardware monitoring driver, so it would go to either the ACPI folks or
> (IMHO better) to the hwmon folks (i.e. the lm-sensors list). I agree
> that having a proper patch would be nice (but I also want to say that I
> will not have the time to review the driver myself.)
> 


Yes sure but from what I understand linux-staging[1] tree holds not_yet__really_ready_to_merge
drivers , filesystems and such. I don't think it does matter it is an ACPI driver.

[1] http://lkml.org/lkml/2008/6/10/329


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

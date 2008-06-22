From: Gabriel C <crazy@frugalware.org>
Date: Sun, 22 Jun 2008 16:15:51 +0000
Subject: Re: [lm-sensors] Asus atk0110 driver
Message-Id: <485E7AB7.5070003@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080618212629.GA7917@dreamland.darkstar.lan>
In-Reply-To: <20080618212629.GA7917@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

Hi Jean , Luca ,

> On Wed, 18 Jun 2008 23:26:29 +0200, Luca Tettamanti wrote:
>> Il Mon, Jun 16, 2008 at 09:32:27AM +0200, Jean Delvare ha scritto: 
>>> Apparently your post was not archived on acpi4asus-user. Can you please
>>> post your driver again, on the lm-sensors list this time? I'd like it
>>> to be archived publicly so that we can point users to it and it doesn't
>>> get lost.
>> Sure. This is the patch for in-kernel ACPI (diff against vanilla
>> 952f4a0a, somewhere after 2.6.26-rc6):
>> (...)
>> The source of the driver is attached (text/plain).
> 
> Thanks Luca. I've added a link to your post on wiki/Devices so that
> interested users and developers can find it easily.
> 


I've tested the driver with linux-next on my P5E-VM DO motherboard.

The driver seems to work , the values / data in  /sys/class/hwmon/hwmon0/device/*
seems to be the same like what the BIOS reports.

However how do I get sensors to display the data from atk driver ?
I guess I have to patch lm-sensors ?

Luca what do you think about creating  a proper patch for the driver too and send it over to 
Greg to be included in his linux-staging tree ? I think that way it will get more testing.

Best Regards ,

Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

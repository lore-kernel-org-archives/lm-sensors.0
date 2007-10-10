From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 10 Oct 2007 07:05:02 +0000
Subject: Re: [lm-sensors] syfs attributes for signaling
Message-Id: <470C799E.5030407@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071010004000.GA952@khazad-dum.debian.net>
In-Reply-To: <20071010004000.GA952@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Tue, 09 Oct 2007, Hans de Goede wrote:
>> I just got some info from Siemens (Thanks Thilo) on howto detect the presence 
>> of up to 2 power supplies with the fscscy and fscpos IC's and the status (OK or 
>> fail) of these. So we need to come up with a sysfs interface for this.
>>
>> I suggest:
>> powersupplyX_present
>> powersupplyX_fault
>>
>> How does that sound?
> 
> Don't we have a sysfs powersupply class?  It should probably be used
> instead.
> 

That would be a good idea if the darn thing was documented:
[hans@localhost linux-2.6.23-rc9.git4]$ grep -r powersupply Documentation
Documentation/arm/SA1100/LART:through a number of connectors. The powersupply 
accepts voltages
[hans@localhost linux-2.6.23-rc9.git4]$

And:
[hans@localhost linux-2.6.23-rc9.git4]$ find -name '*powersupply*.c'
[hans@localhost linux-2.6.23-rc9.git4]$

And:

[hans@localhost linux-2.6.23-rc9.git4]$ grep -r powersupply .
./Documentation/arm/SA1100/LART:through a number of connectors. The powersupply 
accepts voltages
./drivers/sbus/char/bbc_envctrl.c:       * power for cpu/system and 'on' fo the 
powersupply fan
[hans@localhost linux-2.6.23-rc9.git4]$

So either it isn't named powersupply or it is very well hiden.

GRR, found it, actually it is named power_supply. Yes that will work well, thanks!

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

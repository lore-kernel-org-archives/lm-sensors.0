From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Dec 2007 18:22:27 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071210192227.32ca5351@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

On Mon, 10 Dec 2007 19:12:36 +0100, Peter Ganzhorn wrote:
> Thanks for your reply - is it possible that I am missing a driver to 
> access my smbus? I enabled the i2C driver for the ICH8 chips 
> (CONFIG_I2C_I801) and that's about it.

You're not missing any driver. What you're missing is the SMBus master
device itself, because it was hidden from you by the BIOS, but given
what the BIOS does with it, that's the only safe approach.

> I investigated the cpu-z output as well and it seems it is using the 
> current VID setting to display the voltage - there seem to be no 
> fluctuations in voltage which is kinda strange for real hardware...

OK, this confirms Rudolf's theory then.

> And BTW, I ommitted some obvious useless output of sensors-detect which 
> I consider to be smbus-related; but it looks like smbus is a complete no-go:
> 
> # sensors-detect revision 4609 (2007-07-14 09:28:39 -0700)
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Sorry, no known PCI bus adapters found.

This confirms my guess that the SMBus is hidden on your system.

> (...)
> If you can think of any other way to see what *real* vcore my cpu runs 
> with let me know, but I am afraid it won't be possible considering what 
> you've told me.

Indeed I do not think that you'll be able to do that on your laptop.
That's pretty common for laptops, BTW. Laptops where voltages can be
monitored are the exception, not the rule.

> Thanks anyways for the great job you are doing with sensors,

Thanks :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

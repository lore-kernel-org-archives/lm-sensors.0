From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 15 Jul 2015 14:37:23 +0000
Subject: Re: [lm-sensors] support for IT8586E
Message-Id: <20150715143723.GB32367@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANOLSHBWuQCpJTUT3aNi7_rqPwPT4QK7CkVxvhcuyfm4qqFw8g@mail.gmail.com>
In-Reply-To: <CANOLSHBWuQCpJTUT3aNi7_rqPwPT4QK7CkVxvhcuyfm4qqFw8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 15, 2015 at 09:46:26AM +0200, Jean Delvare wrote:
> Hi Dev,
> 
> On Tue, 14 Jul 2015 23:27:41 -0400, Dev Anand wrote:
> > I got myself a Lenovo z50-75. The fan is always on. And, sensors-detect
> > reports the following.
> > 
> > Trying family `ITE'...                                      No
> > 
> > Probing for Super-I/O at 0x4e/0x4f
> > 
> > Trying family `National Semiconductor/ITE'...               Yes
> > 
> > Found unknown chip with ID 0x8586
> > 
> > 
> > Appears to be IT8586E. Are there any plans of supporting this chip. I don't
> > see it listed on the http://www.lm-sensors.org/wiki/Devices web site.
> 
> It's not listed on ITE's website either. Never heard of that chip. I've
> added an entry in the wiki, with your request. But without a datasheet
> there's nothing we can do.
> 
I think this is an embedded controller, not a legacy Super-IO chip.
Trying the ACPI drivers you mentioned below might be the best option.

Guenter

> Please note that on a laptop the fan is most certainly controlled by
> ACPI anyway so a driver for the IT8586E would not necessarily help. If
> the fan does not behave the way it should, you should check the BIOS
> options and report the problem to the linux-acpi ACPI.
> 
> Also check the thinkpad_acpi and ideapad-laptop kernel drivers. There
> is no explicit mention of your laptop model there but other Lenovo
> laptops are supported so maybe support for your model could/should be
> added there.
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 May 2011 08:44:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver sch5636
Message-Id: <20110527104440.786c9f06@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306255997-4337-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1306255997-4337-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 27 May 2011 10:01:26 +0200, Hans de Goede wrote:
> On 05/26/2011 09:09 PM, Jean Delvare wrote:
> > On Tue, 24 May 2011 18:53:17 +0200, Hans de Goede wrote:
> >> +#define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
> >> +#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
> >
> > Each being used only once, I'm not sure if you really need defines.
> 
> idem as above, and the same goes for many other drivers, AFAIK all superio
> drivers do it like this...

All drivers for SMSC super-I/O devices, maybe. ITE, VIA, Winbond,
Nuvoton and Fintek super-I/O devices need a multi-byte key to activate
the configuration space, so such defines just don't work.

Anyway this isn't very important, I have not problem if you keep the
defines the way they are.

> >> (...)
> >> +static int sch5636_send_cmd(struct sch5636_data *data, u8 cmd, u16 reg, u8 v)
> >> +{
> >
> > This looks very similar to the SCH5627. Have you considered having a
> > single driver for both? Or at least having a common part?
> 
> Actually it is identical, I've considered having a single driver but there
> are quite a lot of differences, and I've a feeling we may see more Fujitsu
> solutions based on the sch5636, so it seemed better to make to make it a
> clean new driver (also keeping in mind that we may need to support multiple
> models with it in the future).
> 
> Thinking more about this, I think this may be best handled as follows:
> 
> Have a sch5627-common.ko which contains the sch5627_send_cmd + read / write
> virtual reg functions, as well as the sch5627_find and sch5627_device_add
> functions (which will now find and device_add both the sch5627 and sch5636,
> and have a sch5627.ko and a sch5636.ko which contain the actual driver(s),
> and do the platform_driver[un]register. Loading either if these 2 will
> automatically also load sch5627-common.ko (since they use symbols from it)
> which will then do the find + device add.
> 
> Does this sound like an idea?

This is exactly what I had in mind, actually. Except that I would name
the common module "sch56xx" for neutrality.

> >> (...)
> >> +	if (strcmp(id, "THS")) {
> >> +		pr_err("Unknown Fujitsu id: '%s'\n", id);
> >
> > This could print complete garbage, you have no guarantee that the bytes
> > are in the 32-126 range.
> >
> 
> Good point, still I would like to print it as a string so that if a user
> encounters a new device before I know about it, they can give me the
> 3 letter Fujitsu ID. I see 2 options:
> 
> 1) Always print it as %02x%02x%02x
> 2) Sanity check and print as string if sanity check matches, else
>     as %02x%02x%02x.

Both are fine with me. Option 1 is easiest to implement, option 2 will
make discovering new devices easier. Up to you, really.

> > (...)
> > Out of curiosity, why are you checking 0x4e first, when all other
> > drivers check 0x2e first?
> 
> Because the 2 boards (sch5627 + sch5636) have them at 0x4e rather
> then 0x2e. And before your review of the sch5627 driver it used
> to print an error when it could not find the chip it 0x2e...
> 
> Anyways if we change this, we should fix it in the sch5627 driver too.

No need to change it, it makes sense to check the most popular address
first. I was just curious.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

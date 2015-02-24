From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Feb 2015 18:14:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for additional IDT temperature sensors
Message-Id: <20150224181404.GA14180@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423769172-13519-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423769172-13519-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, Feb 23, 2015 at 08:52:47PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late review.
> 
No problem - we are all busy.

> On Thu, 12 Feb 2015 11:26:12 -0800, Guenter Roeck wrote:
> > TS3000GB0 has a new device ID (0x2913). Since IDT's datasheets suggest
> > that the upper 8 bit of the device ID reflect the chip ID and the lower
> > 8 bit reflect the version number, modify the code to accept all chips
> > with ID 0x29xx.
> 
> You did that for all other IDT chips as well. While this is in
> accordance with the datasheets, this might lead to some false
> positives, as the driver probes 8 popular I2C addressed and the
> detection code doesn't check for that many bits anymore.
> 
> That being said I don't have a strong feeling about it. We can leave it
> this way for now and revisit it later if false positives are actually
> reported.
> 
We could check some other registers instead; the limit registers
have five unused bits. Would it make sense to check those ?

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
> What I would like though is that the detection code in sensors-detect
> is updated to be in line with what the driver does now. It gets
> confusing if sensors-detect finds a chip which the driver rejects or
> misses a chip which the driver would support.
> 
Ok, I'll do that.

> > Also add support for TS3001 and TSE2004.
> 
> That needs to be done in sensors-detect as well.
> 
Yes.

> All these chips could be added to the Devices page in the wiki too.
> 
Sure, will do.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 04 Jul 2014 20:20:27 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm9240) Avoid forward declaration
Message-Id: <20140704222027.4718162e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395989.4895.12.camel@phoenix>
In-Reply-To: <1404395989.4895.12.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 04 Jul 2014 10:10:14 -0700, Guenter Roeck wrote:
> On 07/04/2014 05:23 AM, Jean Delvare wrote:
> > Note that support for banked registers could be added if you think this
> > would help.
> 
> That would be quite useful. How would you implement it, though ? You would have
> to have a means to tell the driver "this is a bank register". Another module
> parameter, maybe ?

Not just "this is a bank register". You also most specify which bits
set the bank number (which in turn define the maximum number of banks),
and the range of banked registers.

I did not think about it in depth yet, but there are two options that
come to my mind: module parameters indeed, or sysfs attributes. We
could create a sysfs directory for every client address and have
writable attributes bank_reg, bank_mask, banked_start_reg and
banked_end_reg in that directory. Not sure exactly where actually,
maybe we would need to introduce a virtual i2c-stub device, or use
debugfs.

Module parameters would work too, that's probably easier to implement
that way, but that's also less flexible, as you have to setup
everything upon module loading. That might be just fine though, as
being able to change the bank setup at run-time has little practical
value IMHO.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

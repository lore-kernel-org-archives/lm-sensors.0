From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Feb 2011 15:33:32 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add capability to
Message-Id: <20110209163332.11390be7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110208204952.GA15232@ericsson.com>
In-Reply-To: <20110208204952.GA15232@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Feb 2011 07:01:04 -0800, Guenter Roeck wrote:
> On Wed, Feb 09, 2011 at 08:02:55AM -0500, Jean Delvare wrote:
> > So we have to think about the usage of the EMC devices in question. Do
> > you know if any of these are being, or will be, used on PC boards?
> > Remember that the purpose of sensors-detect is not to be a universal
> > hardware monitoring device detector. It's primarily aimed at PC users.
> > Users of embedded devices or exotic hardware should know what hardware
> > monitoring devices they have, and these device should be instantiated by
> > the kernel directly, rather than being detected from user-space.
>
> No idea. It wasn't specifically that I need it or that we are going to use 
> any of the chips. I just got into it after the recent emc driver submission,
> and figured that since I tracked down the addresses and chip IDs, I might
> as well put my knowledge to some use.
> 
> Also, while you are right about platform data on embedded devices
> for the running code, there are additional aspects to consider.
> 
> First, I have often seen that HW specs for embedded devices can more or less
> only be seeen as guidance. Not only do chips show up on unexpected addresses,
> I have seen instances where chips were not there at all, or undocumented
> chips show up. This gets difficult if one has to port linux to some older device,
> where the HW designers may no longer be there.

Missing chips are easy to deal with (i2c_new_probed_device()) and
irrelevant to this discussion anyway.

Chips at the wrong address can be spotted with i2cdetect, not need for
sensors-detect.

For unexpected chips, I agree that sensors-detect can be useful (on the
assumption that we are looking for a hardware monitoring device.)

> Second, there is the case of people porting Linux to a box which wasn't supposed
> to run Linux.
> 
> In both cases, sensors-detect can be a very useful tool to help figuring out
> what is actually there.

I wouldn't disagree. But as this isn't the primary use case for the
script, and probing all addresses has known downsides, you would have
to introduce a special flag if you really want to probe addresses which
we know aren't used on PC hardware. We really don't want it to happen
by default.

> How about removing the new addresses from the list ? Would you be ok 
> with the patch if I do that ?

Yes, I would be perfectly OK then.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

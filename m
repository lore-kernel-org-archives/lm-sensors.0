From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 27 May 2015 14:58:04 +0000
Subject: Re: [lm-sensors] I2C addresses of TMP435
Message-Id: <20150527165804.4eec4832@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150527112549.1e5e0e2f@endymion.delvare>
In-Reply-To: <20150527112549.1e5e0e2f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 27 May 2015 06:15:15 -0700, Guenter Roeck wrote:
> On 05/27/2015 02:25 AM, Jean Delvare wrote:
> > Hi Guenter,
> >
> > In this commit:
> > http://www.lm-sensors.org/changeset/6260
> >
> > You listed 0x37 as a possible address for the TMP435. While this is
> > correct, I don't think we want to probe this address. Currently we do
> > not probe it for any other chip, and we even removed it explicitly in
> > the past:
> > http://www.lm-sensors.org/changeset/3233
> >
> > In the light of recent reports of display breakage caused by
> > sensors-detect I would like to play it safe and not probe address 0x37
> > (which is used by some EEPROMs as well as the DDC/CI interface.)
> >
> > While less critical, it might also make sense to remove 0x37 from
> > normal_i2c[] in the tmp401 driver. Users with a TMP435 as this address
> > can always instantiate it explicitly.
> >
> > What do you think?
> 
> Ok with me. 0x37 is also scanned by the atxp1 driver, so I assume
> we would have to remove it from both for it to make a difference.

I've been willing to drop the detect function from the atxp1 driver for
a long time, I suppose now is the time. It's very weak. And we don't
even detect that chip in sensors-detect.

That being said, it would still make sense to remove address 0x37 from
the tmp401 driver, as it is much more likely to be loaded than the
atxp1 driver. For example the sensors-detect script could tell you to
load the tmp401 driver for another address, and when you load it, the
driver ends up probing 0x37 and hits a different chip with bad
consequences.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

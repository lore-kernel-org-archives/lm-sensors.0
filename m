From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Jun 2011 16:00:03 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <20110622180003.22bbada7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Jun 2011 13:41:54 +0530 (IST), krunal patel wrote:
> --- On Tue, 21/6/11, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > From: Jean Delvare <khali@linux-fr.org>
> > Subject: Re: [lm-sensors] sensor details for W83627HG-AW
> > To: "krunal patel" <krunal_smiles@yahoo.com>
> > Cc: lm-sensors@lm-sensors.org, "Guenter Roeck" <guenter.roeck@ericsson.com>
> > Date: Tuesday, 21 June, 2011, 5:20 PM
> > Could you please install the msr-tools package, load the msr driver,
> > and run as root:
> > # rdmsr -x 0x198
> > and report the result.
> > 
> Following is output you asked for
> # rdmsr -x 0x198        
> 400050004000500

OK, this is as I thought. The last two bytes are as documented in the
datasheet: 0x05 for 5 * 100 = 500 MHz and 0x00 for the lowest voltage
level. We might use the later to get cpu0_vid from the CPU itself, as
the monitoring ship won't be able to provide it.

> > BTW you should also be able to use the via-cputemp driver.
> > Didn't sensors-detect suggest that?
> > 
> I didn't used sensors-detect because it was wasting my time in resolving perl issues in my system. So I opened case, located chip and loaded related module.

I see. The via-cputemp driver probably doesn't exist in your kernel as
it was added with version 2.6.33. Can you please fetch the standalone
one at:
  http://khali.linux-fr.org/devel/misc/via-cputemp/
It should work. Please also update hwmon-vid from:
  http://khali.linux-fr.org/devel/misc/hwmon-vid/
I've updated it for your system. If these two drivers work well
together for you then I'll push the changes upstream.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

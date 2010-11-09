From: Joe Perches <joe@perches.com>
Date: Tue, 09 Nov 2010 10:04:02 +0000
Subject: Re: [lm-sensors] [PATCH 32/32] drivers/hwmon/w83781d.c: Use pr_fmt
Message-Id: <1289297042.1823.48.camel@Joe-Laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
	 <1ce82b2a1c726d252483c508053eff046abcf132.1287556801.git.joe@perches.com>
	 <20101109103948.25919efe@endymion.delvare>
In-Reply-To: <20101109103948.25919efe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, 2010-11-09 at 10:39 +0100, Jean Delvare wrote:
> On Tue, 19 Oct 2010 23:51:56 -0700, Joe Perches wrote:
> > Added #define pr_fmt KBUILD_MODNAME ": " fmt
> > Converted printks to pr_<level>
> > Coalesced any long formats
> > Removed prefixes from formats
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/hwmon/w83781d.c |   29 ++++++++++++++---------------
[]
> > @@ -1811,7 +1812,7 @@ w83781d_isa_found(unsigned short address)
> >  	if (inb_p(address + 2) != val
> >  	 || inb_p(address + 3) != val
> >  	 || inb_p(address + 7) != val) {
> > -		pr_debug("w83781d: Detection failed at step 1\n");
> > +		pr_debug("Detection failed at step 1\n");
> I think this would be the right time to change this to:
> 		pr_debug("Detection failed at step %d\n", 1);
> and do the same for all 6 messages below, so that the compiler can
> store the string only once in the binary.

Fine by me.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

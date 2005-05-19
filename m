From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: "probe" module param broken for it87 in Linux 2.6.6
Message-Id: <20040514215904.GB16000@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 13, 2004 at 06:09:57PM +0200, Bj?rn Mork wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> > So I'd suggest that you simply use the standard exit sequence in the
> > it87 driver (the second one in your current patch). A patch for the 2.4
> > driver would be appreciated as well.
> 
> OK.  I've attached a new version of the patch against linux-2.6.6.
> I'll send a patch against current lm_sensors CVS removing the extra
> exit command in a separate mail.
> 
> Greg KH <greg@kroah.com> writes:
> > On Wed, May 12, 2004 at 04:38:03PM +0200, Bj?rn Mork wrote:
> >> +	if (!it87_find(&addr)) {
> >> +		printk("it87.o: new ISA address: 0x%04x\n", addr);
> >
> > That printk is wrong (no KERN_ level, or dev_printk() style use).
> > Please fix it in your next revision of this patch.
> 
> Errh, I just added it to document my sloppyness.  It was never meant
> to be in the patch I sent you.  Sorry.  Removed in the attached patch.
> The style of these drivers seem to be "just working, making no noise"
> so I assume informational printk's are unwanted.

Looks good, applied, thanks.

greg k-h

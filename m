From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Mon, 29 Mar 2010 16:07:13 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] resource: shared I/O region support
Message-Id: <20100329090713.1317942b@jbarnes-piketon>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100325125005.6d58cfaf@lxorguk.ukuu.org.uk>
	<1269523063-30346-1-git-send-email-me@mortis.eu>
	<20100325155705.1ec79dbc@lxorguk.ukuu.org.uk>
	<20100325180347.GA2761@salidar.me.mortis.eu>
	<20100325181633.0313b8a5@lxorguk.ukuu.org.uk>
	<20100329081834.GB27956@salidar.me.mortis.eu>
In-Reply-To: <20100329081834.GB27956@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 29 Mar 2010 10:18:34 +0200
Giel van Schijndel <me@mortis.eu> wrote:

> On Thu, Mar 25, 2010 at 06:16:33PM +0000, Alan Cox wrote:
> >> +			if (res->flags & IORESOURCE_MUXED)
> >> +				wake_up(&muxed_resource_wait);
> >>  			kfree(res);
> >>  			return;
> > 
> > And you'll want a
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> Yes, thanks.
> 
> Anyone specific I should mail to get this patch applied? I don't see any
> entry in MAINTAINERS for kernel/resource.c or include/linux/resource.h.

I can take it; sometimes Linus applies resource stuff directly though.

Can you resend with the appropriate s-o-bs etc?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

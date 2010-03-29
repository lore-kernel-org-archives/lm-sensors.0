From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 29 Mar 2010 17:45:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] resource: shared I/O region support
Message-Id: <4BB0E73F.2080104@zytor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100325125005.6d58cfaf@lxorguk.ukuu.org.uk> <1269523063-30346-1-git-send-email-me@mortis.eu> <20100325155705.1ec79dbc@lxorguk.ukuu.org.uk> <20100325180347.GA2761@salidar.me.mortis.eu> <20100325181633.0313b8a5@lxorguk.ukuu.org.uk> <20100329081834.GB27956@salidar.me.mortis.eu> <20100329090713.1317942b@jbarnes-piketon> <20100329173800.GA3583@salidar.me.mortis.eu>
In-Reply-To: <20100329173800.GA3583@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 03/29/2010 10:38 AM, Giel van Schijndel wrote:
> 
> Patch after this line:
> ====================================
> resource: shared I/O region support
> 
> SuperIO devices share regions and use lock/unlock operations to chip
> select.  We therefore need to be able to request a resource and wait for
> it to be freed by whichever other SuperIO device currently hogs it.
> Right now you have to poll which is horrible.
> 
> Add a MUXED field to IO port resources. If the MUXED field is set on the
> resource and on the request (via request_muxed_region) then we block
> until the previous owner of the muxed resource releases their region.
> 
> This allows us to implement proper resource sharing and locking for
> superio chips using code of the form
> 
> enable_my_superio_dev() {
> 	request_muxed_region(0x44, 0x02, "superio:watchdog");
> 	outb() ..sequence to enable chip
> }
> 
> disable_my_superio_dev() {
> 	outb() .. sequence of disable chip
> 	release_region(0x44, 0x02);
> }
> 
> Signed-off-by: Giel van Schijndel <me@mortis.eu>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

I have to question this approach a bit.

I would much rather see this as a two-step process, where multiple
devices request the same region with a "sharable" flag, and then have a
mutex associated with the struct resource (perhaps we need an outer
container called "struct muxed_resource" or some such.)

What I *really* object to with this patch is that it inherently assumes
that there is only one multiplexed resource in the entire system... but
of course nowhere enforces that.

	-hpa

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

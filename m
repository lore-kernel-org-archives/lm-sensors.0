From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 29 Mar 2010 18:39:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] resource: shared I/O region support
Message-Id: <20100329193933.1a04762b@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100325125005.6d58cfaf@lxorguk.ukuu.org.uk>
	<1269523063-30346-1-git-send-email-me@mortis.eu>
	<20100325155705.1ec79dbc@lxorguk.ukuu.org.uk>
	<20100325180347.GA2761@salidar.me.mortis.eu>
	<20100325181633.0313b8a5@lxorguk.ukuu.org.uk>
	<20100329081834.GB27956@salidar.me.mortis.eu>
	<20100329090713.1317942b@jbarnes-piketon>
	<20100329173800.GA3583@salidar.me.mortis.eu>
	<4BB0E73F.2080104@zytor.com>
In-Reply-To: <4BB0E73F.2080104@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Giel van Schijndel <me@mortis.eu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

> What I *really* object to with this patch is that it inherently assumes
> that there is only one multiplexed resource in the entire system... but
> of course nowhere enforces that.

The patch does nothing of the sort. Not unless there is a bug I am not
seeing anyway. It does assume nobody tries to grab pairs of such
resources as it doesn't do deadlock avoidance.

It's now a shared resource patch however, its a multiplexor patch and
that is precisely why it is called MUX not SHARED or OVERLAY
Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

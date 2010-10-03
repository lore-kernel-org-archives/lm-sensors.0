From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Oct 2010 09:01:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: f71882fg: use a muxed resource
Message-Id: <20101003110110.49b3caf4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100801132226.GE3711@salidar.me.mortis.eu>
	<1280669455-31283-1-git-send-email-me@mortis.eu>
	<4C59514A.7090401@redhat.com>
	<20101002225958.GA18605@salidar.me.mortis.eu>
	<20101003010635.GB29454@ericsson.com>
In-Reply-To: <20101003010635.GB29454@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Giel van Schijndel <me@mortis.eu>, Hans de Goede <hdegoede@redhat.com>, Laurens Leemans <laurens@signips.com>, Jonathan Cameron <jic23@cam.ac.uk>, Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "597820@bugs.debian.org" <597820@bugs.debian.org>

On Sat, 2 Oct 2010 18:06:35 -0700, Guenter Roeck wrote:
> On Sat, Oct 02, 2010 at 06:59:58PM -0400, Giel van Schijndel wrote:
> > On Wed, Aug 04, 2010 at 01:38:50PM +0200, Hans de Goede wrote:
> > > Ack!
> > > 
> > > Acked-by: Hans de Goede <hdegoede@redhat.com>
> > > 
> > > On 08/01/2010 03:30 PM, Giel van Schijndel wrote:
> > >> Sleep while acquiring a resource lock on the Super I/O port. This should
> > >> prevent collisions from causing the hardware probe to fail with -EBUSY.
> > >> 
> > >> Signed-off-by: Giel van Schijndel<me@mortis.eu>
> > 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Jean, if it is ok with you, I can apply it to my tree.

I have no objection. I never had the time to look at these patches, and
won't have it any time soon. So I'm very happy if you can handle them.

> I tried to find the patch on the web in downloadable form, but didn't find
> the correct version of it. So it would be great if you could re-send it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

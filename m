From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Sat, 18 Dec 2010 14:40:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101218144049.GA21801@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com> <1292624661-32474-1-git-send-email-mjg@redhat.com> <20101218042320.GA14104@ericsson.com> <20101218090714.GA436@polaris.bitmath.org>
In-Reply-To: <20101218090714.GA436@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sat, Dec 18, 2010 at 10:07:14AM +0100, Henrik Rydberg wrote:
> On Fri, Dec 17, 2010 at 08:23:21PM -0800, Guenter Roeck wrote:
> > On Fri, Dec 17, 2010 at 05:24:20PM -0500, Matthew Garrett wrote:
> > > The AppleSMC device is described in ACPI, including a list of its resources.
> > > We should use those rather than hardcoding the ports. A side-effect is that
> > > we can then remove the DMI matching, since there's a unique identifier to
> > > indicate that the machine has one of these devices.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > You added a whitespace error, and kfree() is safe and doesn't need a check.
> > I fixed those, so no need to resubmit. If Henrik gives his Ack we are ready to go.
> 
> Thanks, I will give it some testing before doing so. Matthew, did you
> test this under EFI boot? Also, NOTIFICATION_KEY does not seem to be
> used anywhere.

I tested under EFI and BIOS. NOTIFICATION_KEY is there for adding 
interrupt support - I got that hooked up but it seems that the latest 
Air is lacking the sudden motion sensor (probably because it's an 
SSD-only model) so wasn't able to test it. I'll play some more and add a 
further patch for that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

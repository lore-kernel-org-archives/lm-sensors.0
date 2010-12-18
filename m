From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 18 Dec 2010 09:07:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101218090714.GA436@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
 <1292624661-32474-1-git-send-email-mjg@redhat.com>
 <20101218042320.GA14104@ericsson.com>
In-Reply-To: <20101218042320.GA14104@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Dec 17, 2010 at 08:23:21PM -0800, Guenter Roeck wrote:
> On Fri, Dec 17, 2010 at 05:24:20PM -0500, Matthew Garrett wrote:
> > The AppleSMC device is described in ACPI, including a list of its resources.
> > We should use those rather than hardcoding the ports. A side-effect is that
> > we can then remove the DMI matching, since there's a unique identifier to
> > indicate that the machine has one of these devices.
> > 
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> 
> You added a whitespace error, and kfree() is safe and doesn't need a check.
> I fixed those, so no need to resubmit. If Henrik gives his Ack we are ready to go.

Thanks, I will give it some testing before doing so. Matthew, did you
test this under EFI boot? Also, NOTIFICATION_KEY does not seem to be
used anywhere.

Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Matthew Garrett <mjg@redhat.com>
Date: Thu, 16 Dec 2010 17:00:41 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] applesmc: Use PnP rather than
Message-Id: <20101216170041.GA11346@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292513589-14651-1-git-send-email-mjg@redhat.com> <4D0A42CE.7030000@euromail.se>
In-Reply-To: <4D0A42CE.7030000@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>

On Thu, Dec 16, 2010 at 05:48:14PM +0100, Henrik Rydberg wrote:
> > The AppleSMC device is described in ACPI, including a list of its resources.
> 
> > We should use those rather than hardcoding the ports. A side-effect is that
> > we can then remove the DMI matching, since there's a unique identifier to
> > indicate that the machine has one of these devices.
> > 
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> 
> 
> Thank you very much for these patches. Unfortunately, they do not quite apply in
> this end. If you could please rebase to linux-next [1], that would be great.

Ah, sorry, I thought I'd pulled the same set of patches. I'll rebase.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

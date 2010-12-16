From: Henrik Rydberg <rydberg@euromail.se>
Date: Thu, 16 Dec 2010 16:48:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] applesmc: Use PnP rather than
Message-Id: <4D0A42CE.7030000@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292513589-14651-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1292513589-14651-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>

Hi Matthew,

> The AppleSMC device is described in ACPI, including a list of its resources.

> We should use those rather than hardcoding the ports. A side-effect is that
> we can then remove the DMI matching, since there's a unique identifier to
> indicate that the machine has one of these devices.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>


Thank you very much for these patches. Unfortunately, they do not quite apply in
this end. If you could please rebase to linux-next [1], that would be great.

Thanks,
Henrik

[1] You find the same version in Guenther's tree or in
git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/hwmon.git, if that is more
convenient.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

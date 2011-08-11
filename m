From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Thu, 11 Aug 2011 19:29:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: Convert applesmc driver to pnp
Message-Id: <20110811192949.GA5885@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthew,

> The applesmc driver is current a platform device with DMI matching. All
> machines with the appropriate hardware actually expose it via an acpipnp
> device, so it makes sense to use that rather than hardcoding model names
> and addresses.

Sounds good, but has the approach been tested on a representative set
of machines?

> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/hwmon/applesmc.c |  660 +++++++++++++++++++++++++--------------------
>  1 files changed, 367 insertions(+), 293 deletions(-)

The patch seems to do too many things - switching from static
variables to a dev struct, adding dev parameters to all functions,
changing to dynamic initialization, changing from platform to pnp
device. Two patches with no functional changes to start with, then
another two to turn on pnp seems reasonable.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

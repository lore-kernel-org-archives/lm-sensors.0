From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 11 Aug 2011 20:19:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: Convert applesmc driver to pnp
Message-Id: <20110811201927.GA31539@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 11, 2011 at 09:29:49PM +0200, Henrik Rydberg wrote:

> The patch seems to do too many things - switching from static
> variables to a dev struct, adding dev parameters to all functions,
> changing to dynamic initialization, changing from platform to pnp
> device. Two patches with no functional changes to start with, then
> another two to turn on pnp seems reasonable.

I've looked into this and I don't think it's especially practical to do 
it this way. As an example, applesmc_backlight_set calls 
applesmc_write_key, but it's a workqueue. The work struct is just a 
static structure, so it's not possible to obtain the device from there. 
It could just call the static platform device, but that just results in 
an intermediate stage that's worse than the previous one, which kind of 
defeats the object. If you'd like it broken up then the reasonable way 
would seem to be to do everything but the pnp transition in one patch 
and change to pnp in another.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

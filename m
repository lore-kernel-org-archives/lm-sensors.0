From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 18 Dec 2010 15:30:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101218153012.GA1506@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
 <1292624661-32474-1-git-send-email-mjg@redhat.com>
 <20101218042320.GA14104@ericsson.com>
 <20101218093719.GA1493@polaris.bitmath.org>
 <20101218144329.GB21801@srcf.ucam.org>
In-Reply-To: <20101218144329.GB21801@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

> Hm. Is this an oops or a lockdep warning?

It is a null-pointer dereference in sysfs_create_file(). Probably the
kernel is asking the same question as I did - do you actually see the
sysfs nodes when testing the patch?

> > So where to attach the sysfs nodes... There is also a userspace issue
> > here, since a lot of applications are hard-wired to
> > /sys/devices/platform/applesmc.768/.
> 
> The correct sysfs ABI is to use the /sys/class interface and the names 
> under there rather than assuming a hardwired platform device path.

Still breaks user-space, but it seems this is already under control.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

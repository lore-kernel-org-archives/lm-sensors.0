From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 18 Dec 2010 10:31:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101218103139.GA1668@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
 <1292624661-32474-1-git-send-email-mjg@redhat.com>
 <20101218042320.GA14104@ericsson.com>
 <20101218093719.GA1493@polaris.bitmath.org>
 <20101218110954.7a2ca190@endymion.delvare>
In-Reply-To: <20101218110954.7a2ca190@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

On Sat, Dec 18, 2010 at 11:09:54AM +0100, Jean Delvare wrote:
> On Sat, 18 Dec 2010 10:37:19 +0100, Henrik Rydberg wrote:
> > So where to attach the sysfs nodes... There is also a userspace issue
> > here, since a lot of applications are hard-wired to
> > /sys/devices/platform/applesmc.768/.
> 
> Which applications? libsensors-based applications definitely don't
> hard-wire anything.

The ones I am thinking of are pommed and macfanctld, there are
probably others. The sysfs nodes have been around a while, so it is
not really surprising. If there is a policy saying it is ok to break
userspace in this case, that's fine.

Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

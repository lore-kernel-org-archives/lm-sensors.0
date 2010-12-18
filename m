From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Dec 2010 10:09:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101218110954.7a2ca190@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
	<1292624661-32474-1-git-send-email-mjg@redhat.com>
	<20101218042320.GA14104@ericsson.com>
	<20101218093719.GA1493@polaris.bitmath.org>
In-Reply-To: <20101218093719.GA1493@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

On Sat, 18 Dec 2010 10:37:19 +0100, Henrik Rydberg wrote:
> So where to attach the sysfs nodes... There is also a userspace issue
> here, since a lot of applications are hard-wired to
> /sys/devices/platform/applesmc.768/.

Which applications? libsensors-based applications definitely don't
hard-wire anything.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

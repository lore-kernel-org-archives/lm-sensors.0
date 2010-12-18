From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 18 Dec 2010 11:57:42 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101218115742.GA2063@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
 <1292624661-32474-1-git-send-email-mjg@redhat.com>
 <20101218042320.GA14104@ericsson.com>
 <20101218093719.GA1493@polaris.bitmath.org>
 <20101218110954.7a2ca190@endymion.delvare>
 <20101218103139.GA1668@polaris.bitmath.org>
 <878vzngvyn.fsf@sonic.technologeek.org>
In-Reply-To: <878vzngvyn.fsf@sonic.technologeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julien BLACHE <jb@jblache.org>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, Mikael Strom <mikael@sesamiq.com>

On Sat, Dec 18, 2010 at 12:29:52PM +0100, Julien BLACHE wrote:
> "Henrik Rydberg" <rydberg@euromail.se> wrote:
> 
> Hi,
> 
> >> Which applications? libsensors-based applications definitely don't
> >> hard-wire anything.
> >
> > The ones I am thinking of are pommed and macfanctld, there are
> > probably others. The sysfs nodes have been around a while, so it is
> > not really surprising. If there is a policy saying it is ok to break
> > userspace in this case, that's fine.
> 
> I've just changed pommed to probe for applesmc through /sys/class/hwmon,
> so you can go ahead and break it as far as I'm concerned :)

Great, thanks Julien. And macfanctld should not be a problem either (ccing the author).

Henrik


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

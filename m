From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 20 Dec 2010 14:28:15 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather
Message-Id: <20101220142815.GA23998@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292624661-32474-1-git-send-email-mjg@redhat.com> <20101218042320.GA14104@ericsson.com> <20101218093719.GA1493@polaris.bitmath.org> <20101218110954.7a2ca190@endymion.delvare> <20101218103139.GA1668@polaris.bitmath.org> <878vzngvyn.fsf@sonic.technologeek.org> <20101218115742.GA2063@polaris.bitmath.org> <1292852674.2118.10.camel@mike-laptop> <20101220145721.4c58ff3e@endymion.delvare> <20101220142344.GA19566@polaris.bitmath.org>
In-Reply-To: <20101220142344.GA19566@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, Mikael =?iso-8859-1?Q?Str=F6m?= <mikael@sesamiq.com>, Julien BLACHE <jb@jblache.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Dec 20, 2010 at 03:23:44PM +0100, Henrik Rydberg wrote:

> The macbook overheat problems goes way back. All models have automatic
> heat protection, but it kicks in at temperatures uncomfortable to most
> users. The severity also depends on when the model was made. The
> current solution is to use the macfanctld driver, which disables
> automatic fan control, replacing it with a control loop yielding more
> workable temperatures. A fan control solution in the kernel would
> certainly be well received.

There is one, you just need to hook into the thermal device interface.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

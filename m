From: Julien BLACHE <jb@jblache.org>
Date: Tue, 21 Dec 2010 11:09:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <8762unfkm9.fsf@sonic.technologeek.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
	<1292624661-32474-1-git-send-email-mjg@redhat.com>
	<20101218042320.GA14104@ericsson.com>
	<20101218093719.GA1493@polaris.bitmath.org>
	<20101218110954.7a2ca190@endymion.delvare>
	<20101218103139.GA1668@polaris.bitmath.org>
	<878vzngvyn.fsf@sonic.technologeek.org>
	<20101218115742.GA2063@polaris.bitmath.org>
	<1292852674.2118.10.camel@mike-laptop>
	<20101220140032.GA23257@srcf.ucam.org>
	<1292911480.2316.43.camel@mike-laptop>
In-Reply-To: <1292911480.2316.43.camel@mike-laptop> ("Mikael
 =?iso-8859-1?Q?Str=F6m=22's?= message
	of "Tue, 21 Dec 2010 14:04:40 +0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mikael =?iso-8859-1?Q?Str=F6m?= <mikael@sesamiq.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrik Rydberg <rydberg@euromail.se>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Mikael Str=F6m <mikael@sesamiq.com> wrote:

Hi,

> Before i start to work on that, please confirm that i got this right:
>
> In /sys/class/hwmon/hwmon<0..n>/device, locate fan<1..2>_* for
> controlling the fan(s).
>
> In /sys/class/hwmon/hwmon<0..n>/device, locate temp<1..n>_* for
> enumerating and reading the temp sensors.

Check that device/name is "applesmc", it's faster, simpler and a lot
safer. See the last commit on pommed if you want to borrow some code.

JB.

--=20
Julien BLACHE                                   <http://www.jblache.org>=20
<jb@jblache.org>                                  GPG KeyID 0xF5D65169

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 20:34:11 +0000
Subject: Re: [lm-sensors] [06/32] drivers/hwmon/asus_atk0110.c: Use pr_fmt
Message-Id: <1289334851.22931.223.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <506bc745e46020fb99159fd73288d3b0202c99cf.1287556801.git.joe@perches.com>
	 <20101109163740.GA14733@ericsson.com>
	 <AANLkTi=cTAGuCyk4S-1rscbMUmOm_6X43L7hQTBFmL4y@mail.gmail.com>
In-Reply-To: <AANLkTi=cTAGuCyk4S-1rscbMUmOm_6X43L7hQTBFmL4y@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Joe Perches <joe@perches.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2010-11-09 at 15:15 -0500, Luca Tettamanti wrote:
> On Tue, Nov 9, 2010 at 5:37 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Wed, Oct 20, 2010 at 06:51:30AM -0000, Joe Perches wrote:
> >> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> >> Converted printks to pr_<level>
> >> Coalesced any long formats
> >> Removed prefixes from formats
> >>
> >> Signed-off-by: Joe Perches <joe@perches.com>
> >>
> > Applied.
> >
> > On a side note, I let the long lines go through as long as checkpatch doesn't complain.
> 
> I lost sight of the discussion, but I thought that a better solution
> was to put the define for pr_fmt in a common header instead of
> scattering it in all the drivers.
> 
We went back and forth on it, and concluded that Joe's current approach,
while not optimal, is still the best - ie make the changes as he
proposed and get rid of the pr_fmt defines at the very end, after all
individual files have been changed. Everything else is just too
intrusive.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

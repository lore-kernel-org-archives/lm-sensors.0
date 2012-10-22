From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2012 13:33:07 +0000
Subject: Re: [lm-sensors] non-interactive sensors-detect
Message-Id: <20121022153307.3e14c497@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <507BD5C2.8050506@cern.ch>
In-Reply-To: <507BD5C2.8050506@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 22 Oct 2012 16:23:19 +0300, Adrian Sevcenco wrote:
> On 10/22/2012 03:47 PM, Jean Delvare wrote:
> > On Mon, 15 Oct 2012 12:22:10 +0300, Adrian Sevcenco wrote:
> >> Hi! Is there a way to run sensors-detect in a non-interactive way?
> >> I try to enable lm_sensors on a cluster and i find no way to do it..
> >> Is is possible to add switches like -y (yes all) or -d (default all) to 
> >> sensors detect?
> > 
> > Proposal below. It doesn't feel too safe as random I2C adapters may
> > still get probed. But it's definitely better that people trying to get
> > a non-interactive sensors-detect using "yes |".
>
> Great, thanks!
> is this applied to trunk or should i apply the patch to a fresh trunk
> and rebuild?

It's not committed yet as it was more of a RFC. You have to patch
yourself or pick a pre-patched sensors-detect script at:
  http://khali.linux-fr.org/devel/misc/sensors-detect

If testing/review is positive I'll commit it before the next release.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

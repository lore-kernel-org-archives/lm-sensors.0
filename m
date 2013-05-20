From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 May 2013 12:10:15 +0000
Subject: Re: [lm-sensors] Call for lm-sensors 3.3.4
Message-Id: <20130520141015.501a087d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130507080052.4171493c@endymion.delvare>
In-Reply-To: <20130507080052.4171493c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Robert,

Adding the list back, there's really no reason to keep this discussion
private.

On Fri, 17 May 2013 07:51:13 -0700, Robert Coulson wrote:
> As you know, the ds1631 device cannot be uniquely identified,
> but it is displayed if a ds1621 device is detected; my thought is to
> remove the DS1631 and replace it DS1625. This change would
> provide more accurate device information for the user.
> 
> If you agree, then I can submit a small patch for it, so please let me know.

I'm afraid I don't quite understand what the problem is nor how you
intend to solve it. A patch showing your point might be the best
explanation.

All these DS16xx devices are hard if not impossible to detect reliably,
because they lack device and vendor identification registers. If
anything I'd rather drop detection of these from sensors-detect
altogether. This script is really only meant to detect sensor chips on
PC systems, and I don't think any DS16xx was ever used on a consumer PC
system.

Detection should probably be dropped from the ds1621 driver too, the
proper way to instantiate these devices is explicitly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

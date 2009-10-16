From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Oct 2009 09:15:04 +0000
Subject: Re: [lm-sensors] lm-sensors 3.1.1-3 not detecting sensors on Intel
Message-Id: <20091016111504.5d9cb0ba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0910131743530.5034@p34.internal.lan>
	<alpine.DEB.2.00.0910140403150.15961@p34.internal.lan>
	<alpine.DEB.2.00.0910140856190.19307@p34.internal.lan>
	<20091015100557.22243433@hyperion.delvare>
	<alpine.DEB.2.00.0910150422400.21030@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.0910150422400.21030@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, 15 Oct 2009 04:30:29 -0400 (EDT), Justin Piszcz wrote:
> A picture of it is available here:
> http://img.hexus.net/v2/cpu/intel/LGA1156/IMG_0831-big.jpg
> Another:
> http://www.overclockersclub.com/vimages/intel_corei5750_corei7870/20.jpg
> Another:
> http://www.hitechlegion.com/images/stories/ici7_870/11.jpg
> A close up of the chip itself!
> http://www.motherboards.org/imageview.html?i=/images/reviews/motherboards/1948_p3_13.jpg
> 
> Is this the chip to which you are referring?
> 
> Winbond
> W83677HG-i
> 919S9BE918B001FB
> 919S9BE918B001FB*typed twice to confirm (same #s on two different 
> board/reviews)
> 
> Is there anything else needed?

Please give a try to the latest version of sensors-detect:

http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

It should find your chip now. Next step is to actually add support for
it, but it will take more time and efforts.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

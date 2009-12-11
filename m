From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Dec 2009 08:56:47 +0000
Subject: Re: [lm-sensors] sensors-detect: probing i2c sensors racy?
Message-Id: <20091211095647.7015db08@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091209153225.GA3947@alittletooquiet.net>
In-Reply-To: <20091209153225.GA3947@alittletooquiet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Forest,

On Thu, 10 Dec 2009 22:31:58 -0500, Forest Bond wrote:
> On Wed, Dec 09, 2009 at 05:11:48PM +0100, Jean Delvare wrote:
> > give a try to the latest one:
> > http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> 
> This seems to work fine.  Thanks for the help.

Without the extra patch? Hmm, then I don't know if I should apply it.
On the one hand, why change the code if it works... OTOH, there may be
cases where udev will still be too slow and the bug you've hit will
resurface again.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

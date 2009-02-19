From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Feb 2009 09:34:00 +0000
Subject: Re: [lm-sensors] Cannot make ver 3.0.3
Message-Id: <20090219103400.5237f416@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499AD983.7060708@yahoo.co.uk>
In-Reply-To: <499AD983.7060708@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dave,

On Wed, 18 Feb 2009 22:58:26 +0100, DB wrote:
> And if I copy the values for the it87, it makes even MORE difference!!!!

Copy what values from where to where?

> *BUT *there appears to be something strange (to my untutored eye) with 
> the -12V in Sensors, giving an alarm for a value which appears to me to 
> be in-range....
> 
> Any thoughts????

Try swapping the low and high limits.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

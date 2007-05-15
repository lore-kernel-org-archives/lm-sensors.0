From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 May 2007 16:38:24 +0000
Subject: Re: [lm-sensors] Any chances to get THMC50 driver into 2.6.22?
Message-Id: <20070515183824.077f5597@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4649ac914ece8@wp.pl>
In-Reply-To: <4649ac914ece8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Tue, 15 May 2007 14:50:25 +0200, Krzysztof Helt wrote:
> Are there any chances to get the driver posted here:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019094.html
> 
> into the 2.6.22?

No chance, sorry. The merge window for 2.6.22 is already closed, and
your driver didn't even receive its first review as far as I can see.

I can understand your frustration, but as you can see, we're all pretty
busy, and a driver for a couple rare and old chips can't be given a high
priority :(

What you can do to help your case:
* Find someone to make a first review of your driver. Maybe someone who
  him/herself is waiting for a review. Hans de Goede and Juerg
  Haefliger did such a "cross-review" a few weeks ago, and as a result
  Juerg's dme1737 driver is almost ready for upstream.
* Help the project with something else. The time you save us, we can
  put in reviewing your code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

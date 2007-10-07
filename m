From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 20:07:42 +0000
Subject: Re: [lm-sensors] [PATCH]hwmon/lm87: Add individual alarm files
Message-Id: <20071007220742.51afe59b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070926233901.1ea7aace@hyperion.delvare>
In-Reply-To: <20070926233901.1ea7aace@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 7 Oct 2007 11:55:36 -0400, Mark M. Hoffman wrote:
> Hi:
> 
> * Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-05 09:38:33 +0200]:
> > Hi All,
> > 
> > In this post:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021290.html]
> > 
> > Jean Delvare wrote:
> > --------------------------------------------
> > Add individual alarm files to the lm87 driver. The new libsensors
> > needs this.
> > 
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> 
> (...)
> 
> > Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Applied to hwmon-2.6.git/testing, thanks.
> 
> BTW Jean: is it common for alarm bits to be shared like that?  I don't
> remember seeing anything like that on the other drivers that I wrote or
> worked on in the past.

It's rather uncommon, fortunately. The only example I can remember is
the W83781D: it has only one alarm bit for temp2 and temp3 (same as
the LM87).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 07 Jun 2013 18:22:53 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (adm1021) Strengthen chip detection for ADM1021, LM84 and MAX1617
Message-Id: <20130607182253.GA7822@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370624754-6832-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370624754-6832-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 07, 2013 at 07:55:09PM +0200, Jean Delvare wrote:
> On Fri, 7 Jun 2013 10:44:27 -0700, Guenter Roeck wrote:
> > On Fri, Jun 07, 2013 at 10:05:54AM -0700, Guenter Roeck wrote:
> > > On a system with both MAX1617 and JC42 sensors, JC42 sensors can be misdetected
> > > as LM84. Strengthen detection sufficiently enough to avoid this misdetection.
> > > Also improve detection for ADM1021.
> > > 
> > > Modeled after chip detection code in sensors-detect command.
> > > 
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Related question: candidate for -stable ? I tend to think so, given that LM84
> > mis-detections are reported on a quite regular basis.
> 
> Yes, having this in -stable would be good.
> 
Ok.

Do I still have your Ack for v3, or do you want to re-test ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

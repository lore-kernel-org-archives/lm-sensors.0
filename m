From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Oct 2011 15:56:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (w83627ehf) Skip reading unused
Message-Id: <20111013175648.0fc10f3a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111013164053.3ce93e37@endymion.delvare>
In-Reply-To: <20111013164053.3ce93e37@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 13 Oct 2011 08:44:28 -0700, Guenter Roeck wrote:
> On Thu, 2011-10-13 at 11:17 -0400, Jean Delvare wrote:
> > On Thu, 13 Oct 2011 08:08:22 -0700, Guenter Roeck wrote:
> > > On Thu, 2011-10-13 at 10:40 -0400, Jean Delvare wrote:
> > > > When in6 is missing, don't read the corresponding registers, it's a
> > > > waste of time. The logic is similar to what we do for fans and
> > > > temperatures.
> > > > 
> > > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > 
> > > Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > Thanks.
> > 
> > > Do you want me to apply this series of patches ?
> > 
> > Yes please!
> > 
> Both applied to -next. If you prefer to have it in 3.1, please let me
> know.

next is fine, thank you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

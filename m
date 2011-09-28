From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 28 Sep 2011 14:09:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109ED10F2D3@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110928143042.7ddd0c0a@endymion.delvare>
In-Reply-To: <20110928143042.7ddd0c0a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Wednesday, September 28, 2011 7:20 PM
> To: R, Durgadoss
> Cc: LM Sensors; Yu, Fenghua; Alexander Stein
> Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660 support
> 
> On Wed, 28 Sep 2011 18:54:58 +0530, R, Durgadoss wrote:
> > Yes. It's the same for all Medfield based Atom products.
> > And it cannot be read from MSR_TEMPERATURE_TARGET.
> > So, we have to add the model name in the driver.
> > Currently I have added a OR inside the 'if' in adjust_tjmax Function.
> >
> > if (c->x86_model = 0x1c || c->x86_model = 0x27) {
> >
> > This fetches me 90 and I have confirmed it with the Hardware folks here.
> 
> Oh, BTW, there is magic in this block to adjust tjmax based on the
> north bridge. Is there any such magic possible for Atom model 0x26?

I guess this is not needed now, since we know the tjmax is 90 for 0x26.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

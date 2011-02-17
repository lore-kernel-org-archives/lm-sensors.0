From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Feb 2011 12:17:47 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add support for Texas
Message-Id: <20110217131747.6e327b10@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110214112228.59269651@endymion.delvare>
 <1297689710-17840-1-git-send-email-eibach@gdsys.de>
 <20110216045035.GA12173@ericsson.com>
In-Reply-To: <20110216045035.GA12173@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Dirk Eibach <eibach@gdsys.de>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, rdunlap@xenotime.net, linux-doc@vger.kernel.org

Hi Guenter,

On Tue, 15 Feb 2011 20:50:35 -0800, Guenter Roeck wrote:
> On Mon, Feb 14, 2011 at 08:21:50AM -0500, Dirk Eibach wrote:
> > Signed-off-by: Dirk Eibach <eibach@gdsys.de>
> > ---
> > Changes since v1:
> > - fixed/extended Documentation
> > - removed unused register definitions
> > - hardcoded PGA fullscale table size
> > - made sure patch applies against v2.6.38-rc4
> > - reordered functions to avoid forward declaration
> > - results from i2c_smbus_read_word_data() are handled correctly
> > - moved locking into ads1015_read_value()
> > - removed unnecessray clearing of bit
> > - proper error handling in ads1015_read_value()
> > - use DIV_ROUND_CLOSEST for scaling result
> > - removed detect()
>
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Jean,
> 
> any further comments ?

I have some more comments on the patch, yes. I'll post them in a moment
when I'm done with the review.

> If not, do you want me to apply it to my tree, or do you want to take it into yours ?

I'll pick it in my tree when I'm happy with it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

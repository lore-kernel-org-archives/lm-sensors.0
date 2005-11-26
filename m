From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 15:55:23 +0000
Subject: [lm-sensors] Re: [PATCH] hwmon : Fix W83627THF VID reading
Message-Id: <20051126155622.6612b41b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Mark,

> > Your patch does work on my system, but... no, I don't think it means
> > anything if the inputs are inverted or not.  The BIOS might set the inputs
> > to inverted if the VID signals are inverted by hardware... which I would
> > not consider to be unusual or unexpected.
> 
> I do consider it to be unexpected. The W83627HF cannot invert these pins
> as far as I know, so if the W83627THF is supposed to be used as a
> replacement for the W83627HF, the GPIO pins shouldn't be inverted.
> Additionally, the VID signals are supposed to come directly from the
> CPU, and if they do they cannot be inverted.

On second though, you're right. We just can't assume anything. I've
backed out the patch I had proposed.

> Great, thanks. I'll probably push upwards a part of it this week so that
> it gets a broader testing in -mm.

I'll do later this afternoon, BTW.

Thanks,
-- 
Jean Delvare

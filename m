From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Oct 2007 13:40:46 +0000
Subject: Re: [lm-sensors] [patch 1/1] w83627hf hoist nr-1 offset out of
Message-Id: <20071015154046.35628da3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
In-Reply-To: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Sun, 14 Oct 2007 17:10:52 -0600, Jim Cromie wrote:
> Jean Delvare wrote:
> > Hi Jim,
> >
> > On Fri, 12 Oct 2007 17:56:41 -0600, Jim Cromie wrote:
> >   
> >> this patch replaces last, fixing (long) cast placement,
> >> and one previously missed (nr>=2) -> (nr)
> >>
> >> This hoists nr-1 offset out of (show|store)_temp_*(.*) callbacks, and into
> >> SENSOR_DEVICE_ATTRs for sysfs tempN_X files.  It also combines
> >> temp[1] and temp_add[2] (array) fields in w83627hf_data into 3 elem arrays,
> >> which simplifies special-case handling of nr, allowing simplification
> >> of callback bodies and rerolling a flattened loop in
> >> w83627hf_update_device(struct device *dev).
> >>     
> >
> > Very nice cleanup, thanks.
> >
> >   
> thank you.
> 
> respun per your feedback.
> >
> > Could be made const. Please also name these w83627hf_reg_* instead of
> > w83781d_reg_*. Ultimately we want to remove all references to w83781d
> > from this driver.
>
>
> Done.  I included W83627HF_REG_TEMP2,3_CONFIG since theyre
> so close (lexically and semantically) that it'd more confusing to leave 
> them.

Fine with me.

> would you take a sed -e s/W83781D/W83627HF/
> or a sed -e s/W83781D_REG/W83627HF_REG/ patch ?
> or is it more selective than that ?

I would be fine with the former, to start with. But there are also
lowercase conversions to make, and some references that need to be
updated. For example, having references to the W83782D in a driver that
doesn't support that chip doesn't make much sense.

> that said, the current names are a hint about chip & driver
> heritage and commonality.

The drivers have diverged so much by now that we don't really care.

New patch looks good to me:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Dec 2008 09:33:19 +0000
Subject: Re: [lm-sensors] tempx_max_hyst > tempx_max?
Message-Id: <20081206103319.2c054869@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <157004.2853.qm@web58501.mail.re3.yahoo.com>
In-Reply-To: <157004.2853.qm@web58501.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 5 Nov 2008 11:52:54 -0800 (PST), shaul Karl wrote:
> I suggest the following:
> 
> --- sensors3.conf  2008-11-02 19:06:45.000000000 +0200
> +++ sensors3.conf       2008-11-05 21:49:27.000000000 +0200
> @@ -192,7 +192,19 @@
>  #
>  # Think of tempx_max as 'alarm set' and tempx_max_hyst as 'alarm clear'
>  # thresholds. In most cases the 'max' value should be higher than
> -# the 'max_hyst' value by several degrees.
> +# the 'max_hyst' value by several degrees. Obviously, having them equal
> +# disable the hysteresis mechanism. Many chips will not accept the
> +# 'max_hyst' value higher than the 'max' value because internally they
> +# store the hysteresis as a delta to the max limit. Other chips will
> +# behave in this case as if max_hyst = max, and some may even misbehave,
> +# clearing the alarm even though the measurement is above the max limit.
> +# There's one exception though: some chips out there disable the
> +# hysteresis mechanism or even change the interrupt behavior or even
> +# change the interrupt behavior when the hysteresis is set to special
> +# value 127. Unfortunately, there is no way for the drivers to expose
> +# this property to user-space, so you have to know how if your chip
> +# does that. Once again, the bottom line is that the 'max' value should
> +# be higher than the 'max_hyst' value by several degrees.
>  #
>  # All the set statements from this file are commented out by default.
>  # The reason is that the proper limits are highly system-dependent,

I don't think it makes a lot of sense to document with that many
details something the user shouldn't do in the first place
(tempx_max_hyst greater than tempx_max), or an unspecified,
chip-specific behavior (special value 127) nor to repeat the same thing
twice a dozen lines apart (the 'max' value should be higher than the
'max_hyst' value by several degrees.) So the only added value here is:

"Obviously, having them equal disable the hysteresis mechanism."

I'll add this now. That being said, I still believe that all this
documentation should be moved from sensors.conf.eg to sensors.conf.5.
Well apparently the manual page was originally a copy of the header
comment of sensors.conf.eg, but they have diverged now. It's no good to
have to maintain documentation twice.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

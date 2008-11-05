From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Nov 2008 18:05:09 +0000
Subject: Re: [lm-sensors] tempx_max_hyst > tempx_max?
Message-Id: <20081105190509.08396f08@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <157004.2853.qm@web58501.mail.re3.yahoo.com>
In-Reply-To: <157004.2853.qm@web58501.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2 Nov 2008 07:17:58 -0800 (PST), shaul Karl wrote:
> etc/sensors3.conf of lm-sensors-3 (1:3.0.2-1+b2) in Debian states that
> 
>     # Think of tempx_max as 'alarm set' and tempx_max_hyst as 'alarm clear'
>     # thresholds. In most cases the 'max' value should be higher than
>     # the 'max_hyst' value by several degrees.
> 
>   In what cases would you set the 'max' value equal to the 'max_hyst'
> value?

If you want to disable the hysteresis mechanism.

> Is it pointless for the 'max_hyst' value to be higher than the
> 'max' value? 

Yes it is, and many chips will not even let you do that because
internally they store the hysteresis as a delta to the max limit. Other
chips will behave as if max_hyst = hyst, and I suspect some may even
misbehave, clearing the alarm even though the measurement is above the
max limit.

There's one exception though: some chips out there disable the
hysteresis mechanism or even change the interrupt behavior when the
hysteresis is set to special value 127. There is unfortunately no way
for the drivers to expose this property to user-space, so you have to
know how if your chip does that.

>   I would say that the last statement about tempx_max_hyst > tempx_max
> is confusing.

And I would say you did not read this statement carefully. All the
value of this statement is in the last 3 words.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

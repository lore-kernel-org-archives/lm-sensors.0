From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Sep 2010 17:02:06 +0000
Subject: Re: [lm-sensors] Lack of fan sensor output after Ubuntu upgrade
Message-Id: <20100913190206.4a60a323@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201009101529.26294.larsivar@igesund.net>
In-Reply-To: <201009101529.26294.larsivar@igesund.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Sep 2010 09:13:49 -0700, Guenter Roeck wrote:
> It looks like data is passed between 8031 and host using LDA 11h and/or 12h
> (power management).  However, if those LDAs are active, it does not mean that
> ADCs or fan control is active. The datasheet does not specify details of ADC
> and fan control communication between host and 8031; that seems to be microcode
> specific. Also, it looks like the 8031 code is system specific and not provided
> by the chip vendor. So it might not even be possible to obtain ADC and fan control
> status.
> 
> Or, of course, I might simply be missing something.
> 
> For sensors-detect, we could possibly tag ADC and fan control support to 
> LDA 11h and/or 12h. Would that make sense ?

If there's hope to ever write a driver for this, yes it makes sense. If
not, we're probably better off just claiming that the device has no
monitoring features.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

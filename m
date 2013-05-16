From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 May 2013 10:53:09 +0000
Subject: Re: [lm-sensors] Linux drivers
Message-Id: <20130516125309.736e381d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB68DB2AA0F98748814ADCB4C9FBCE4716BAAC18@DNCE04.ent.ti.com>
In-Reply-To: <BB68DB2AA0F98748814ADCB4C9FBCE4716BAAC18@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lieven,

On Thu, 16 May 2013 09:06:40 +0000, Van Lembergen, Lieven wrote:
> Hello jean, guenther,
> 
> Our customer is using the linux driver for the TMP432, but has some extra problems, hope you can help:
> 2 issues:
> -              writing of the max_hyst-field for the last 2 internal sensors
> The files to change values is read only ?can they have access?

There is only one register internally, where the hysteresis is stored
as a relative (or delta) value. So the difference between
temp2_crit_hyst and temp2_crit is always the same as the difference
between temp1_crit_hyst and temp1_crit. Same for temp3_crit_hyst.
That's why only one hyst file is writable.

> -              extended temperature enabling without patching the init?? Can that be done?

The driver doesn't yet support the extended temperature format. This
could be added, you can either contribute it as a patch or wait for (or
even sponsor) someone to implement it for you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

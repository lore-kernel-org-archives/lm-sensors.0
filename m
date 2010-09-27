From: Pekka Enberg <penberg@kernel.org>
Date: Mon, 27 Sep 2010 13:02:57 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (coretemp): Fix build breakage if
Message-Id: <AANLkTinPHP8WhoAZQqcmhotEfFa6=mG_Acy+xCBQ0_5+@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
	<20100927125946.GB2862@elte.hu>
In-Reply-To: <20100927125946.GB2862@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, torvalds@linux-foundation.org, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

On Mon, Sep 27, 2010 at 3:59 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Guenter Roeck <guenter.roeck@ericsson.com> wrote:
>
>> +#ifdef CONFIG_SMP
>> +#endif
>> +#ifdef CONFIG_SMP
>> +#endif
>
> Hm, this tickles my uglo-meter. Is there no cleaner way, preferably one
> that doesnt involve preprocessor directives?

Implement cpu_sibling_mask() on UP so that the loop goes away?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

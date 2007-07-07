From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 16:38:03 +0000
Subject: Re: [lm-sensors] Better generic print fault handling
Message-Id: <468FC16B.5040503@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707174935.7d4e56e4@hyperion.delvare>
In-Reply-To: <20070707174935.7d4e56e4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 5 Jul 2007 23:03:12 +0200 (CEST), lm-sensors-notify@lm-sensors.org wrote:
>>       Author: jwrdegoede
>>         Date: Thu Jul  5 23:03:06 2007
>> New Revision: 4559
>>    Changeset: http://lm-sensors.org/changeset/4559
>>
>> Modified:
>>    lm-sensors/branches/lm-sensors-3.0.0/prog/sensors/chips.c
>>    lm-sensors/branches/lm-sensors-3.0.0/prog/sensors/chips_generic.c
>>
>> Log:
>> Better generic print fault handling
> 
> OK, it works (tested with an ADM1032 in both degrees C and F) but I
> can't say I find using HUGE_VAL particularly aesthetic. I have to admit
> that this was certainly the quickest way to implement proper
> temperature fault handling without changing the temp_print_info()
> signature. But OTOH, temp_print_info() is only called once, so changing
> its signature wouldn't be a big problem.
> 

I know this isn't pretty I started out using NAN (not a numbeR) which was 
better / clearer, but is ISO99, so I thought it would be better to use 
HUGE_VAL. I didn't want to change the prototype as there already way to much 
params as is.

> I guess that the main problem here is that we have an artificial split
> of temp_print_info() outside of the generic temperature printing
> function, while we shouldn't. This explains in part why the this
> generic temperature printing function doesn't look quite good.
> 

Hmm, I don't think putting all the temp_print_info() stuff into the function 
will make it better, maybe it will, but I don't know if a function becomes tom 
large splitting of small sub functions can be a good idea.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

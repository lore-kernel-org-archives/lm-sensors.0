From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 25 Oct 2007 10:01:59 +0000
Subject: Re: [lm-sensors] svn commit: r4959 -
Message-Id: <47206997.2000606@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071019232531.3c767d99@hyperion.delvare>
In-Reply-To: <20071019232531.3c767d99@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Wed, 24 Oct 2007 14:39:06 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> I am worried by this change, for two reasons. The first reason is that
>>> the original comment was suggesting that the scaling resistors for the
>>> Hermes were external and could change from one motherboard to the next,
>>> while your new fschmd driver handles the scaling internally.
>> I don't know where the resistors are, as the "datasheet" which we have gives no 
>> details on this.
>>
>>> If the
>>> resistors are actually external, then your driver should not do the
>>> scaling. Please clarify.
>> There are 3 reasons to do the scaling in the driver:
>> 1) The used scale values are taken 1 on 1 from the fscher "datasheet"
> 
> Do we really have the same datasheet? Mine states that the scaling
> factor is computed from values present in the DMI table. Could you
> please send me (in private) the output of dmidecode for your test
> system? I'd like to take a look. The Poseidon datasheet OTOH indeed
> lists hard-coded values.
> 

Jean, you are amazing (in a positive way), you are completely right. I've 
totally overlooked this when comparing the datasheets for creating the unified 
drivers (oops).

I don't have access to my FSC (her) machine until monday, then I'll take a look 
at this. I'll also mail my FSC contact to ask if the DMI based scaling should 
be used for other models and for which models.


My plan is to implement DMI value based scaling for the relevant models for DMI 
enabled kernels, and fallback to the current constants for non DMI enabled kernels.

I feel a big discussion coming up here, like with the uguru3 on doing this in 
the kernel versus userspace, I hope we can come to an agreement a bit quicker / 
easier this time :)

Arguments to do it in the kernel:
1) With lm_sensors-3.x.x we've made userspace completely free of chip specific
    knowledge, I would like to keep it this way
2) The kernel already includes a DMI parser, so it is not going to add a whole
    lot of code
3) We could avoid 1) by creating an FSC specific userspace tool to generate a
    sensors.conf, but then this tool still needs to be run, so either we need to
    hack this into our initscripts somehow, or we need to document this and
    users must run it manualy. Having this in the driver will make things "just
    work (tm)".
4) Its device specific knowledge and device specific knowledge belongs in the
    driver.


Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 28 Oct 2007 13:16:11 +0000
Subject: Re: [lm-sensors] svn commit: r4959 -
Message-Id: <47248B9B.6060602@hhs.nl>
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
> On Thu, 25 Oct 2007 12:01:59 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> On Wed, 24 Oct 2007 14:39:06 +0200, Hans de Goede wrote:
>>>> There are 3 reasons to do the scaling in the driver:
>>>> 1) The used scale values are taken 1 on 1 from the fscher "datasheet"
>>> Do we really have the same datasheet? Mine states that the scaling
>>> factor is computed from values present in the DMI table. Could you
>>> please send me (in private) the output of dmidecode for your test
>>> system? I'd like to take a look. The Poseidon datasheet OTOH indeed
>>> lists hard-coded values.
>> Jean, you are amazing (in a positive way), you are completely right. I've 
>> totally overlooked this when comparing the datasheets for creating the unified 
>> drivers (oops).
> 
> Once in a while, there has to be some positive effects to me bugging
> everyone all the time with silly questions and remarks ;)
> 
>> I don't have access to my FSC (her) machine until monday, then I'll take a look 
>> at this. I'll also mail my FSC contact to ask if the DMI based scaling should 
>> be used for other models and for which models.
>>
>>
>> My plan is to implement DMI value based scaling for the relevant models for DMI 
>> enabled kernels, and fallback to the current constants for non DMI enabled kernels.
>>
>> I feel a big discussion coming up here, like with the uguru3 on doing this in 
>> the kernel versus userspace, I hope we can come to an agreement a bit quicker / 
>> easier this time :)
>>
>> Arguments to do it in the kernel:
>> 1) With lm_sensors-3.x.x we've made userspace completely free of chip specific
>>     knowledge, I would like to keep it this way
> 
> Not exactly. The libsensors code and applications using libsensors are
> free of chip-specific (or, for that matter, motherboard-specific)
> knowledge. sensors.conf still holds motherboard-specific knowledge, and
> there's nothing wrong with this.
> 
>> 2) The kernel already includes a DMI parser, so it is not going to add a whole
>>     lot of code
> 
> I'm not sure what exactly is parsed in the kernel. It seems that it's
> only extracting a couple identification strings and specific data and
> doesn't give you access to arbitrary record data. So you'll probably
> have to add your own FSC-specific handler, and to find a way to export
> the data. Not sure if that will be accepted upstream.
> 

You are right, so of to userspace we go.

This brings us to 2 questions:
1) What to use as conversion / divider in the driver? I see 2 options:
  a) Use the fscpos datasheet divider everywhere
  b) Use the fscpos datasheet divider for the fscpos and others which lack
     the DMI info, and use the old fscher divider / multiplier of 10 mv / step
     for those with DMI data.

  I must say I do not have much preference a) leads to a somewhat simpler
  driver, b) means that the old configs will stay working even when switching to
  the fschmd driver. So which one will it be>

2) How? I can write a specific utility to spit out the conversion formulas (I
  guess that is where I'll start). But at the end we may want to include this in
  sensors-detect. However currently sensors-detect does not touch sensors.conf,

  I guess its best to for now write a userspace utility which generates the
  conversion formulas for users, and integrate this into sensors-detect when we
  integrate dmi-based autoconfig into it.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

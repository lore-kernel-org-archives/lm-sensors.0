From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 22 Oct 2007 13:15:51 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <471CA287.3040603@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 22 Oct 2007 11:40:11 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>>>> I expected applications to deal with the
>>>>> different versions on their own. But if you think that a #define in
>>>>> sensors.h would help, just go ahead, that's fine with me.
>>>> Well as explained above ./configure and the Makefiles don't need to know about 
>>>> the different versions, So only some code changes are needed, for which it 
>>>> would be nice if a #define is present to test for.
>>> As I said, just go ahead and add the #define you want. Feel free to add
>>> the "same" #define to trunk if it helps.
>> Done,
>>
>> I've also added a comment how to use it in future versions. The idea is to 
>> increment the lower digit when for example new features are added to the 
>> featuretype enum, so that applications can check the SENSORS_API_VERSION and 
>> conditionally support new features for example (if they don't/can't check they 
>> will no longer compile against an older libsensors).
> 
> I think I wouldn't have bothered. If applications no longer compile
> with an older libsensors, then just upgrade libsensors.
> 

That would mean much pain for distro developers which want to minimize churn, 
but may still need to upgrade an application because of security reasons.

>> The middle digit is both an overflow for the lower, and/or for bigger changes 
>> like the addition of methods. I know the addition of methods would mean apps 
>> compiled against the new version will not work with the old, but this is quite 
>> normal todo, see for example gtk2 and many others.
> 
> Yes, that's not a problem.
> 
>> Let me know what you think of this scheme and / or feel free to change it.
> 
> If someone is willing to maintain the API number, that's fine with me.
> Me, I'll try to remember, but as I know myself, chances are good that
> I'll forget sometimes if nobody is watching over me.
> 

I'll try to keep an eye on it. I hope that if we forget users will complain.

> Just one thing I'm curious about: are you sure you want to set the API
> to 400 _decimal_? Setting it to 0x400 instead seems to be more
> flexible, as is allows for constructs like:
> 
> #if (SENSORS_API_VERSION >> 16) = 4
> 
 > which is plain impossible to do with a decimal version number.

Well with mine one can do:
#if (SENSORS_API_VERSION / 100) = 4

But I'm fine with either.

> Another thing: don't you want to define SENSORS_API_VERSION in trunk as
> well? If not, you'll always have to test for SENSORS_API_VERSION's
> existence before checking its value. I know that versions up to and
> including 2.10.4 do not have the define and we can't change that, but
> maybe applications will want to support all versions >= 2.10.5 so that
> the #if magic can be limited to something sane.
> 

Not necessary, if an identifier which is not a MACRO gets used in an #if 
statement it is considered zero, so to take you example:
#if (SENSORS_API_VERSION / 100) = 4

Would expand to:
#if (0 / 100) = 4

And thus be false.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

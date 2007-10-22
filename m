From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 22 Oct 2007 09:40:11 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <471C6FFB.5010602@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>> I expected applications to deal with the
>>> different versions on their own. But if you think that a #define in
>>> sensors.h would help, just go ahead, that's fine with me.
>> Well as explained above ./configure and the Makefiles don't need to know about 
>> the different versions, So only some code changes are needed, for which it 
>> would be nice if a #define is present to test for.
> 
> As I said, just go ahead and add the #define you want. Feel free to add
> the "same" #define to trunk if it helps.
> 

Done,

I've also added a comment how to use it in future versions. The idea is to 
increment the lower digit when for example new features are added to the 
featuretype enum, so that applications can check the SENSORS_API_VERSION and 
conditionally support new features for example (if they don't/can't check they 
will no longer compile against an older libsensors).

The middle digit is both an overflow for the lower, and/or for bigger changes 
like the addition of methods. I know the addition of methods would mean apps 
compiled against the new version will not work with the old, but this is quite 
normal todo, see for example gtk2 and many others.

Let me know what you think of this scheme and / or feel free to change it.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

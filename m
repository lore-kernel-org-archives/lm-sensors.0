From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 04 Apr 2007 19:59:06 +0000
Subject: Re: [lm-sensors] sensors-detect path issue under fc5 / 6 -- fix
Message-Id: <21b001c776f3$b54866e0$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070304113341.091c3819.khali@linux-fr.org>
In-Reply-To: <20070304113341.091c3819.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I notice it's fixed now, but this needed to be added anyway, since the same 
counts for the dmidecode needed in the future, which is also (by default) 
installed in /usr/sbin instead /usr/local/sbin.

Just a reminder in case problems related to lmsensors or dmidecode show up 
in the future,

Ivo
----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "LM Sensors" <lm-sensors@lm-sensors.org>
Cc: "Vince Spinelli" <Vince@SpinelliCreations.com>
Sent: Wednesday 4 April 2007 21:34
Subject: Re: [lm-sensors] sensors-detect path issue under fc5 / 6 -- fix 
included.


> On Sun, 4 Mar 2007 11:33:41 +0100, Jean Delvare wrote:
>> On Sun, 4 Mar 2007 03:04:42 -0500 (EST), Vince Spinelli wrote:
>> > It's a simple one, but it's worth noting.
>> >
>> > I'm unawares of other distributions, but under Fedora Core 5 and 6, the
>> > i2cdetect command is located in the /usr/sbin directory, not /sbin/ nor
>> > /usr/local/sbin.
>>
>> That's the case of pretty much all distributions shipping lm-sensors,
>> as /usr/local is meant for things added on top of the original
>> distribution.
>>
>> > As a result, an error message is encountered when running
>> > sensors-detect.sh as either root, sudo root, or a normal user.
>>
>> There's no such thing as "sensors-detect.sh" in our source package.
>> sensors-detect is a perl script.
>>
>> If your root user doesn't have /usr/sbin in its $PATH, then your setup
>> is seriously broken, I doubt sensors-detect will be the only failing
>> tool.
>>
>> sensors-detect can no longer be run as non-root, so this case doesn't
>> matter.
>>
>> The su/sudo case is more problematic though, I can imagine a standard
>> user gaining root permissions without getting the $PATH usually
>> associated with the root user.
>>
>> > The fix is as follows... inside of the sensors-detect.sh script, 
>> > there's a
>> > segment to add directories to path.
>
> I've made a functionally equivalent change to sensors-detect, committed
> to our SVN repository. Feel free to give it a try. Hopefully it will
> make the packagers happier.
>
> -- 
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

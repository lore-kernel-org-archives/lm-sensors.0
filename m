From: Richard Llom <richard.llom@gmail.com>
Date: Sun, 21 Dec 2014 21:22:56 +0000
Subject: Re: [lm-sensors] System Monitor cannot read sensors anymore
Message-Id: <m77dng$iks$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m6bv17$gsp$1@ger.gmane.org>
In-Reply-To: <m6bv17$gsp$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter Roeck wrote:
> On 12/19/2014 05:34 AM, Richard Llom wrote:
>> Guenter Roeck wrote:
>>> On 12/18/2014 11:03 AM, Richard Llom wrote:
>>>> Thanks for the input guys!
>>>> I reported this to my distro/packager, lets see what they say (maybe it
>>>> is just an packaging error).
>>>
>>> Did you change the distro version ? I thought you just updated the
>>> kernel.
>>>
>> It's a (half-) rolling distro. The kernel update was major update and
>> came with a new KDE 4 SC release as well.
>>
> 
> Can you load the older (3.16) kernel with the new version of KDE ?
> That would tell us if the culprit is the kernel or ksysguard.
> 
Tested on downgrade 3.16 and there are no hardware sensors as well, so its 
probably related the KDE update / package.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

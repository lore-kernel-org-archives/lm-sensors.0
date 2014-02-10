From: linux@roeck-us.net
Date: Mon, 10 Feb 2014 18:36:42 +0000
Subject: Re: [lm-sensors] why must Dell machine use i8k?
Message-Id: <20140210123642.13901z6mgy2iq6as@67.228.131.205>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+sB1YJ62Sg0p+vFoma5aaoGDhv7TFSZc6BmTbzE4Q9d_RQ8JQ@mail.gmail.com>
In-Reply-To: <CA+sB1YJ62Sg0p+vFoma5aaoGDhv7TFSZc6BmTbzE4Q9d_RQ8JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting JACK MA <gundamfj2010@gmail.com>:

> Hello,
>
> Thanks for you reply. Sounds interesting. I found something via Google.
> http://www.motherboardpoint.com/dell-fan-speed-control-t186638.html
> The reason is Dell do not want to publish the details of the BIOS? Or the
> engineers there are too lazy. I guess.
>
Wrong people to blame. Dell decided a few years ago to drop supporting
Linux on desktop and Laptop systems, and to only suport Linux on servers.
That was not an engineering decision; it was a management decision
(possibly influenced by a certain OS vendor located in Redmond, WA).
The correct response would be to not buy a Dell system if you intend
to install Linux on it, and to let Dell know about it.

> So, how can I do to improve the situation? Reverse the BIOS to see how it
> works and add a software layer?
>

Kind of. Note that i8k already implements the software layer, though
it is far from perfect.

Guenter

> thanks,
> jack
>
>
> 2014-02-09 22:28 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
>
>> On 02/09/2014 01:00 PM, JACK MA wrote:
>>
>>> Hello,
>>>
>>> I have a Dell Inspiron and a Acer laptop. I do not need to install any
>>> other package to control the fan of the Acer one. I think the Linux kernel
>>> support it very well. But, why does this not work on the Dell laptop?
>>>
>>>
>> Hi Jack,
>>
>> Firmware on Tesla cars can be remotely upgraded, at least on Model S.
>> For most if not all other cars this has to be done by the dealer,
>> if it is possible in the first place. Why does remote upgrade
>> not work on other cars as well ?
>>
>> Please feel free to submit a set of patches to improve the situation
>> to your liking.
>>
>> Guenter
>>
>>
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

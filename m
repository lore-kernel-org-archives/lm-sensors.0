From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Date: Sun, 24 Jan 2010 05:17:45 +0000
Subject: Re: [lm-sensors] Status of Andigilog asc7621 driver submitted by
Message-Id: <3f9a31f41001232105l58d36ffdp8d06231f524a98ec@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
	 <4B5B38C1.5080109@hhs.nl>
In-Reply-To: <4B5B38C1.5080109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: George Joseph <George.joseph@fairview5.com>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello Hans,

On Sat, Jan 23, 2010 at 11:28 PM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Hi,
>
> On 01/23/2010 06:52 PM, Jaswinder Singh Rajput wrote:
>>
>> Andigilog asc7621 driver submitted by George Joseph on 2008-05-29,
>> This chip is used by various Intel Motherboards.
>>
>> Is it still under review and testing :
>>
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023257.html
>>
>> http://www.spinics.net/lists/lm-sensors/msg26915.html
>>
>> http://www.spinics.net/lists/lm-sensors/msg26916.html
>>
>> http://www.lm-sensors.org/wiki/Devices
>>
>
> I guess this is partly my fault, I started a review but never finished
> it. One of the big problems is that George did many things completely
> different to how every other single hwmon driver does things. Which made
> the review harder then necessary, and more over made me wonder if we
> should accept the driver in that incarnation at all.
>

George Joseph submitted the driver on 2008-05-29 and then he updated
the driver on 2009-10-15 for 2.6.30 and many developers are able to
test it and used it.

Are you able to compile the driver with latest kernel git.

> Then a lot of things happened and I never got around to doing anything
> with it at all.
>

Many new Intel Motherboards are coming with this chip, if we complete
this driver then it will be great.

> I just checked my Drafts folder, and I still have my unfinished review
> in there. So if there is interest I can send that, note that it is
> not a complete review though (there is a note in there which part
> of the code is reviewed and which still needs to be reviewed).
>

Please provide your review so that we can discuss about this driver
and make relevant changes to accept it.

Thank you,
--
Jaswinder Singh.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

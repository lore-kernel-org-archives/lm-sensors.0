From: Laszlo Papp <lpapp@kde.org>
Date: Fri, 14 Feb 2014 07:03:28 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: (max6650) Convert to be a platform driver
Message-Id: <CAOMwXhPwppZ6Ne4TjR9Ys+ttST2r85j1GsLdxfq67svZSuVHFg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392281438-31836-1-git-send-email-lpapp@kde.org>
	<20140213095817.GD32508@lee--X1>
	<20140213111530.2a2b4982@endymion.delvare>
	<CAOMwXhML8LvDCzmk1ZVT+7cARj9C3VtxERWBgOPM9vTc6qQXZQ@mail.gmail.com>
	<CAOMwXhOv-as1W69wcSno49jEXsXWZZ7odnu8og-vgnDwRTJ4sA@mail.gmail.com>
	<20140213113313.GL32508@lee--X1>
	<CAOMwXhMNHqXnzR0YHF9rx710JbaL3YFn=3cLf_WdNkCx7hbZug@mail.gmail.com>
	<20140213124002.GA3403@lee--X1>
In-Reply-To: <20140213124002.GA3403@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Jean Delvare <jdelvare@suse.de>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

On Thu, Feb 13, 2014 at 12:40 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> http://comments.gmane.org/gmane.linux.kernel/1645251
>>
>> Step 2 did not happen. I did not get any review for my change. I
>> literally submitted that within a couple of hours after the request.
>>
>> Could you please tell me what was wrong with that change, and why I
>> did not get any respect not to "xargs rm -rf" my work in that area? I
>> believe I was ignored instead of improving the change, and someone
>> else tried to address the same thing. There was no argument in that
>> thread. It was a technical change. I personally do not feel happy
>> about it.
>
> Let's start again.
>
> Rebase your work on top of the HWMON tree on kernel.org and resubmit
> the entire set. If rebasing takes you more than 20 mins, you're
> probably doing it wrong.

I tried, but I could not manage it within 20 minutes, so I guess I am
doing something wrong. Can you please provide some pointers how not to
do it wrong? Perhaps, I am not aware of some tricks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

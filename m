From: Mike Frysinger <vapier.adi@gmail.com>
Date: Thu, 02 Jul 2009 18:15:02 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <8bd0f97a0907021115r761d7906w818acefc6c03efa4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local> 
	<4A4CF07B.3090600@cam.ac.uk> <8bd0f97a0907021043l30a34e6dh581ea5e96130d7eb@mail.gmail.com> 
	<4A4CF587.1030202@gmail.com> <8A42379416420646B9BFAC9682273B6D0C2497DC@limkexm3.ad.analog.com>
In-Reply-To: <8A42379416420646B9BFAC9682273B6D0C2497DC@limkexm3.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Chris Verges <chrisv@cyberswitching.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Robin Getz <rgetz@blackfin.uclinux.org>

On Thu, Jul 2, 2009 at 14:12, Hennerich, Michael wrote:
>From: J.I. Cameron [mailto:jic23@hermes.cam.ac.uk] On Behalf Of
>> Looks like a nice driver, see what you mean about the i2c fun and games
>> you are having though.
>> I'm particularly interested in your use of the fifo:
>>
>>I've only had a quick look, but assuming I read it right, you are using
>>the fifo
>>with a watermark of 0 then spitting out 3 separate events for every
>>element in it.
>>Basically a data ready response unless you fail to read in time. Seems
>>like a sensible
>>approach with this particular chip in input type applications.
>
> We fully use the FIFO - the link Mike sent around was the initial
> checkin.
> After that I fixes some bugs and added functionality.
> BTW I also implemented the Watermark feature.

nah, that link i posted is everything.  the kernel.org repo has
cleaned up / squashed changes.  so all the little pieces in our
personal repo have been put together to form the one changeset on
kernel.org.

ive been emptying my other subsystem queues and havent gotten around
to input/hwmon/fb yet.  i'll start up a thread on our list to see what
people are happy with submitting.
-mike

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

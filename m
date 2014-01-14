From: Andreas Hollmann <hollmann@in.tum.de>
Date: Tue, 14 Jan 2014 13:26:43 +0000
Subject: Re: [lm-sensors] Sensors shows only 8 of 10 cores on 4-Socket Intel(R) Xeon(R) CPU E7- 4850 machine
Message-Id: <CAGz0_-3z5499bjpMzFmjf=xfxPDQ+hVR7QmpCYir8yAd8UoqQA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
In-Reply-To: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

sorry for the missing information.

$ sensors -v
sensors version 3.3.4 with libsensors version 3.3.4
$ uname -a
Linux inwest 3.10.25-1-lts #1 SMP Sat Dec 21 13:31:14 CET 2013 x86_64 GNU/Linux

Best regards,
Andreas

2014/1/14 Jean Delvare <khali@linux-fr.org>:
> Hi Andreas,
>
> On Tue, 14 Jan 2014 14:01:19 +0100, Andreas Hollmann wrote:
>> 2 cores are missing per socket in the sensors output.
>>
>> Is there a hard coded number of max CPUs that limits
>> to output more then 8 CPUs?
>
> Which kernel version? Which version of "sensors" and libsensors
> ("sensors -v" will tell you)?
>
> The non-linear numbering of the cores might be the cause.
>
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

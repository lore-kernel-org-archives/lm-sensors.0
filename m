From: "Alek Uritsky" <auritsky@enqii.com>
Date: Fri, 14 Mar 2008 21:08:01 +0000
Subject: Re: [lm-sensors] problems compiling 2.10.5
Message-Id: <003301c88617$7d338f80$b701010a@ALEK4E31DD5E>
List-Id: <lm-sensors.vger.kernel.org>
References: <001001c88611$79fa1e20$b701010a@ALEK4E31DD5E>
In-Reply-To: <001001c88611$79fa1e20$b701010a@ALEK4E31DD5E>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2.10.6 works.
Thanks a lot

alek


----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Alek Uritsky" <auritsky@enqii.com>
Cc: <lm-sensors@lm-sensors.org>
Sent: Friday, March 14, 2008 4:41 PM
Subject: Re: [lm-sensors] problems compiling 2.10.5


> Hi Alek,
>
> On Fri, 14 Mar 2008 16:24:59 -0400, Alek Uritsky wrote:
>> I am trying to compile lm_sensors 2.10.5 on Fedora 6 box with kernel 
>> 2.6.22
>>
>> (for some reasons, 2.10.1-1 that comes with the distro does not want to 
>> detect sensors)
>
> Probably because it's too old for your hardware... or because your
> machine doesn't have supported sensors.
>
>> I have a huge number of compilation errors  (starting with lib/data.c )
>> which seems to be a result of the difference in .h files
>
> Difference between what and what?
>
>> (should I post the errors?).
>
> Yes please. The first few ones should be enough.
>
>> Is this a known problem? What would be the way to proceed?
>
> Not a known problem, but I can't tell more without seeing the actual
> errors.
>
> Note that lm-sensors 2.10.6 is out by now, so you should try to build
> that instead of 2.10.5 anyway.
>
> -- 
> Jean Delvare 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

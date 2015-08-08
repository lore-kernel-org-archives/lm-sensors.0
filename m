From: "Minimi, Phillip A" <phillip.a.minimi@lmco.com>
Date: Sat, 08 Aug 2015 13:34:11 +0000
Subject: Re: [lm-sensors] EXTERNAL: Re:  coretemp driver
Message-Id: <830397DA32E1A0479077F4D3642B448B62D86E72@HVXDSP41.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <830397DA32E1A0479077F4D3642B448B62D86C73@HVXDSP41.us.lmco.com>
In-Reply-To: <830397DA32E1A0479077F4D3642B448B62D86C73@HVXDSP41.us.lmco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Friday, August 07, 2015 1:19 PM
To: Minimi, Phillip A; lm-sensors@lm-sensors.org
Subject: Re: EXTERNAL: Re: [lm-sensors] coretemp driver

On 08/07/2015 09:40 AM, Minimi, Phillip A wrote:
> Thank you. I have visited these links. I'm trying to find out if there is an updated Coretemp driver and how to obtain it.
>

Please don't top-post.

Updated driver compared to what ?

The latest driver is in the upstream kernel, so it might be helpful if you could describe your problem to be able to answer your question.

Thanks,
Guenter

> Thanks,
> Phil
>
>
> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Friday, August 07, 2015 12:31 PM
> To: Minimi, Phillip A; lm-sensors@lm-sensors.org
> Subject: EXTERNAL: Re: [lm-sensors] coretemp driver
>
> On 08/07/2015 09:15 AM, Minimi, Phillip A wrote:
>> Hello,
>>
>> Does lm sensors provide support or information about the coretemp driver? If now would you know how to obtain information?
>>
>
> See http://www.lm-sensors.org/wiki/Devices for supported devices, and http://www.lm-sensors.org/wiki/FAQ/Chapter4 on how to ask for help.
>
> Thanks,
> Guenter
>
>
>Please don't top-post.

>Updated driver compared to what ?

>The latest driver is in the upstream kernel, so it might be helpful if you could describe your problem to be able to answer your question.

>Thanks,
>Guenter

We are running RedHawk5.4.11, 2.6.31.13, based on RHEL5.4 x86, on an IBM HS23. Executing sensors showed no output at all, no sensors detected. I looked at coretemp.c and saw that the HS23 CPU, 32nm, CPUID= 0X2D, was not supported and in fact coretemp was reporting that in /var/log/messages. I added 0x2D to coretemp.c and rebuilt the kernel to see if we could even read a sensor. That worked and now there is a temperature reported for each CPU. However, with the "workaround" I don't have any confidence in the accuracy of the output of course. Is there a patch I can apply to the kernel source that will update coretemp.c and related source code?

Thanks,
Phil
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

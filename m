From: Chris Murphy <bugzilla@colorremedies.com>
Date: Tue, 01 Oct 2013 15:33:13 +0000
Subject: Re: [lm-sensors] applesmc oops in 3.10/3.11
Message-Id: <C10D98EE-28FE-4BFE-BDE5-1EAABF112AC2@colorremedies.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130926063453.GA526@polaris.bitmath.org> <CA+5PVA76tjoR+GNaQps_zQmqz=V_GAcQaZLqKcx1ihgUMQBrQw@mail.gmail.com> <20130927171256.GA6391@roeck-us.net> <71D92187-2092-4975-A707-17452C48EF5A@colorremedies.com> <20130927175926.GA6267@roeck-us.net> <B6E9FB4C-665C-454E-9DEB-B95B85C1D0E0@colorremedies.com> <524615B1.6000106@roeck-us.net> <4FFB3671-DDB4-40F7-BA5D-C9AA9391BDA9@colorremedies.com> <524A4384.4040403@roeck-us.net> <20131001105526.GA481@polaris.bitmath.org> <20131001151954.GB14887@roeck-us.net>
In-Reply-To: <20131001151954.GB14887@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, Josh Boyer <jwboyer@fedoraproject.org>, khali@linux-fr.org, lm-sensors@lm-sensors.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>


On Oct 1, 2013, at 9:19 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Oct 01, 2013 at 12:55:26PM +0200, Henrik Rydberg wrote:
>>>> Warning message triggered with 3.12.0-0.rc3.git0.1.fc21.x86_64.
>>>> 
>>>> [   10.886016] applesmc: key count changed from 261 to 1174405121
>>>> 
>>> 
>>> Explains the crash, but the new key count is very wrong. 1174405121 = 0x46000001.
>>> Which I guess explains the subsequent memory allocation error in the log.
>>> 
>>> Henrik, any idea what might be going on ? Is it possible that the previous
>>> command failure leaves some state machine in a bad state ?
>> 
>> I seem to recall a report on another similar state problem on newer
>> machines, so maybe, yes. Older machines seem fine, I have never
>> encountered the problem myself. Here is a patch to test that
>> theory. It has been tested to be pretty harmless on two different
>> generations.
>> 
>> I really really do not want to add an 'if (value is insane)' check ;-)
>> 
> Chris,
> 
> any chance you can load this patch on an affected machine so we can get
> test feedback ? This one is too experimental to submit upstream without
> knowing that it really fixes the problem.

Yes. What kernel.org source version should I apply it against? I'd use the non-debug config file from an equivalent version Fedora kernel, unless asked otherwise. And also should I test it on other vintages? I have here MBP4,1(2008); MBP8,2(2011), and MBP10,2(2012).

Chris
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

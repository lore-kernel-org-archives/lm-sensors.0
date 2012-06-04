From: linux@roeck-us.net
Date: Mon, 04 Jun 2012 17:02:16 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <20120604120216.13404llekgwvjjsw@67.228.131.205>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting "R, Durgadoss" <durgadoss.r@intel.com>:

> Hi Guenter,
>
>> -----Original Message-----
>> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
>> sensors.org] On Behalf Of Guenter Roeck
>> Sent: Monday, June 04, 2012 10:08 PM
>> To: lm-sensors
>> Cc: Guenter Roeck
>> Subject: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for
>> TjMax detection on Atom CPUs
>>
>> Atom CPUs don't have a register to retrieve TjMax. Detection so far is
>> incomplete. Use the X86 model ID to improve it.
>>
>
> Thanks for the patch...
>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Wonder if we can improve TjMax detection for Atom CPUs with this code.
>> Anyone with Atom CPUs out there for some testing ?
>
> I can test it out on the Medfield platform (Atom based).

You will need Jean's pending patch for that, to detect the new Atom CPU model.

> But its Tjmax is 90 C. I don't see any 90 C values in your array.
> is there a reason behind it ?

Hi Durga,

If you look closely at the patch, you will notice that the Atom code  
starts with

     tjmax = 90000;

90 degrees C is thus the default case. The table only includes values  
for CPUs with a different tjmax. That keeps the table a bit smaller.

> Or we can add as we find more models ?
>
Definitely ...

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

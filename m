From: undersys <undersys@basstech.net>
Date: Mon, 05 Dec 2011 23:26:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on driver load
Message-Id: <d4d4551e-66b2-45fd-bfd4-753de5b27e56@basstech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111201110047.130190a5@endymion.delvare>
In-Reply-To: <20111201110047.130190a5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



----- Original Message -----
From: "Jean Delvare" <khali@linux-fr.org>
To: undersys@basstech.net
Cc: lm-sensors@lm-sensors.org, "Durgadoss R" <Durgadoss.r@intel.com>, "guenter roeck" <guenter.roeck@ericsson.com>
Sent: Tuesday, 6 December, 2011 1:02:54 AM
Subject: Re: [PATCH] hwmon: (coretemp) Fix oops on driver load

On Sat, 03 Dec 2011 09:32:24 +0800 (HKT), undersys wrote:
> I've now got the latest microcode from Intel loading fine.
> The coretemp module still will case an "OPPS" but the new code will solve that
> from what i understand but it also still means that coretemp no longer pics up my CPU temp..

Odd. Which microcode package version are you running?
What's your exact CPU family/model/stepping?
Did you get the coretemp driver to work for this CPU with any kernel
version in the 2.6.22 to 2.6.39 range?

-- 
Jean Delvare

The microcode utility I am using is :-
http://urbanmyth.org/microcode

The version of micro code I am using is "microcode-20110915.tgz" :-
http://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID 429&lang=eng

CPU is :-
Intel Xeon sossaman, model, stepping=4. 
I don't have the SPEC number on hand let me know if you need more information.

Micro code was working on 2.6.29 and 2.6.39 , then I jumped to 3.0.6.

Thanks for your help

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

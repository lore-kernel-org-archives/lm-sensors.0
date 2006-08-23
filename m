From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 23 Aug 2006 15:33:40 +0000
Subject: [lm-sensors] [patch 0/3] pc87360 - fix unchecked
Message-Id: <44EC7554.8090504@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E72DE7.10907@gmail.com>
In-Reply-To: <44E72DE7.10907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>> The files contents change each sample, usually on VPWR, but others too.
>> diffs are always in small fractions of a volt.
>>     
>
> I didn't mean to compare the contents of the files, of course I know
> they can change, and this is completely unrelated with your patch, or
> any other change for that matter. We wouldn't be monitoring if values
> weren't to change every now and then ;)
>   


Well, Ive always been slightly bothered by the fluctuations, since its a 
single-board-computer
that is doing little work, has no cpufreq (ie fixed freq), etc.

I suppose the wifi card draws more when transmitting, and hlt instruction
saves CPU power intermittently, and the PSU is not oversized for 
board+wifi-card.

And I guess, if the numbers had looked sufficiently weird you'd have 
noted it
(which is in part why I included it)

thanks
jimc


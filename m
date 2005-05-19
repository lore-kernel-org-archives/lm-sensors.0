From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: RFC: test results for adm9240 auto fan clock divider
Message-Id: <u268611m57h3l72gq4rjf7nmqs26m2g2if@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
In-Reply-To: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Mon, 18 Apr 2005 22:16:18 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>
>> Requirements:
>
>Agreed on everything, except:
>
>> automatic fan clock divider
>> ````````````````````````````
>>     * User sets 0 to fan_min limit
>>       - low speed alarm is disabled
>>       - fan clock divider not changed
>>       - auto fan clock adjuster disabled
>
>Why would we want to disable the auto fan clock adjuster in this case?
Oops, I just posted new driver...  Bad timing -- I'll need to check, 
this implies enabling bidirectional fan adjustment to do it right? 

I literally followed your advice not to change fan divider and focussed 
on correct operation _everywhere else_ :o)

>You also missed one case, which is the main reason why the whole thing
>is (IMHO) needed:
>
>     * User doesn't set any limit
>       - auto fan clock adjuster enabled

Again, this implies bidirectional adjustment -- its only one 
small block of code, can I patch a patch?  Or post yet another 
driver?

Cheers,
Grant.

>But all in all it looks like we finally agree on what the best strategy
>is :)

The point of the argument was to reach understanding, and improve 
each other's work -- that we've done :)

I found a nasty div/0 yesterday, driver segfaulted and locked terminal, 
another terminal locked on trying to rmmod -f adm9240, but I was able 
to open anothr ssh root terminal and reboot the machine.  So it didn't 
take down the system, just the driver and anything accessing it.

So we make sure fan_min > 0.

At least I know where I'll be playing today.  I'll patch the patch, it 
is only a few lines of code.

Cheers,
Grant.

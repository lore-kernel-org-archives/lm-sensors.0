From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <0mi6411rcs7eq8lipbesefgpgpfti1lt0v@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Thu, 24 Mar 2005 22:54:59 +0100, Jean Delvare <khali@linux-fr.org> wrote:
>> I still go for lm85 locking model, perhaps overdone but seems 
>> clearly safe.  Certainly easy to point at lm85 as reference 
>> model for write locking in the author / porter guide.
>
>Absolutely.
>
>> Then think of reader locking, can drivers simply return 
>> -error_update_in_progress_uncertain_data_value_try_again ?
>
>With what benefit, when we can wait a fraction of second and return a
>valid value?

How driver wait for that?  If writer taken lock, is reader 
blocked?
Not as far as I see.

Perhaps need yet another lock to do this properly, writer takes 
exclusive lock, reader takes non-exclusive lock that will block 
update writers but not other readers.

I'll leave this for now as I have other concerns with value readers 
that may be resolved as I gain some knowledge of the drivers in 
action.

>> Moving on:
>> What I do need is a list of drivers that will be handled by 
>> others, then I'll update the 'orphans', as well as continue 
>> the DIV_TO_REG removal work in progress.
>
>Consider all the drivers 'orphans' ;) I mean, changes to a driver are
>not reserved to its author. The original author will certainly check
>your patches, and give some kind of approval, but that's about it.
>
>> Is it time for me to learn the 'ticket' system?
>
>What do you mean?

Somewhere I read on lm_sensors to take out 'tickets' so others know 
what is being developed.
>
>> Who is documenting this?
>
>You? :)

Yes, well, I did start this particular mess :)

I'll repost via686a against -mm2 as new thread.

Cheers,
Grant.

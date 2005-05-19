From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <vra641dfglbm6g70gvnls87dl4huiqp62j@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali, Philip,

On Thu, 24 Mar 2005 17:02:29 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:
..
>All in all, I think we made it clear that all sysfs callbacks which write
>to a register and update the cache need locking. If a few ones don't
>need it for obscure reasons, it's probably not a problem to still lock
>there, as this will prevent the introduction of race conditions in the
>future for a very small price.

And leads to a simple guideline for porters/authors, unnecessary 
locking is harmless, a missing lock may become an obsure buglet.

I still go for lm85 locking model, perhaps overdone but seems 
clearly safe.  Certainly easy to point at lm85 as reference 
model for write locking in the author / porter guide.


Then think of reader locking, can drivers simply return 
-error_update_in_progress_uncertain_data_value_try_again ?  

Does sysfs have normal unix filelocking: exclusive write, 
non-exclusive read?  Or is that what the driver is enforcing?
Or is advisory locking too hard to clue-bat end user with?

Moving on:
What I do need is a list of drivers that will be handled by 
others, then I'll update the 'orphans', as well as continue 
the DIV_TO_REG removal work in progress.

Is it time for me to learn the 'ticket' system?

Who is documenting this? 

Cheers,
Grant.

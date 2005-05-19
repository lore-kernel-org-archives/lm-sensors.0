From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <9va241l9vnda4judqptqdcsbdbckrvr5vd@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

On Wed, 23 Mar 2005 00:23:24 -0800, Philip Pokorny <ppokorny@penguincomputing.com> wrote:
>>Not at all.
>
>I'm sorry, I didn't mean to offend.

Not offended, upset at not being able to work out how all this 
fits together, now that I'm passed the silly errors, learning 
how people build symbols inside macros and other weird stuff.  

So, we have yourself and Mark telling me not to worry, but I'm 
uneasy about the model or mental picture I build to describe 
what may be.  And yes, I don't have evidence yet, but these 
are areas I'm treating with suspicion, if you like.

You ever focus on wrong issues and build wrong model of 
what is important?  That's where I'm at trying to build 
understanding of a system I don't even have end-user 
experience with yet.

I get to the stage of cherry-picking the best ideas I've seen 
in the drivers, not one driver has struck me as a model driver.

>In addition to the way I know my drivers worked, I believe that all 
>other drivers have an update_lock semaphore that could be used to 
>protect read-modify-write's in the same way.

But they don't, and I wonder if they should?


Of course, I may have missed something...  I doubt I'll 
submit a non-compile-tested patch again, f'instance. :o)

Cheers,
Grant.

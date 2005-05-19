From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <4241946D.2060907@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:

>You ever focus on wrong issues and build wrong model of 
>what is important?  That's where I'm at trying to build 
>understanding of a system I don't even have end-user 
>experience with yet.
>  
>
Certainly, wouldn't be an experiecned programmer if I hadn't.

>I get to the stage of cherry-picking the best ideas I've seen 
>in the drivers, not one driver has struck me as a model driver.
>
>  
>
>>In addition to the way I know my drivers worked, I believe that all 
>>other drivers have an update_lock semaphore that could be used to 
>>protect read-modify-write's in the same way.
>>    
>>
>
>But they don't, and I wonder if they should?
>  
>
Ahh...  That's where I haven't really done a good job explaining 
myself.  I fully agree with you that they should.  It's obvious to me 
that the functions that *set* the values need to be protected to prevent 
an SMP machine from borking things up.  That's why I added the down/up 
calls in all of the write paths of the drivers I wrote.

Perhaps I should have made a bigger deal about this when I first 
realized it in the drivers I created and submitted patches for the other 
drivers...  Would have saved you the trouble...

:v)

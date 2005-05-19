From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: driver design question
Message-Id: <3F26A5E5.9030409@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 Good discussion.  Let me toss a few very quick comments:

Jean Delvare wrote:

> And I don't quite agree. We are already caching since we limit the
>
>frequency at which new data can be obtained. [...]
>
Quick note: The refresh frequency limit was introduced because the 
hardware would give bad results if you polled it too fast.  So, 
depending on what the datasheet for the chip says, we adjust the max 
polling frequency to match.  So this was to ensure accurate results from 
the hardware, not as a performace optimization.

> Hardly anything I can say against this, you're of course right. It's
>
>more about having a "beautiful" driver than anything else.
>  
>
My idea of the ideal driver is that it is almost transparent to the 
hardware.  The less caching, the better.

Now, your point about reducing a significant amount of latency is a good 
one.  That's a reasonable reason for such an optimization.  I'm not sure 
if it is a strong enough reason, though.  I think we'd need to do a 
little math to figure out exactly how much it 'costs' to read limits and 
what it would save us to poll them less frequently.


Phil

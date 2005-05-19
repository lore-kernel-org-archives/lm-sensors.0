From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Data block transactions fail on i2c-i801 controller?
Message-Id: <41DAF265.6090806@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
In-Reply-To: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi MDS, David:
> 
> * Mark D. Studebaker <mds4@verizon.net> [2004-12-07 10:14:54 -0500]:
> 
>>wow, a week turned into 2 1/2 months :)
>>sorry for the delay.
>>
>>There is no problem in the i801 block code.
>>The bug is in the lm93 driver. 
>>There is no check for success in lm93_read_block().
>>Therefore every block transaction is called 5 times (MAX_RETRIES).
>>What should have been 9 transactions turned into 45.
>>Rather obvious from the logs (which are still at the link David posted - 
>>thanks David).
>>I'll fix lm93.
> 
> 
> Yikes.
> 
> Yes it is obvious.  I'm eating my foot as I type this... or as my boss would
> say, working on a case of athlete's tongue. :)  I'm sorry about that Mark -
> thanks for fixing it.
> 
> David: please let us know how that works out when you get the chance.
> 
> Regards,
> 


I finally got a chance to look at this.   The transactions are now much 
faster.  Previously, when running the lm93 without block transfers:
# time sensors lm93-i2c-0-2e
real 0m1.343s
user 0m0.000s
sys  0m0.000s

Previously, running the same command with block transfers took almost 11 
seconds.

Now when run with block transfers:
# time sensors lm93-i2c-0-2e
real 0m0.508s
user 0m0.000s
sys  0m0.510s

I haven't had a chance to run it for an extended time to see if there 
are any reliability issues.

Thanks for fixing this!

David

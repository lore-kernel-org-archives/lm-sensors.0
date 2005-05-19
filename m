From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <20040202214056.0e691dbd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ok, I've patched the module again and adapted the script a bit -
> adding timestamps & debug log retrieval.

You're quite good at Perl, aren't you? :)

> I have uploaded the first output with 2 seconds between execution to:
>       http://james.evilpenguin.com/sensors/
> 
> I thought 1000 executions would be sufficient unless you think I need
> to run it longer or for a specified period of time?

No, it's perfect.

Strange that the number of errors varies so much between the three runs,
with no obvious logic.

Here are the stats:
Immediate success: 85.5%
Success after 1 retry: 10.4%
Success after 2 retries: 0.9%
Success after 3 retries: 0.03%

The high ratio of non-immediate successes clearly shows that the new
read method is welcome. The fact 3 retries were necessary only once out
of 3000 reads shows that setting max_retries to 5 isn't a bad choice. I
think we can leave it this way.

I'm pretty happy with the results and think of sending the patch to Greg
KH for inclusion into Linux 2.6, if it's OK for you too. I also plan to
backport the changes to our CVS (Linux 2.4 compatible) driver.

Thanks a lot for the great testing of my code. You'll got credits.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

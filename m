From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <irf141ps6ek4l2sh6gtoguh5n9u93jdlra@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 22 Mar 2005 16:40:00 -0800, Philip Pokorny <ppokorny@penguincomputing.com> wrote:

>The ADM1026 and LM85 drivers should be requesting the semaphore on the 
     ^^^^^^^-- off my work list as it requires too much change
for an obvious fix, care to comment on partial patch?  

I stopped when I realised it had an odd data structure and fixing 
that is too invasive as I cannot go further than compile test.


Per register access locking achieves nothing for a read/modify/write 
cycle as another proces may change that register during the modify 
phase if i2c bus released.  

On one hand I've been told not to trust cache coherency with chip 
registers, thus implying read/modify/write cycle, which should take 
exclusive access to i2c bus for the read and writeback operations.

Does that clarify my query?

Thnaks,
Grant.

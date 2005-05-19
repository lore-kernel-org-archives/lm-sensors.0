From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: RFC: test results for adm9240 auto fan clock divider
Message-Id: <njlg6152hh2gp2hn6o6qvbdm60v68295rm@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
In-Reply-To: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Tue, 19 Apr 2005 19:29:50 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>> this implies enabling bidirectional fan adjustment to do it right?
>
>No, it doesn't.
Okay, removed.

Still doing error checking over extreme user input, and around the 
fan_div decision point, took a couple days off to see-it-fresh...

Sometimes I can't see the wood for the trees :)

Reworked scaling right through system to trace error sources, now 
I know of lots of things that don't add errors, static inline 
scaling doesn't change much but looks neater.

Cheers,
Grant.

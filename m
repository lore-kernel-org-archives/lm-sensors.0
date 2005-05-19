From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking (0/1)
Message-Id: <j4j941t5u6u6cfofamalqj25a0da18ls1e@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 26 Mar 2005 13:26:03 +1100, Grant Coady <grant_nospam@dodo.com.au> wrote:

>On Sat, 26 Mar 2005 12:02:58 +1100, Grant Coady <grant_nospam@dodo.com.au> wrote:
>
>>Greetings,
>>
>>This patch adds locking around set operations that access 
>>data->something and go out to the chip.
>>
>Lucky last: it87

it87 needs a small fixup, oops.  This applies over previous patch 
in this series

Sign-off-by: Grant Coady <gcoady@gmail.com>


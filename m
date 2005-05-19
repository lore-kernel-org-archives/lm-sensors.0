From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <20050325223127.1361ed78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Methinks I'll change mine to not move 'val' assignment under lock
> and add blank in macro -- follow similar style.

Absolutely, I failed to comment on this - I am admittedly lost in the
flow of mails (which is why I want us to do one thing at a time).

As I said there is no point in locking during simple_strtol, so moving
it outside is better for performance and understanding, I think.

-- 
Jean Delvare

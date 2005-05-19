From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: More on SMBus multiplexing
Message-Id: <20041101223729.7b25d2a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mark D. Studebaker:

> Khali and I discussed this at length this weekend on IRC.
> We agree on a general direction toward a generic implementation,
> modeled in part on i2c-virtual.

True :)

> In the meantime, we agree that his i2c-amd756-4882 module is
> straightforward is headed in the right direction, and is acceptable
> for 2.6; so I no longer object to his patch.

Greg, please apply the patch then, unless you have personal objections.
(I may resend it with a Signed-off-by line if you want, or just add it
yourself.)

> In the near future I'll be working on cleaning up the original
> i2c-virtual implmementation.

Sounds good. Maybe you can work on this with Mark M. Hoffman since he
seems to be interested as well.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

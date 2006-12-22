From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Dec 2006 13:20:31 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <20061222142031.e8c4c388.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dz,

On Fri, 22 Dec 2006 10:30:11 +0800, DZShen at winbond.com wrote:
> Then, next time please send your 793 patches to us so that we can test
> it from here. I think it's Winbond's responsibilities to make sure your
> 793 patches work before checking into kernel.

Thanks for your proposal. It took me so much time to review the driver
that was provided by Winbond that I didn't dare asking you for more
help afterwards. It's not too late though. The w83793 driver is in
Linus' tree already, but kernel 2.6.20 is still in -rc stage. Feel free
to test the driver in 2.6.20-rc1 or later, with lm_sensors 2.10.1 or
later, and report to us if anything doesn't work as expected. We can
send bugfixes to Linus at any time.

Thanks,
-- 
Jean Delvare


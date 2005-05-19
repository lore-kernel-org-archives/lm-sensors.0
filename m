From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Problem status (ABIT NV7m)
Message-Id: <3EF48B5C.9080504@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030616210337.1874dc27.khali@linux-fr.org>
In-Reply-To: <20030616210337.1874dc27.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't recall seeing the original mail, guess I was busy.
In the original mail referenced below, the nforce driver is totally whacked.
It's giving a response to every address. Either the driver or the bus itself is hosed.
Power-cycle and try again.
Since you say you have a 83627hf, your best bet is to use the new ISA-only w83627hf driver
in CVS. Then you can bypass whatever problem you're having with nforce or its i2c bus.
mds

Jean Delvare wrote:
> (MARK, PLEASE READ THIS)
> 
> Hi Yann,
> 
> It has been quite a while since we last discussed about the problem you
> had with lm_sensors 2.7.0 and your Abit NV7m motherboard. I'm coming
> back to you for three reasons.
> 
> 1* We are about to release lm_sensors 2.8.0. I'd like to see your
> problem solved before this happen.
> 
> 2* We have had another user reporting a problem that seems to be similar
> to yours. Maybe this will help understand what happens.
> 
> 3* I hope that MDS will be more available than last time. I think he
> will be more able to help you than I was.
> 
> So, did you manage to solve your problem? (Mark, see
> http://archives.andrew.net.au/lm-sensors/msg02219.html for a reminder)
> 
> Could you try i2c & lm_sensors CVS to see wether the problem is still
> there or not? This would be more than helpful.
> 

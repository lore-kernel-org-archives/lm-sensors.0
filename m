From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Jul 2005 16:30:54 +0000
Subject: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433
Message-Id: <20050701163009.36d857f8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506300918.17966.bgardner@wabtec.com>
In-Reply-To: <200506300918.17966.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> Is there a preferred format?
> 
> "23 6c dc 1c 00 00 00 43"
> or
> "236cdc1c00000043"
> or
> "0x23 0x6c 0xdc 0x1c 0x00 0x00 0x00 0x43"
> Or, since it can be thought of as a 64 bit number
> "0x236cdc1c00000043"
> 
> I prefer the last one.

Last one is fine with me, although #2 would be fine too. I don't think
it really makes a difference.

Have you searched for similar use cases in the kernel tree? Not sure
where I would start looking for...

Thanks,
-- 
Jean Delvare

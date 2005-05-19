From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ALI1563 SMBus driver fix - take 2
Message-Id: <20050508145737.282191a7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050421090756.13436.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050421090756.13436.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Rudolf,

> Please can my patch go to 2.6.12? It is quite critical bug fix.
> Without the fixes driver is simply unusable.
> 
> 1) It wont work with newer revisions
> 2) It would not work even with older because i2c transaction size mask
> is missing. That means if you use eeprom driver and sensor driver you
> wont get any data. I mean data that would make sense.The missing mask
> would trigger some WORD modes...
> 
> 3) eeprom reading wont work because command type goes to DAT0 and not
> to CMD.
> 
> So whole patch is needed to address all "grave" issues.

I'd second Rudolf's request. This patch would be really welcome into
2.6.12, without it the i2c-ali1563 driver is plain broken and will most
probably generate lots of support requests.

Thanks,
-- 
Jean Delvare

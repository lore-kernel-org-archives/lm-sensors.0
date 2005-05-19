From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ALI1563 SMBus driver fix - take 2
Message-Id: <427CFE8F.5090802@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050421090756.13436.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050421090756.13436.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> Applied, thanks.
> 
> greg k-h

Hi,

Please can my patch go to 2.6.12? It is quite critical bug fix. Without the
fixes driver is simply unusable.

1) It wont work with newer revisions
2) It would not work even with older because i2c transaction size mask is
missing. That means if you use eeprom driver and sensor driver you wont get any
data. I mean data that would make sense.The missing mask would trigger some WORD
modes...

3) eeprom reading wont work because command type goes to DAT0 and not to CMD.

So whole patch is needed to address all "grave" issues.

Thanks

Regards
Rudolf



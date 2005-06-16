From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 16:49:18 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <H6IDMrg8.1118932733.2086030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
In-Reply-To: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hugo,

On 2005-06-16, Hugo Vanwoerkom wrote:
> Thanks for the quick answer.
> This is the dump of 0x2e 0x2f:

OK, this confirms that it has a hardware monitoring logical device at
0x290, like the other devices in this family. Can you now send the
output of:

isadump 0x295 0x296

Then I'll send you some preliminary hacky patches to try.

> For some reason my posts are not being routed from
> lm-sensors to my email address, I have noted that on
> other lists.

This may be due to the way you have registered with each list (you
usually can decide not to receive your own posts if you don't want to),
but in the case of lm-sensors it seems to be a routing problem at the
server location. I experienced the same problem a few days ago.
Hopefully this will be fixed soon.

Thanks,
--
Jean Delvare

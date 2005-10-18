From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 18 Oct 2005 10:00:41 +0000
Subject: [lm-sensors] smsc47b397 bug in libsensors?
Message-Id: <t4IcaqD3.1129621770.0445230.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all and especially Mark,

I noticed that the smsc47b397_features table in lib/chips.c is not zero
terminated. It should be, right?

Thanks,
--
Jean Delvare

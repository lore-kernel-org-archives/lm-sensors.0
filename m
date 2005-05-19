From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: Gigabyte GA-K8NS Ultra-939 issues
Message-Id: <JSJnwrEt.1115643501.3382270.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050507182053.GA4791@amelek.gda.pl>
In-Reply-To: <20050507182053.GA4791@amelek.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> So I should scratch the vid/vrm change from TODO list?

No. Marek is using Linux 2.4, where Rudolf's auto VRM picker is not
implemented. If he was using Linux 2.6, I wouldn't have suggested to
change VRM, because it would have been correct for sure already.

Feel free to add "backport auto VRM picker to Linux 2.4" to your TODO
list ;)

Thanks,
--
Jean Delvare

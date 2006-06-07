From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 07 Jun 2006 22:21:04 +0000
Subject: [lm-sensors] [PATCH] Fix the AMD756 SMBus Controller hang
Message-Id: <44875150.4060203@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485AD8C.5010906@sh.cvut.cz>
In-Reply-To: <4485AD8C.5010906@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> Isn't this a case for a DMI-based blacklist, plus a "force a delay"
> parameter?  If this is not a widespread problem, there is no reason to
> punish everyone who has a non-defective motherboard design...

Yes maybe. We know that the bus problem is not in the bus itself but in the 
controller which is stuck. But yes, it might be due to some noise on certain
designs...

Regards
Rudolf


From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Wed, 07 Jun 2006 22:01:23 +0000
Subject: [lm-sensors] [PATCH] Fix the AMD756 SMBus Controller hang
Message-Id: <20060607220123.GC2454@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485AD8C.5010906@sh.cvut.cz>
In-Reply-To: <4485AD8C.5010906@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 07 Jun 2006, Rudolf Marek wrote:
> Well we cannot detect it, nor we know more. We know that this fixes the problem.
> Given by cut & paste design of smbus controller it is likely to have this 
> problem with others...

Isn't this a case for a DMI-based blacklist, plus a "force a delay"
parameter?  If this is not a widespread problem, there is no reason to
punish everyone who has a non-defective motherboard design...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh


From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Tue, 28 Aug 2007 01:50:29 +0000
Subject: Re: [lm-sensors] [PATCH] v1 of IBM power meter driver
Message-Id: <20070828015029.GA10107@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com>
In-Reply-To: <20070827211446.GG32667@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 27 Aug 2007, Darrick J. Wong wrote:
> documentation doesn't mention any naming conventions for sensors that
> measure Watts, so I am proposing that they be called "powerX_input" in a
> fashion similar to temperature/rpm/current sensors.  If that is
> agreeable to everyone, I'll post a follow-up patch to amend the
> documentation.

What unit should we use? Watts are way, way too big as there is no
floating/fixed point in sysfs.  10^-6 W is probably what is called for,
since we already need 10^-3 V and 10^-3 A.  Small portable devices can
easily draw less than 10^-3 W nowadays.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <6oBsfUv5.1106046638.8506890.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E718CA.3070305@edgedesign.us>
In-Reply-To: <41E718CA.3070305@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip,


> Speaking of Bitkeeper, should we add that to the list of possible
> repository systems (CVS, SVN, and bk)?

I don't think we need the power of BitKeeper for this project (we don't
work much with branches, nor do I think we should, and this is where
BitKeeper really shines). Since not everyone likes BitKeeper's license
(even if things are improving these days), I guess it's easier for
everyone if we stick to CVS or SVN (SVN being my first choice, because
it allows renaming/moving files).

--
Jean Delvare

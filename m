From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 09 Oct 2010 00:03:27 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: fix reading of microcode revision
Message-Id: <20101009000327.GA27881@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CADB0A1020000780001B335@vpn.id2.novell.com>
In-Reply-To: <4CADB0A1020000780001B335@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 08 Oct 2010, Guenter Roeck wrote:
> On Fri, Oct 08, 2010 at 08:33:22AM -0400, Henrique de Moraes Holschuh wrote:
> [ ... ]
> > The nasty thing about microcode revisions is that they can increase at any
> > point in time (although we CAN get notified of it), but I don't think we 
> > ensure that they cannot go BACK after suspend/resume cycles.

Actually, I just checked the code and we do.  There are some misleading
comments on top of microcode_intel.c.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

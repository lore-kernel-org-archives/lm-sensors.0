From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: sensors shows uninteresting chips
Message-Id: <3FCBF20F.D1BFD1CF@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130145100.722ebe68.khali@linux-fr.org>
In-Reply-To: <20031130145100.722ebe68.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It tells us we forgot to add support to 'sensors' so
that's one reason to leave it the way it is.

Jean Delvare wrote:
> 
> Hi all,
> 
> The sensors program displays all i2c chips it'll find even the ones that
> do not have sensors interface. For example, I have a DC10+ capture
> board, and sensors will display entries for the adv7176 and the saa7110
> that live on it. This has no interest and sensors would better keep
> quiet about them IMHO.
> 
> For this reason, I plan to add a command line switch to ignore unknown
> chips. But I'm wondering if displaying them should still be the default,
> or if we should hide them by default (thus the switch would show them
> again). Since I don't see any interest in showing them, I'd opt for the
> second choice, but sometimes you have reasons I ignore. I remember I
> once proposed to hide adapters and algorithms by default, without
> realizing how valuable it was when it comes to helping users in support
> tickets and on the mailing-list. Maybe there's something similar for
> unknown chips? Can't think of anything, but maybe one of you will.
> 
> Thanks.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/

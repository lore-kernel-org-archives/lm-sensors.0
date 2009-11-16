From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 16 Nov 2009 20:03:27 +0000
Subject: Re: [lm-sensors] [PATCH v2 00/10] LIS3: Feature updates and
Message-Id: <20091116120327.7dd04a0d.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com>
	<4B0025DE.8050402@tremplin-utc.net>
In-Reply-To: <4B0025DE.8050402@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, daniel@caiaq.de, pavel@ucw.cz, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sun, 15 Nov 2009 17:01:34 +0100
__ric Piel <eric.piel@tremplin-utc.net> wrote:

> Op 10-11-09 13:41, Samu Onkalo schreef:
> > This patch set has earlier been sent to lm-sensors list (thus patch v2).
> > No changes after that except to patch 0006 to make it applicable to
> > 2.6.32-rc6 (no functional changes).
> :
> > 
> > I have possibility to test these changes only with 8 bit version (lis302d).
> > Since part of the changes are specific to 12 bit device, I would appreciate
> > if someone could try these on 12 bit device.
> I've just tested them on a 12-bit device and it seems to go fine
> (excepted the rate setting in patch 8).
> 
> Andrew, maybe you could already queue the first 5 patches, as they all
> look fine and are fixing bugs. So we are sure they are there for 2.6.33
> :-) The rest of the patch series is useful but just "new feature" and
> some need more work.

OK, I merged the five.

We could sneak some/all of them into 2.6.32 I guess, if you think
that's warranted?

The ones which were From:yourself were missing Samu's Signed-off-by:. 
I added it.

"[PATCH v2 04/10] lis3: fix show rate for 8 bits chips" has a poor
changelog.  "fix with 8 bits sensors".  It failed to tell us what the
bug was, what its user-visible effects were, how it was fixed.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

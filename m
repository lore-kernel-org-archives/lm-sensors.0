From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: New subscription request to list lm-sensors from
Message-Id: <20050516211434.35f8a69b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4288E1AD.5080909@edgedesign.us>
In-Reply-To: <4288E1AD.5080909@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> > Actually I disabled this for both list, as I don't think we want to
> > constantly monitor who's joining the list. Anyone who wants to
> > subscribe can do so.
> 
> OK. There are two switches to turn off, subscription approval (the
> mail above) and subscription notification.

Did both on both list, so that should be OK.

> > I set the lm-sensors list so that non-members can post. I set the
> > lm-sensors-commit list so that only members can post, except for the
> > CVS robot.
> 
> Why, shouldn't only the CVS robot be able to post? How about setting
> replies to the discussion list? That's what most projects do, e.g. the
> -commits list is a read-only list and any discussion started from
> there is relayed to a -devel list.

Mmm yes that's a possibility. My concern wass that people suscribed to
lm-sensors but not lm-sensors-commit would then lack the original post
for that thread - but maybe that's better that not seeing the thread at
all.

I've changed the lm-sensors-commit to work like that (or so I hope).

> OK, there is also:
> 
> 2* import old archives
> 
> I have all archives until yesterday.

Correct. And I guess you can pick the few additional ones from your own
mbox? Not a big problem if a few posts are missing anyway.

Oh, while we're at it. The old archive has a whole lot of posts named
"Notification d'??tat de la distribution" (with "Undeliverable:" 0 or
more times in front). These are crap. Could you possibly delete them
before you push the old archive into Mailman? They're all grouped
together.

Thanks,
-- 
Jean Delvare

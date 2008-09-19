From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Sep 2008 13:13:18 +0000
Subject: Re: [lm-sensors] +
Message-Id: <20080919151318.4db63c55@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D20D60.4030001@linutronix.de>
In-Reply-To: <48D20D60.4030001@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Thu, 18 Sep 2008 14:13:38 -0700, Andrew Morton wrote:
> On Thu, 18 Sep 2008 22:02:14 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > > I got removed from the Cc so I of course didn't see the comments :(
> > 
> > The copy of Sebastian's mail that went through the lm-sensors list
> > doesn't have you in Cc. Probably another bug in mailman...
> 
> Sebastian's original email had
> Message-ID: <20080916133542.GA2072@www.tglx.de>
> 
> and your reply had
> References: <20080916133542.GA2072@www.tglx.de>
> In-Reply-To: <20080916133542.GA2072@www.tglx.de>
> 
> 
> Looking at the headers, it seems that I just never received a copy of
> that email from mailman at all - I just got one copy direct from
> Sebastian.
> 
> Is mailman set up to not send duplicate copies to people who are on the
> cc list?  I think that's an admin option.

This is actually a per-user option, with the default value (for newly
created account) being an admin option. The current default is indeed
to avoid duplicate copies when possible, and this is what your user
account has.

> If so, I'd suggest that this
> be disabled - just send two copies.  That might fix the rather seriouis problem
> which we just hit, 

These should really be two independent things. Mailman isn't supposed
to strip people from the Cc list, even if it doesn't send a post to
them to avoid duplicate copies.

> and it will make that list behave like all the other Linux lists.

I could change the default setting, but I won't alter the per-user
setting.

> I rather like the send-two-copies behaviour.  As things stand at
> present, my lm-sensors mailbox is missing all the emails on which I was
> cc'ed, so it's a bit of a mess.  If I remember to move all the
> lm-sensors traffic which hits my inbox over into the lm-sensors list
> folder then presumably things would be fixed up, but that's rather a
> pain.

Feel tree to change your own account setting to get duplicate copies if
you prefer it that way:
  http://lists.lm-sensors.org/mailman/options/lm-sensors
"Avoid duplicate copies of messages?" -> No

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

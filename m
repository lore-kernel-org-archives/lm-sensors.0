From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Jun 2011 15:42:27 +0000
Subject: Re: [lm-sensors] WPCD374L question
Message-Id: <20110611174227.433c5e45@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDD468B.2060106@flexstar.com>
In-Reply-To: <4DDD468B.2060106@flexstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 11 Jun 2011 08:56:10 -0600, Carl Morris wrote:
> Hi Jean,
> 
> On 6/11/2011 8:10 AM, Jean Delvare wrote:
> > I would be the one who posted the call for contact. Meanwhile, looking
> > at ticket:
> >    http://www.lm-sensors.org/ticket/2182
> > it seems that everything is solved, both in sensors-detect and in the
> > lm85 driver, so the call should be cleared. I've just done that.
> >
> > As far as your system is concerned, I can't say anything without the
> > complete output of (a recent version of) sensors-detect. Maybe your
> > system simply doesn't implement hardware monitoring, or it has a not
> > yet supported device.
> 
> Thanks for the reply.  In our investigation of how to solve our
> immediate problem we learned about IPMI and used it to create our
> solution.  Making it work with sensors-detect is now a low/nonexistent
> priority.  If you would like me to harvest some info for you anyway
> I can do that, but for me the issue is closed.  Thanks again...

No need. If you're happy with your current solution, all is fine!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

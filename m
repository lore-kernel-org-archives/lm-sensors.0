From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Jul 2007 20:07:45 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070721220745.52b4b3ed@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Jul 2007 19:11:04 +0200, Hans de Goede wrote:
> I agree that we should do some sanity checking, but not too much as to not 
> clutter the drivers. However, I think we first need to define some kind of 
> standard as to what sanity checking we will do, and what not, and how to handle 
> out of range values (clamp versus EINVAL), actually I've written and send a 
> proposal for this to the list already as our discussion got me thinking about this.

What I've been telling contributors so far is: clamp for "continuous"
values those boundaries aren't known to the user, -EINVAL for the rest.
The rationale is essentially the same I mentioned earlier in this
thread: limits can be computed by libsensors, and we do not want a
slightly out-of-bound values to be ignored or trigger errors. But for
pretty much all the rest, returning an error on invalid values seems to
be the sane thing to do.

I agree that having these rules written somewhere would probably save
some question from new driver contributors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

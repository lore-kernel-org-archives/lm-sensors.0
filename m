From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Sep 2010 08:00:03 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <20100907100003.5a5a3e7c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 6 Sep 2010 18:32:56 -0700, Guenter Roeck wrote:
> On Mon, Sep 06, 2010 at 12:18:58PM -0400, Jean Delvare wrote:
> > On Sat, 4 Sep 2010 10:28:32 -0700, Guenter Roeck wrote:
> > > Maybe the best approach is to not (try to) install it at all, but just provide
> > > it as hint.
> > 
> > Isn't it exactly what we're doing today?
> > 
> Yes, sorry, I meant rewording the text.

Oh, OK. Feel free to update sensors-detect with a better text, no
problem.

> > > (...)
> > > The shared library locations are yet another problem. Not sure how to address
> > > that either.
> > 
> > I have no idea what you're talking about, sorry.
>
> I meant that Ubuntu doesnm't use /usr/local/lib. Maybe that isn't really a problem, though.

Should be easy enough to check whether /usr/local/lib is
in /etc/ld.so.conf, and warn the user if it isn't. Again, feel tree to
do that if you think it's helpful.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

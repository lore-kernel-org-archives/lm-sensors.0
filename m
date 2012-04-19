From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2012 13:26:49 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <20120419152649.0e49735e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrey,

On Thu, 19 Apr 2012 15:15:24 +0400, Andrey Repin wrote:
> Greetings, Jean Delvare!
> 
> > -          grep -q '^$(LIBDIR)$$' /etc/ld.so.conf || \
> > -          grep -q '^$(LIBDIR)[[:space:]:,=]' /etc/ld.so.conf || \
> > -          grep -q '[[:space:]:,]$(LIBDIR)$$' /etc/ld.so.conf || \
> > -          grep -q '[[:space:]:,]$(LIBDIR)[[:space:]:,=]' /etc/ld.so.conf || \
> > +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '^$(LIBDIR)$$' || \
> > +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '^$(LIBDIR)[[:space:]:,=]' || \
> > +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '[[:space:]:,]$(LIBDIR)$$' || \
> > +          cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '[[:space:]:,]$(LIBDIR)[[:space:]:,=]' || \
> >                 ( echo '******************************************************************************' ; \
> >                   echo 'Warning: Library directory $(LIBDIR) is not in /etc/ld.so.conf!' ; \
> >                   echo '         Add it and run /sbin/ldconfig for the userspace tools to work.' ; \
> 
> http://en.wikipedia.org/wiki/Cat_(Unix)#Useless_use_of_cat
> 
> Move file lists to grep, save yourself a few CPU cycles.

This is on purpose. /etc/ld.so.conf.d/*.conf may match nothing (as is
the case on my own system), passing that as a parameter to "grep" would
cause it to return an error code, even if the requested directory was
found in /etc/ld.so.conf. This could be worked around by checking the
exact value of $? after the call, but this would make the code a lot
more complex than it is currently, for a rather small benefit. We don't
care that much about performance in "make install", you don't run that
command several times every day.

As far as performance is concerned, a much cheaper optimization is to
merge all 4 regular expressions into a single one - which I just did:
http://lm-sensors.org/changeset/6046

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

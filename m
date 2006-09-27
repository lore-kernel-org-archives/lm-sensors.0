From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Sep 2006 07:32:51 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <20060927093251.3f067aa7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926140502.00d29dd5.khali@linux-fr.org>
In-Reply-To: <20060926140502.00d29dd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

Michael Renzmann wrote:
> > As far as I know, Trac is not able of keyword expansion so far. However, 
> > I'll ask on #trac and see what I can find out about that.
> 
> Outcome: no support for keyword expansion at this time. Trac accesses 
> the repository directly and would need to take care of the expansion 
> itself (just as the svn client does).
> 
> See also:
> http://thread.gmane.org/gmane.comp.version-control.subversion.trac.general/4133
> http://trac.edgewall.org/ticket/717

Thanks for the investigation. Hopefully a future version of trac will
support keyword substitution. In the meantime, we can go with either a
commit-triggered script, or a CGI. I have a CGI working, it's really
simple:

---8<---
#!/bin/sh
# Let the users access the latest version of sensors-detect, with keywords
# substituted.

echo "Content-Type: text/plain"
echo

svn cat http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
---8<---

Is there a problem with having this CGI running on the lm-sensors.org
server? Or is the commit-triggered approach prefered for performance
reasons? I don't know how to do commit-triggered scripts.

Note that if this is too much hassle, we can probably stick to the
current situation for some more time; the lack of keyword substitution
is only a minor annoyance.

Thanks,
-- 
Jean Delvare


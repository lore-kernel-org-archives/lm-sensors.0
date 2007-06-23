From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jun 2007 13:08:26 +0000
Subject: Re: [lm-sensors] Quick Question about latest IBM thinkpads!
Message-Id: <20070623150826.66a641f9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <524002.68161.qm@web82504.mail.mud.yahoo.com>
In-Reply-To: <524002.68161.qm@web82504.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Mon, 18 Jun 2007 21:24:04 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 18 Jun 2007, Jean Delvare wrote:
> > For the stable branch of lm-sensors, explicit support will be needed. If
> > you plan to merge support in the 2.6.23 kernel, it would probably be a
> > good thing to merge the user-space support now, so that it makes it into
> > the next release (2.10.4) and is available when kernel 2.6.23-rc1 is
> > released.
> 
> What needs to be done so that lm-sensors userspace will grok thinkpad-acpi
> sensors?  Is there a howto somewhere?

If you followed the standard sysfs interface (and you really want to),
the code in the lm-sensors-3.0.0 branch should work right away. But
we're nowhere next to a releasable state on this branch, so I'd
suggests that you also add support to the trunk, which should become
lm-sensors 2.10.4 soon.

We don't have a HOWTO, but using a similar change as an example should
make the job easy:
  http://www.lm-sensors.org/changeset/4355

If you have specific questions on the way, just ask and we'll try to
help. I'll be happy to review (and test) your code when you're done.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

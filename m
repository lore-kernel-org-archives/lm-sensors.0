From: ch@westend.com (Christian Hammers)
Date: Fri, 21 Oct 2005 12:07:42 +0000
Subject: [lm-sensors] [Ticket #2078] sensor values are sometimes wrong
Message-Id: <20051021100433.GA6895@westend.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051021083606.GB19748@westend.com>
In-Reply-To: <20051021083606.GB19748@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

On Fri, Oct 21, 2005 at 07:37:12PM +1000, Grant Coady wrote:
> > - sensor values give suddenly 0 or arbitrary values
> 
> The sensor chips operate in an extremely noisy electrical environment,
> stuff happens, your application software may denounce this.
...
> > This makes it absolutely unusable for monitoring in production use.
> 
> No, you expect a kernel driver to do the work of a custom user-space
> solution, IOW you want the kernel to enforce policy.  The kernel +
> drivers do not enforce policy, they control access to resources.

A user normally does not access the kernel driver not even via /proc.
He uses /usr/bin/sensors or /usr/sbin/sensord, which look like they
should be considered applications.

So if the current problems arise from /usr/bin/sensors being to
lowlevel, it should be enhanced by a flag that applies a certain
policy like e.g. hide temperature alerts that only exists for one
second as the CPU surely does not heat up to 999?C and cool down back
to 42?C within that time. This would make it way more usable.


> > Data for this mainboard although the problem is more general and
> > experienced on several other models and brands, too:
> 
> I don't do free consulting.

Writing that sounds stupid and moreover lets users feel offended,
especially as they only write exactly those information that the
projects FAQ asked them to supply to each bug report. -> *plonk*

bye,

-christian-

-- 
Christian Hammers             WESTEND GmbH  |  Internet-Business-Provider
Technik                       CISCO Systems Partner - Authorized Reseller
                              L?tticher Stra?e 10      Tel 0241/701333-11
ch@westend.com                D-52064 Aachen              Fax 0241/911879


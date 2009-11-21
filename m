From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Nov 2009 20:11:27 +0000
Subject: Re: [lm-sensors] Support for Family 10h CPUs - Not all sensors are
Message-Id: <20091121211127.7b823102@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 Nov 2009 18:28:25 +0100, Jan Bessai wrote:
> according to AMD (
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/41322.pdf
> ) not all AMD K10 CPUs have defect sensors. In fact only DR-* revisions
> are affected. All CPUs with Socket AM3 as well as all Phenom II Processors
> and some Opterons are unaffected (DA-*, RB-*, HY-*).
> Please reconsider the statement "Embedded sensors are known to be
> unreliable, and won't be supported ever.".

We can do that. But how does this translate into CPUID numbers? That's
all we can check.

> Linux should not lack temperature sensor support for such popular
> Processors.

This is a pointless statement, I hope you realize it. There are a lot
of things that should not be, but are still, for various reasons. Want
an example? A big company such as AMD shouldn't have released millions
of CPUs with broken thermal sensors. As it stands, we do what we can to
cope with their mistake.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

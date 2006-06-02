From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Jun 2006 20:18:05 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060602221805.2ba332d3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> > I don't know of any better ways to automatically identify mainboards.
> > However, I've been mulling over an idea to make manual configuration
> > easier.  Rather than distribute a single giant sensors.conf.eg as we
> > do now, we could distribute a tree of conf files, one per board:
> > 
> > /etc/sensors/
> > /etc/sensors/asus/
> > /etc/sensors/asus/p4s333.conf
> > /etc/sensors/asus/p4c800-e-deluxe.conf
> 
> I personally think this is a good idea, but how big will this become? 
> Any idea how many motherboards there are out there? lots but how much?

The Motherboard Monitor project had around 1100 known motherboards when
it stopped 2 years ago. So depending on how successful we get, the
number of configuration files could range from a few hundreds to 2000
or so.

-- 
Jean Delvare


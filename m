From: Clemens Ladisch <clemens@ladisch.de>
Date: Mon, 23 Nov 2009 07:58:37 +0000
Subject: Re: [lm-sensors] Support for Family 10h CPUs - Not all sensors are
Message-Id: <4B0A40AD.2040702@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sat, 21 Nov 2009 18:28:25 +0100, Jan Bessai wrote:
> > according to AMD (
> > http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/41322.pdf
> > ) not all AMD K10 CPUs have defect sensors. In fact only DR-* revisions
> > are affected. All CPUs with Socket AM3 as well as all Phenom II Processors
> > and some Opterons are unaffected (DA-*, RB-*, HY-*).
> > Please reconsider the statement "Embedded sensors are known to be
> > unreliable, and won't be supported ever.".
>  
> We can do that. But how does this translate into CPUID numbers?

Family 0xF, extended family 1, model 2.

Or, to quote a certain driver that happend to be posted on this list
recently:

static bool __devinit has_erratum_319(void)
{
	/*
	 * Erratum 319: The thermal sensor of older Family 10h processors
	 *              (B steppings) may be unreliable.
	 */
	return boot_cpu_data.x86 = 0x10 && boot_cpu_data.x86_model <= 2;
}


HTH
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

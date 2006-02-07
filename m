From: swsnyder@insightbb.com (Steve Snyder)
Date: Tue, 07 Feb 2006 13:06:23 +0000
Subject: [lm-sensors] ISA and PIIX4 both working; which to use?
Message-Id: <200602070806.24032.swsnyder@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200602060859.54544.swsnyder@insightbb.com>
In-Reply-To: <200602060859.54544.swsnyder@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Mark.

Thanks for the response.

On Monday 06 February 2006 11:41 pm, Mark M. Hoffman wrote:
> Hi Steve:
>
> * Steve Snyder <swsnyder at insightbb.com> [2006-02-06 08:59:54 -0500]:
> > On the advice of sensors-detect I am using the following modules under
> > Fedora Core 4 on my 440BX-based system:
> >
> > MODULE_0=i2c-piix4
> > MODULE_1=i2c-isa
> > MODULE_2=w83781d
> > MODULE_3=smbus-arp
> >
> > When I run sensors, I get duplicated output (see below).  I don't need
> > both of these sources to be queried and plan to stop using one of them.
> >
> > Which of these 2 sources is preferred over the other?
>
> ISA access is faster than I2C/PIIX4, and potentially more reliable also. 
> I would also get rid of the MODULE_3 line as that's useless for a 2.6.x
> kernel anyway (there is no such module).
>
> Regards,


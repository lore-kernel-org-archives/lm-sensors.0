From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 18 Nov 2010 16:10:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Rewritten without using
Message-Id: <20101118161035.GA30790@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
 <1289340866.22931.304.camel@groeck-laptop>
 <AANLkTinEzMPxEnrEY5K8u5qLkQutU0vdRh_vOGU=QOCF@mail.gmail.com>
 <20101116150305.GA4442@ericsson.com>
 <AANLkTikQ9X0ntcBfD391zsyAZ1BfCCD1-DcKBb-O8kJn@mail.gmail.com>
 <20101118153856.GA27671@ericsson.com>
 <AANLkTi=VPh-s3UAJLoN-CF7hyaP67E7dTrcpKAodAmdT@mail.gmail.com>
In-Reply-To: <AANLkTi=VPh-s3UAJLoN-CF7hyaP67E7dTrcpKAodAmdT@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Davide Rizzo <elpa.rizzo@gmail.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>

On Thu, Nov 18, 2010 at 10:54:05AM -0500, Davide Rizzo wrote:
> 2010/11/18 Guenter Roeck <guenter.roeck@ericsson.com>:
> > Hi Davide,
> >
> 
> Hi Guenter,
> 
> > Looks like you still have trouble with line wraps. You might want to get this fixed;
> > having to figure out why the patch does not apply is a bit annoying.
> >
> 
> You said me that attaching the patch to the mail is not correct.
> First times I copy/pasted from kate, that broke tabs.
> The last time I copy/pasted from kwrite, that seemed me correct (but
> you're saying me that it isn't).
> I'm using gmail, please explain me how to attach a patch to the e-mail.
> 
Cut-and-paste is never a good idea. I avoid such problems by generating patches
with "git format-patch" and sending them with "git send-email" from my linux system.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 Jan 2007 08:24:39 +0000
Subject: [lm-sensors] [PATCH] [2.6.21] Add adt7467 to lm85
Message-Id: <20070126092439.eddec93c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070125173825.c7a60c7e.khali@linux-fr.org>
In-Reply-To: <20070125173825.c7a60c7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Olof,

On Thu, 25 Jan 2007 11:11:24 -0600, Olof Johansson wrote:
> On Thu, Jan 25, 2007 at 05:38:25PM +0100, Jean Delvare wrote:
> > Did you make sure that the ADT7467 is 100% compatible with the ADT7463?
> > The change of major revision number causes me to have a doubt.
> 
> The main difference seems to be that the 7467 lacks some of the voltage
> features, something that I wasn't using in my setup so I never ran into
> issues with it. I'll double-check and repost.

If the ADT7467 has less features, we really need to adjust the driver
not to export the missing ones. Otherwise users will keep reporting
these as a bug.

Thanks,
-- 
Jean Delvare


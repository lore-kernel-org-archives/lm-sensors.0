From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 02 Nov 2010 01:40:07 +0000
Subject: Re: [lm-sensors] fix a minor error for sensors-detect
Message-Id: <20101102014007.GA27350@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CCF6794.6030100@linux.intel.com>
In-Reply-To: <4CCF6794.6030100@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chen,

On Mon, Nov 01, 2010 at 09:21:24PM -0400, Chen Gong wrote:
> Hi, Guenter
> 
> I can't access CVS easily from here and I don't know where to submit a 
> lm-sensor tool patch, so I put it here.
> 
> I occasionally found on my board there is a sensor named asc7621 and
> it had been supported since 2.6.34 (I get this info from lm-sensor wiki 
> devices list), but sensors-detect doesn't update its status. Until now
> it still shows "to-be-written". So I update it from "to-be-written" to 
> "asc7621". Now it works fine.
> 
Jean fixed the problem on June 19. The latest released version of lm-sensors 
(3.2.0) should include the fix.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: jordan.crouse@amd.com (Jordan Crouse)
Date: Thu, 27 Apr 2006 14:43:41 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060427144341.GE15384@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 27/04/06 09:31 -0400, Mark M. Hoffman wrote:
> Another alternative would be to implement support for SMBALERT#.  This is
> basically a third wire that acts as an interrupt signal from slave to
> master.  At the moment, there is no support for it in the I2C core, but
> it could be added... and it may be easier than adding host-as-slave
> support (if your hardware can support SMBALERT#).

I don't think the 1100 has specific support for that, but you could
always plug it into an unused GPIO, I would think, and process the interrupt
from there.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>



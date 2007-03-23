From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 23 Mar 2007 15:43:09 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <20070323164309.90169ec2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 23 Mar 2007 10:06:10 +0100, Hans de Goede wrote:
> Wouldn't it be wise to target only 3.x / 4.x with the dmi-detect code, and thus 
> assume dynamic chip support and the new syntax? I haven't been doing much 
> lm-sensors related work myself lately, but I can make some time free to get the 
> dyn chip support into the 3.0 branch asap, if that helps the dmi detect code to 
> become future proof. I think only support 3.x / 4.x is easiest / best otherwise 
> the code becomes convoluted with compatibility muck from the day it was written.

I tend to agree, yeah. The only problem is that I cannot give any
timeline for the dyn chip support, as I do not have the time to work on
it myself. But if you're going to do it, alright.

-- 
Jean Delvare


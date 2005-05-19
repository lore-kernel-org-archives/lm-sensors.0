From: tsawyer@sandburst.com (Travis B. Sawyer)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: new MAX6653 driver
Message-Id: <1094820947.26717.9.camel@pavement.sandburst.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094741705.29203.18.camel@pavement.sandburst.com>
In-Reply-To: <1094741705.29203.18.camel@pavement.sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2004-09-10 at 05:29, Jean Delvare wrote:
> Which system do you have this chip on? If it is something other users are
> likely to have on their boards, I have a patch (attached) which adds support
> for the MAX6653 (and MAX6663/MAX6664 for that matter) to sensors-detect. Could
> you please give it a try? If it works I'll apply it to the CVS repository (as
> soon as I get back to a decent Internet access).
> 
> Thanks.
Jean:

Arrrgh.... my kernel is config'ed for built-in drivers, not modules.

However, sensors-detect found my 2 PCA9548's, but thought they were
PCA9542's.

I grabbed the virtual bus code posted here quite a while ago, made some
changes and it works quite well through the 9548's.

If I _*EVER*_ get some down time, I'll through that over the fence also.


-- 
Travis B. Sawyer
Sandburst Corporation  http://www.sandburst.com

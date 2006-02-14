From: bezaur@gmail.com (Charles Spirakis)
Date: Tue, 14 Feb 2006 21:31:14 +0000
Subject: [lm-sensors] [patch] hwmon: Add support for w83791d sensor chip
Message-Id: <5bfe43f80602141331l42ea87d8x3b173e13e20363b4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
In-Reply-To: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>


Add support for the w83791d sensor chip. The w83791d hardware is
somewhere between the w83781d and the w83792d and this driver code is derived
from the code that supports those chips.

Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

Resend. Removing the Kconfig.orig which didn't belong in the patch.

-- charles

On 2/14/06, Charles Spirakis <bezaur at gmail.com> wrote:
> From: Charles Spirakis <bezaur at hotmail.com>
>
> Add support for the w83791d sensor chip. The w83791d hardware is
> somewhere between the w83781d and the w83792d and this driver code is derived
> from the code that supports those chips.
>
> Signed-off by: Charles Spirakis <bezaur at gmail.com>
>
> ---
>
>   Documentation/hwmon/w83791d |  117 +++
>   drivers/hwmon/Kconfig       |   10
>   drivers/hwmon/Kconfig.orig  |  462 ++++++++++++
>   drivers/hwmon/Makefile      |    1
>   drivers/hwmon/w83791d.c     | 1647
> ++++++++++++++++++++++++++++++++++++++++++++ 5 files changed, 2237
> insertions(+)
>
>
> Full patch included in attachement.
>
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83791d_support.patch
Type: text/x-patch
Size: 56322 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060214/be853dcf/w83791d_support-0001.bin

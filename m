From: soren3@gmail.com (=?iso-8859-1?q?S=F8ren_Lott?=)
Date: Wed, 08 Jun 2005 09:07:19 +0000
Subject: [lm-sensors] Re: 2.6.12-rc6-mm1
Message-Id: <200506080408.04914.soren3@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200506072259.52848.soren3@gmail.com> <20050608075340.12bd49e9.khali@linux-fr.org>
In-Reply-To: <20050608075340.12bd49e9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Wednesday 08 June 2005 02:53, Jean Delvare wrote:
> Hi Soren,
Hi,
> Which kernel are you upgrading from?

from 2.6.12-rc5-mm2

> Is CONFIG_PNPACPI set? If it is, try whithout it.

nope, don't even have CONFIG_PNP set.

> If it doesn't work, please try reverting (in reverse order):
>   gregkh-i2c-hwmon-01.patch
>   gregkh-i2c-hwmon-02.patch
>   gregkh-i2c-hwmon-03.patch
>   i2c-chips-need-hwmon.patch
>   gregkh-i2c-hwmon-02-sparc64-fix.patch
> and see how it goes.

yeap, reverting these did the trick, all i2c entries in sysfs are back. :)

> Thanks,

thanks alot.
cheers.

-SL

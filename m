From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 09 Sep 2009 22:14:00 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon driver for ACPI 4.0 power meters
Message-Id: <20090909221400.GC10521@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090820213755.GB10521@tux1.beaverton.ibm.com> <20090821091939.GC21167@elf.ucw.cz> <20090821184718.GD23397@tux1.beaverton.ibm.com> <20090821221705.GA2108@elf.ucw.cz> <20090822011744.GH10521@tux1.beaverton.ibm.com> <20090821140159.GB1328@ucw.cz> <20090908202410.GS10521@tux1.beaverton.ibm.com> <20090909080637.GA28353@elf.ucw.cz> <20090909182051.GA26158@tux1.beaverton.ibm.com> <20090909212752.GA7248@elf.ucw.cz>
In-Reply-To: <20090909212752.GA7248@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Wed, Sep 09, 2009 at 11:27:52PM +0200, Pavel Machek wrote:

> See the archives. Anyway it should be default to N -- it is new driver
> and it is not essential in any way. "default Y" is for features that
> were always in and are now optional.
 
I suppose you have a point--it's not terribly essential.  I've just sent v5
with default N.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

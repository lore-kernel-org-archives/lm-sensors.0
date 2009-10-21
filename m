From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Oct 2009 13:41:03 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091021154103.466f89ae@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 21 Oct 2009 23:28:38 +1000, Adam Nielsen wrote:
> > Now you are right that the limitation of the it87 driver to only read
> > VID at initialization time (for some of the supported chips at least,
> > amongst which the IT8718F) makes the VID value useless on systems with
> > CPU changing VID over time, as is your case. Even if we managed to get
> > a valid VID reading from your IT8718F chip (assuming this is possible
> > at all) it wouldn't be that interesting, unless we also address the
> > driver limitation about reading VID in real-time. Which is very complex
> > (which is why it didn't happen yet.)
> 
> Are you suggesting resetting the chip occasionally to read in the VID again?
> Because that's an interesting idea...but yes, it would be complicated :-)

No, it's not a problem of resetting the chip. The problem is that the
VID reading is in shared registers, which other drivers may access too.
So we need proper locking to protect the access to these registers.
This requires cooperation between the drivers. There have been some
efforts related to this, but we're not there yet.

For now we're working around the problem by only accessing the
registers at module load time, because the kernel serializes module
loading. But this is a hack, really.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

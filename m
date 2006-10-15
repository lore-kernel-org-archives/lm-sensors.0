From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 15 Oct 2006 12:09:18 +0000
Subject: [lm-sensors] [3/3] 2.6.19-r2: known regressions with patches
Message-Id: <20061015140918.33a6e0a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061014111458.GI30596@stusta.de>
	<20061014113409.GL30596@stusta.de>
In-Reply-To: <20061014113409.GL30596@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sylvain BERTRAND <sylvain.bertrand@gmail.com>, David Hubbard <david.c.hubbard@gmail.com>, lm-sensors@lm-sensors.org, Greg Kroah-Hartman <gregkh@suse.de>

Hi Adrian,

On Sat, 14 Oct 2006 13:34:09 +0200, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc2 compared to 2.6.18
> with patches available.
> 
> Unless there are specific reasons against doing so, we should try to get 
> these patches into -rc3.
> 
> (Especially the lad who wrote the patch for the third entry should ush 
>  his patch...)
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> (...)
> 
> Subject    : w83781d modprobing failure
> References : http://bugzilla.kernel.org/show_bug.cgi?idr93
> Submitter  : Sylvain BERTRAND <sylvain.bertrand at gmail.com>
> Caused-By  : David Hubbard <david.c.hubbard at gmail.com> (?)
>              commit 8202632647278eba7223727dc442f49227c040d0 (?)
> Handled-By : Jean Delvare <khali at linux-fr.org>
> Patch      : http://bugzilla.kernel.org/show_bug.cgi?idr93
> Status     : patch available

Patch was tested successfully by Sylvain, I sent it to Greg already,
who should push it to Linus soon (with 7 other hwmon patches.)

Thanks,
-- 
Jean Delvare


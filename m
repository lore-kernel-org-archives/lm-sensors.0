From: thomas536@gmail.com (Thomas Garner)
Date: Fri, 02 Mar 2007 02:14:13 +0000
Subject: [lm-sensors] IT8726F support (was: mcp61 sensors support)
Message-Id: <9ef864c50703011814x9153e4ev80c977e1d2a1b06@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070301075719.9e1c0127.khali@linux-fr.org>
In-Reply-To: <20070301075719.9e1c0127.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I should have known that Murphy's Law would kick in on this one.  I
shipped this machine off to a remote location yesterday.  When it
arrives, I will try to look into this.  Sorry for any inconveniences.

Thomas

On 3/1/07, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Thomas,
>
> On Thu, 22 Feb 2007 12:43:46 -0500, Thomas Garner wrote:
> > Yeah, I can recompile, no problem.
>
> OK, then can you please edit drivers/hwmon/it87.c, replace:
> #define IT8716F_DEVID 0x8716
> with:
> #define IT8716F_DEVID 0x8726
>
> Recompile, test and report. The report should include the output of
> "sensors" and the message printed in the kernel logs when you loaded
> the it87 driver.
>
> Please also provide a dump of the Super-I/O config space:
> isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 0x04
>
> And a list of the hardware monitoring items listed by your BIOS.
>
> Thanks,
> --
> Jean Delvare
>


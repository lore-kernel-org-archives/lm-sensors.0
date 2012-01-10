From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 Jan 2012 14:42:35 +0000
Subject: Re: [lm-sensors] [PATCH 0/5] hwmon: Series of patches for LM63
Message-Id: <20120110144235.GA5209@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326166923-11187-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326166923-11187-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 10, 2012 at 02:06:30AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 9 Jan 2012 20:15:44 -0800, Guenter Roeck wrote:
> > On Mon, Jan 09, 2012 at 10:41:58PM -0500, Guenter Roeck wrote:
> > > From: Guenter Roeck <guenter.roeck@ericsson.com>
> > > 
> > > Add support for LM96163 and a couple of additional sysfs attributes.
> > > 
> > > Tested with LM63 and LM96163.
> > 
> > Just noticed that I sent out most of that series in November.
> > Completely forgot about that, and thought it got lost. Oh well.
> > 
> > Take it as a reminder that some of it is still waiting for review,
> > and at least the update_interval patch is new.
> 
> Incidentally this was on my to-do list for today. It happens that I
> have an LM64 on an old graphics card so I will even be able to test
> your changes (and mine) on it.
> 
Excellent.

For the LM96163 register dump I sent to you earlier, turns out I had to set the 
correct sensor type (3904 vs. the default thermal diode). I should add support
for temp2_type for that chip.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

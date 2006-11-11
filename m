From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 11 Nov 2006 15:20:44 +0000
Subject: [lm-sensors] sensord and missing alarms
Message-Id: <20061111162044.84400844.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061110190557.GA25801@dbz.icequake.net>
In-Reply-To: <20061110190557.GA25801@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ryan,

On Fri, 10 Nov 2006 13:05:57 -0600, Ryan Underwood wrote:
> Some sensor chipsets assert an alarm always while a condition is true
> (lm78) while others only assert alarm when that condition is crossed
> (winbond).  I want to add a separate software "latch" for transient
> alarms that can only be cleared by software, so that it is impossible
> for sensord to miss an alarm.

Actually, most chips, including the LM78, assert the alarm flag as long
as the condition is true *and* the flag wasn't read, so the condition
might no longer be true when you read the flag.

As far as I know, most Winbond chips behave the exact same way. We used
to pick the wrong registers for some of them until recently, which may
cause the behavior you describe above, but this should be fixed now. As
far as I know, only the old W83781D doesn't support this.

> Has this been done before, are there any arguments for or against it?

No, this wasn't done. The rule so far is that drivers should report the
alarm bits exactly as read from the hardware. I can't really tell what
I think about the idea until you tell us exactly which chip you are
working with, which exact problem you encountered, and how (where) you
intend to fix it (driver, libsensors, application...)

My first impression is that, if you are really interested in the past
states of the sensors, then you better continuously log all the values
(some applications do that, drawing nice graphs.) A single alarm bit
isn't going to tell you much.

-- 
Jean Delvare


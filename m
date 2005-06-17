From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Jun 2005 15:23:35 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <ND6WkpWO.1119014000.8021190.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sebastian,

On 2005-06-17, Sebastian Witt wrote:
> I've found out that I made a mistake: I used the IT8712_V07 datasheet and
> not the datasheet for the IT8705F. That's because my last board has
> a IT8712F and my current board has now a IT8705F...seen it while
> trying to get the VID reading.
>
> However the automatic fan control registers/values are on both chipsets the
> same, I haven't seen a difference in the datasheets. So automatic
> fan control should work on both chipsets. The check for revision/version
> should be fixed.

Agreed, your code should work (and be enabled) on both the latest IT8505F
and the latest IT8712F chips. I'm sorry I didn't have the time to
review your patch yet, I hopefully will do so during the coming
week-end. I'll probably have some comments and suggestions on it, so
you'll have a chance to update the revision checks when submitting the
final revision of your patch.

I would also like to document the revision letter vs. revision number for
these ITE chips. This should help people (and us) understand which chip
has what kind of auto-PWM implementation. Can you please visually check
the revision letter of both chips you have (it's mentioned on the top
marking) and give the value of the ID register? I'll do the same on my
two chips, if we can gather a few more we should have an almost complete
list.

Thanks,
--
Jean Delvare

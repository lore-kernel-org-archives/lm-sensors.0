From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 12 Feb 2011 03:45:16 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <20110212034516.GA6734@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 11, 2011 at 10:09:23PM -0500, Andrew Lutomirski wrote:
> On Fri, Feb 11, 2011 at 12:20 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > Some of the chips supported by this driver have 13 bit or 16 bit fan count
> > registers. This patch improves support for those registers, specifically for
> > NCT6775F. With the changes in this patch, fan speed is reported correctly even
> > if the fan divider is set to a low value, which results in a fan speed reading
> > above 0xff.
> 
> I'm not convinced this works.  I have an NCT6775F (or at least the
> driver says I do) and, with fan2_min = 0 or 100, I get fan2_div = 128.
>  If I set fan2_min00, I get fan2_div = 8 but fan2_input reads 0.
> Presumably a low divider should have worked if I really had 16 bits to
> play with.
> 
Yes, you are right. Can you dump the raw contents of the registers at 0x28..0x2a
as well as 0x630..0x637 ?

According to the datasheet, register 0x28 and 0x631 should match, 0x29 should
match 0x633, 0x2a should match 0x635, and 0x3f should match 0x637.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

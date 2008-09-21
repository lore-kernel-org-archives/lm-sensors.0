From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Sep 2008 14:56:41 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20080921165641.118d2146@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

On Thu, 18 Sep 2008 16:58:23 -0700, Anthony Arobone wrote:
> I apologize if this was already brought up on the list.
> 
> I just purchased an Intel DG45FC mini-itx board (I believe this is
> considered ICH10, or some variation).  I can't seem to get lm_sensors to
> report the temps/fans/volts of the board.  Everything is zero.  The cpu
> temps are working via the coretemp module, but nothing else.  Here is what
> I'm doing:
> 
> Gentoo 2.6.26-r1 kernel; using i2c-i801 as module, lm85 as module.
> SVN lm_sensors as of maybe a week ago, just the apps
> 
> When I run sensors-detect it tells me I should be using lm85.  I modprobe
> lm85 successfully but when I run sensors everything is zero.

Can you please provide the complete output of sensors-detect?

When you say "everything is 0", do you mean that nothing is displayed,
or many lines are displayed but all values are 0? In the latter case,
that would be the same problem as reported there:
http://www.lm-sensors.org/ticket/2182
I have no clue what is causing this, sorry.

> Is this the correct module for this board?  I can't seem to find any info
> about the chip/sensor on board.

In general we don't know which board has what sensor chip. There are
simply too many boards out there to keep track. sensors-detect should
tell you. Or look into the vendor-provided documentation. Or try to
take a physical look at the board (not easy in your case, the LM85 is
relatively small.)

> You probably want to see the output of lspci -v but I don't have the board
> hooked up right now, will hookup this weekend.  What I can tell you is that
> the device id is "3a30" from the lspci output.  And the chipset is the G45.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

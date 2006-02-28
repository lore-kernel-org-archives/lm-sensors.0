From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Feb 2006 15:40:44 +0000
Subject: [lm-sensors] 2.6.15.1 Kernel patch for hardware monitoring
Message-Id: <HtFhS5U8.1141141244.2970740.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602272321260.3095@Laila>
In-Reply-To: <Pine.LNX.4.63.0602272321260.3095@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Hartmut,

On 2006-02-28, Hartmut Rick wrote:
> Otherwise I think I've included all your comments and suggestions.
> The patch for 2.6.15.1 kernel is attached to this email.

I've just read the datasheet and noticed a few things which your driver
may not always be handling properly. Please comment on the following
points, and update your driver code where needs be.

1* The LPC47M192 chip has two sampling modes, which can be selected using
the bit 1 of register 0x4F. Currently your driver leaves the chip in the
mode in which it was found. However, given that we do not allow the user
to refresh the data more often than every 1.5 second, wouldn't it make
sense to switch the device to "cycle mode" so as to save some power?

2* Bit 4 of register 0x4F may be used to make the second offset register
(0x1F) apply to the internal temperature channel rather than the first
external channel. If an external source (e.g. the BIOS) did this, then
your driver will misbehave with regards to this offset register. A
simple fix would be to create either temp1_offset or temp2_offset
depending on the value of this bit.

3* The datasheet suggests that limits are left uninitialized at power-up.
If so, your device initialization sequence should set the limits to sane
values before it enables monitoring. By "sane", I mean register values
of 0x00 for low limits and 0xff for high limits. The idea is to prevent
random alarms from triggering on driver load. User-space tools may then
be used to set more useful limit values.

If you happen not to need to start monitoring during the initialization
step (i.e. the chip is already running) then you should not write the
limit values to the registers so as to preserve the previous settings
(possibly set by the BIOS.)

Thanks,
--
Jean Delvare


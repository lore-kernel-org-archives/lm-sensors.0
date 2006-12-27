From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Dec 2006 10:49:55 +0000
Subject: [lm-sensors] PC87427 support timeline?
Message-Id: <20061227114955.8be96ae0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4586C964.1090103@seltec.ab.ca>
In-Reply-To: <4586C964.1090103@seltec.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

On Mon, 18 Dec 2006 10:01:24 -0700, Jonathan deBoer wrote:
> I have a server that uses the PC87427 chip for fan monitoring and 
> control. While I have applied the patch provided on your website for fan 
> speed monitoring, it does not allow for fan speed control. This machine 
> is extremely loud. Is there any way to turn down the fans? (They are 
> currently running at full speed all the time, and there is absolutely no 
> need.)

Depends on your motherboard. The PC87427 has fan speed control
capabilities, but it needs to have been properly wired on your
motherboard for you to possibly take advantage of it.

> Is there a possible timeline for full support for this chip?

No timeline. The PC87427 is a rather uncommon chip, we don't have many
requests, which means it is low priority for us.

> I am willing to use this machine as a test platform for driver 
> development, if needed, as the machine is not mission critical (yet).

Thanks for the proposal. First of all you will want to make sure that
your board is properly wired. Check the motherboard documentation for
hints. Then we can try writing to a couple registers and see what
happens. I can help you with that, if you tell me the base I/O address
of the FSC unit on your system:
  modprobe pc87427
  grep pc87427 /proc/ioports
If we succeed in changing the fan speeds by writing to the registers
manually, then it will be worth extending the pc87427 driver to
implement this feature.

That being said, as I underlined above, this is low priority for us, so
we (which in practice would be me) are not going to work on this right
now just because you need it. If this is important and/or urgent for
you, you should consider helping the project, by either funding the
development, or donating some hardware.

-- 
Jean Delvare


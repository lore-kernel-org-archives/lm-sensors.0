From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Mon, 05 Dec 2005 18:41:14 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051205184114.GC29612@dnil.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 05, 2005 at 06:14:27PM +0800, Ymu at Winbond.com.tw wrote:
> Hi Rudolf, Daniel,
> 
> I have gone through the topic just now, sorry I have no much idea about
> it :(

Yuan,

I appreciate any help you can offer on this matter, it seems hard to
solve without further knownledge about the hardware.

Is there a chance that you have test hardware available with the
w83792d chip where you could try to run the same commands that I did?

First of all, what does a dump look like in your case?

i2cdump -y 0 0x2c

Then, what happens if you try to reset the EN_SMI bit?

i2cset -y 0 0x2c 0x40 0x1
i2cdump -y 0 0x2c

Finally, what happens if you re-init the chip?

i2cset -y 0 0x2c 0x40 0x80
i2cdump -y 0 0x2c

On my system, the bus number is 0 and the address is 0x2c so you
probably need to adjust those to match your setup...


> The mail has been sent to HW engineers and asks them if there is newer
> datasheet.

Great, thanks. We'll be looking for that datasheet.

Best Regards
Daniel Nilsson


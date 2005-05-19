From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <20041023224757.11e71cd5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <416FDE52.2040804@liv.ac.uk>
In-Reply-To: <416FDE52.2040804@liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I am out of ideas as far as investigation is concerned. Our only hope
> is with Tyan. Since you own a significant number of these boards, I
> think that they owe you some support, don't you think? Please contact
> them, expose your problem, and ask them for a sample lm_sensors
> configuration file for this board. Since they were able to produce a
> sample output, they must have had a configuration file back then.

Thanks to Rudolf Marek, we now know what the BIOS is doing. It simply
adds 22 to temp2 and temp3 before it displays them. I guess this is to
compensate for a different thermal diode model.

So all you need to do is:
compute temp2 @+22, @-22
compute temp3 @+22, @-22

And you should optain the same results as in the BIOS setup screen.

The fact that you were finding different formulas isn't really
surprising. Since CPU activity is very different between BIOS and Linux,
temperatures have no reason to be similar.

I'll update and close the ticket.

-- 
Jean Delvare
http://khali.linux-fr.org/

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 01 Apr 2006 16:10:51 +0000
Subject: [lm-sensors] W83793G Chip support
Message-Id: <442EA60B.6020404@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ymu at Winbond.com.tw wrote:
> Hi,
> I got a w83793G chip, and my boss asks me to start to code the driver.
> Good news is I have connected the chip to one of my MB :)
> And I would like to send the datasheet to you first.
>


Good thanks. I just went through the datasheet and got some remarks:

1) this design looks more clean to me
2) good would be to hyperlink the register names and vaules with the description
3) cool is that they really implemented WINB ID and CHIP in ALL banks
4) I spotted two new technology stuff AMDSI and PESI

THe new register set leads to a conclusion that best would be to start
new driver from scratch instead of putting stuff into the w83792d.

I will take care of watchdog because it seems same to me as in the w83792d.

I'm trying to think out the best how to connect the watchdog driver core
with rest of the w83792, because two different drivers cannot be assigned to
just one i2c addr. I think I will create separate module to support 92/93
and create some callbacks to respective drivers or vice versa.

To new driver developement. If you have any questions/problems/ideas whatever
please post them to the mailing list. I prepared to help you for sure :)

Regards
Rudolf


From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Mon, 03 Apr 2006 01:11:21 +0000
Subject: [lm-sensors] W83793G Chip support
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE0100E6AE@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <442EA60B.6020404@sh.cvut.cz>
In-Reply-To: <442EA60B.6020404@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
> > I got a w83793G chip, and my boss asks me to start to code the
driver.
> > Good news is I have connected the chip to one of my MB :)
> > And I would like to send the datasheet to you first.
> >
> 
> 
> Good thanks. I just went through the datasheet and got some remarks:
> 
> 1) this design looks more clean to me
> 2) good would be to hyperlink the register names and vaules with the
description
> 3) cool is that they really implemented WINB ID and CHIP in ALL banks
OK :)

> 4) I spotted two new technology stuff AMDSI and PESI
> 
> THe new register set leads to a conclusion that best would be to start
> new driver from scratch instead of putting stuff into the w83792d.
> 
I think so too, I have done some register definition before get the chip
and will check if they changed some registers first.
> I will take care of watchdog because it seems same to me as in the
w83792d.
> 
> I'm trying to think out the best how to connect the watchdog driver
core
> with rest of the w83792, because two different drivers cannot be
assigned to
> just one i2c addr. I think I will create separate module to support
92/93
> and create some callbacks to respective drivers or vice versa.
> 
Hmm, what about w83627hf watchdog driver; which way does it use?
> To new driver developement. If you have any questions/problems/ideas
whatever
> please post them to the mailing list. I prepared to help you for sure
:)

You are so kind, thank you in advance ;)

Best Regards
Yuan Mu




=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.


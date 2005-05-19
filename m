From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503242241430.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Thanks for the logs it helped a lot. I have a reconstruction of "crime"
scene.

Our driver infrastructure starts with probes with I2C_QUICK stuff.
As I wrote in previous mail it is like knocking on the door if someone
(chip) will respond.

First address is 0x2C which is probed. Nothing is there so we get
0x44 back.

0x4 => Device Error (correct)
=> no bit 0x80 set
0x40 => SMM code tries to recover and makes some kill transaction ???

Our driver signals transaction never finished => it is correct.

Address was probed but nothing is there. BUT
Driver returns 0, so there IS someting (for the i2c-core)
Next attepmt is from 792.c detection routine to read smth. It reads 0,
so this is not our chip. detection failed from your 792.c driver.

Next address is 0x2F which is working, still bit 6 is set. Maybe it can be
cleared somehow? ANd when it is clear we might get back "DONE" bit
asserting correctly???

Return value is 0x42. Unfortunately I dont know what bit 1 is doing.
No BAD bits are set => clean return.

Previous driver would not work because it was testing bit 7. It failed
and reseted the bus and it got "stucked" and it was before it could prove
with write quick on 0x2f is something.


                !(data & HST_STS_DONE) ? "Transaction Never Finished " :
"");

    //    if (!(data & HST_STS_DONE))
      //          /* Issue 'kill' to host controller */
      //          outb_p(HST_CNTL2_KILL,SMB_HST_CNTL2);
     //   else
     //           /* Issue timeout to reset all devices on bus */
     //           outb_p(HST_CNTL1_TIMEOUT,SMB_HST_CNTL1);
        return -1;

My qustion is: Will it work with above code? I think it should. Please
can you provide some logs with this?

> According to our 792 Windows driver author CLHuang2 and the information from
> ALI M1563 data sheet, it seems that we should move the HST_STS_DONE check from
> ali1563_transaction() into the function ali1563_access(), only when the
> transaction is Block Read/Write, and ignore the Byte Read/Write transaction.
> Patrick, would you please confirm it?

I studied also some other datasheets and it seems it is working for
classics reads too. This driver was working for people so it must work
this way.

Thanks,

Regards

Rudolf

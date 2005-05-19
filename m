From: bjorn@mork.no (=?iso-8859-1?q?Bj=F8rn_Mork?=)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: SOLVED: Ticket #1409
Message-Id: <hv8yo2wjvt.fsf@rasputin.ws.nextra.no>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark Studebaker <mds@paradyne.com> writes:

> We already have similar super i/o detection in sensors-detect
> and in 3 drivers: vt1211, smsc47m1, and w83627hf.
> There's also super i/o detection in sensors-detect for the it8705, 

ah, right, so it is.  Embarrassing.  I should have noticed.

> but it is commented out because the "exit" value is different than
> for other chips and I didn't want to leave other chips stuck in PnP
> mode

This is somewhat icky, but I believe it wouldn't matter much if you
wrote an extra 0xaa to 0x2e either before or after exiting the ITE
way.  The ITE chips shouldn't mind since you either address a
non-existing register or have already left config mode.

> (although I wonder if your 8712 gets stuck in PnP mode when running
> sensors-detect??).

Hmm, I don't think it will unless you write the exact magic key
sequence and you don't do that.  Let me just test.  This should fail
unless the chip is in config mode: 

#include <sys/io.h> 
int main() {
    if (!ioperm(0x2e, 2, 1)) {
        outb(0x20, 0x2e);
        printf("chip id = 0x%02x", inb(0x2f));
        outb(0x21, 0x2e);
        printf("%02x\n", inb(0x2f));

        return 0;
    }
}

And it fails after running sensors-detect as expected.  No problem.  

Since sensors-detect always writes 0xaa to 0x2e after a failed superIO
probe, the ITE chips will never get stuck in config mode unless there
is some other chip using the exact same magic key with another exit
sequence. I tried with this possible sequence:

 0x87,0x87,0x20,0xaa,0x01,0x55,0x55

which does *not* bring the IT8712F into config mode. 


> If you port over the super i/o code from one of the 3 drivers listed
> above
> and send us a patch we'll include it.

OK.  Will do.


Bj?rn

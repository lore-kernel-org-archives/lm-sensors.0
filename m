From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 26 Aug 2005 04:50:35 +0000
Subject: [lm-sensors] Support for PIC16F873A
Message-Id: <20050826025020.GA21355@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <f3cea02305082519281cf8fb4@mail.gmail.com>
In-Reply-To: <f3cea02305082519281cf8fb4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Shiju Mathew <mshiju@gmail.com> [2005-08-26 11:28:06 +0900]:
> Hello,
> I have a PC with PIC16F873A. A few buttons(brought out of the system)
> are connected to this controller. I want to get the status of the
> button press by reading its status from the controller. So I would
> like to know whether the controller PIC16F873A is suppported by
> lm-sensor. The controller is connected via SMbus. THe system is based
> on intel processor.

The PIC16F873A (like any PIC16F...) is not a sensors chip, it is a general
purpose microcontroller.  It would be impossible for lm-sensors to support
it without knowing something about the code that is programmed into it.

If you could find out which I2C/SMBus commands will get the button status,
then it could be supported.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


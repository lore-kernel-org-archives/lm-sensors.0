From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Question for ALI about M1563 smbus transfer mode
Message-Id: <Pine.LNX.4.58.0504082204540.2186@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please can you forward my question to ALI/ULI?  (maybe strip my name, so
it seems it comes from you directly :) Please take a look to your
datasheet first If it is written there or not, but I think it is not,
because simply commands belong usually to command register :)

Question:

We are implementing the driver for M1563 SMBus host and we ran into some
trouble. We have implemented in our SMBUS driver the "continous byte mode"
SMB_CMD 001, in all other chipsets it seems command belong to CMD
register, but this mode accepts command in DAT0 register. Is this
undocumented feature or a "silicon" bug?

Can you tell us if this is true also for M1535, M1541 and M1543C ?

Thanks

Regards

Rudolf

From: gardner.ben@gmail.com (Ben Gardner)
Date: Tue, 20 Dec 2005 22:37:58 +0000
Subject: [lm-sensors] [PATCH 2/7] i2c: scx200_acb - debug log cleanup
Message-Id: <808c8e9d0512201437h65bf3f74udf9dca453b98aec3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191051u6f7c0b38k2c9843a6baed00bf@mail.gmail.com>
In-Reply-To: <808c8e9d0512191051u6f7c0b38k2c9843a6baed00bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 12/20/05, Jean Delvare <khali at linux-fr.org> wrote:
> (...)
> This state machine looks rather strange to me, I don't think I ever saw
> an i2c bus driver implemented that way.

Yeah, I think the driver may have been better implemented using the
'emulated' (i2c_transfer) method.  The hardware supplies all the
basics: start, stop, stall, write address, write & read byte.  All the
SMBus stuff has to be emulated anyway.

Ben


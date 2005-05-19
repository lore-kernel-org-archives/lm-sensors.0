From: od@fet.uni-hannover.de (Oliver Dawid)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Trying to find device chrontel 7009
Message-Id: <200311052353.11564.od@fet.uni-hannover.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031105203334.6eab5b78.khali@linux-fr.org>
In-Reply-To: <20031105203334.6eab5b78.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi JEan,

On Wednesday 05 November 2003 22:22, you wrote:

> Yes, that's somewhat similar to I2C, but the datasheets shows that the
> data bus is 12-bit wide, while I2C's is 1-bit only. I even wonder how
> they can call that a serial bus. Anyway, that's what made me say it's
> not an I2C chip (plus the fact that searching the data sheet for I2C or
> SMBus returned nothing).

What you meant is the data bus for video data transmission. control interface 
is a two wire synchronous serial connection. It's just a very simple bitshift 
module driven by external clock (SPC and SPD pin 14, 15).

> > Sorry that I wasted so much time of you,
>
> No problem. Good luck :)

Thanks. Now I get an idea, why there is no information about i845 in 
combination with chrontel 7009 concerning linux.

Bye,
od

-- 
od@fli4l.de * http://www.fli4l.de/ * the on(e) disk router

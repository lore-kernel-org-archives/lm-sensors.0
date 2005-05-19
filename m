From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: ATI i2c bus driver
Message-Id: <Pine.LNX.4.53.0401070100470.27769@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040102115144.219b5579.khali@linux-fr.org>
In-Reply-To: <20040102115144.219b5579.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 6 Jan 2004, Jean Delvare wrote:

> OK, I got some code from the Gatos project. I took i2c-savage4 and
> edited it in accordance with what I found there, but I can't get it to
> work. If anyone could take a look and tell me where I'm wrong...

The GPIO pins could be bidirectional, but one way at a time. Meaning,
the read value _GPIO_Y_0 is not valid when _GPIO_EN_0 is set.

Also, I did not find _GPIO_A_0 (nor _1) initialised to 0 in your code.
I believe this is the value ( 0 = pull low, 1 = hi-Z ) when _GPIO_EN_0
is set. Makes sense with the inverted setscl&sda.

Did you try without bit_test? You might need some <1 us delay between
read and write to see the change, the bus has some capacitance even
without monitor cable.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>

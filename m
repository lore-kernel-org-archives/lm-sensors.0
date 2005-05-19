From: zoleg@matrixc.ru (ZOleg Matrix)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: LM83 driver
Message-Id: <521123109.20030724093744@matrixc.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Thursday, July 24, 2003, 1:09:58 AM, you wrote:


JD> Hi Zoleg,

JD> Three weeks ago, you requested a driver for the LM83 you say you had on
JD> your motherboard. I wrote the driver and told you about it, but we never
JD> heard about you again. Why that? It's not very polite to you to make me
JD> work for you and ignore me once the job is done...

JD> Nevermind, I would need your help now. First I would like you to try the
JD> driver. It's included in our latest release (2.8.0), or you can use CVS
JD> for a slightly improved version. I'd really like to know if the chip is
JD> detected by our sensors-detect script, and how the driver behaves.

JD> Second, I would like you to unload the lm83 driver (rmmod lm83) and dump
JD> the contents of your LM83 chip. You will need to find at which address
JD> it is located (sensors-detect should tell you) and run the following
JD> command:
JD>   i2cdump 0 0x18
JD> (replace 18 with the address given by sensors-detect; if the chip is
JD> located on a second I2C bus, replace 0 with 1).

JD> Thanks.


Excuse that did not leave on communication, but I was sick and have just come to work.
Today I shall try to test the new version of the driver and to send you results.

-- 
Best regards,
 ZOleg                            mailto:zoleg@matrixc.ru

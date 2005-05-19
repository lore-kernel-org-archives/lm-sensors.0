From: sjhill@realitydiluted.com (Steven J. Hill)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: New patches of 2.8.0 against 2.4.22...
Message-Id: <3F5FD992.9050001@realitydiluted.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F526E97.7010906@realitydiluted.com>
In-Reply-To: <3F526E97.7010906@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> The first one is that your patch doesn't add the operations on the new
> owner field of the i2c_adapter structure. That's something you'd have to
> fix since that's how module usage count is now achieved.
> 
I haven't looked at this in detail. I'll probably have more questions
later on that.

> The second one is in Config.in. For CONFIG_SCx200_I2C, you added a
> dependency on CONFIG_SCx200_GPIO, while I *replaced* the dependency on
> CONFIG_SCx200 by one on CONFIG_SCx200_GPIO. While both are OK, my
> solution is faster since CONFIG_SCx200_GPIO itself depends on
> CONFIG_SCx200 (and I'm not even sure CONFIG_SCx200_I2C depends on
> CONFIG_SCx200 itself at all). So, unless you there's a policy I'm not
> aware of for that kind of cases, I invite you to do as I do.
> 
> The third and last one, still in Config.in, is that I replaced the
> dependency on CONFIG_I2C by one on CONFIG_I2C_ALGOBIT for
> CONFIG_SCx200_ACB. I just checked why I did that, and I believe it is
> simply because CONFIG_SCx200_ACB is inside the 'if [
> "$CONFIG_I2C_ALGOBIT" != "n" ]' block. After reading the code again, it
> looks like it should *not* be (it doesn't use i2c-algo-bit), so my fix
> is wrong. The right thing to do is probably to move that line out of the
> 'if [ "$CONFIG_I2C_ALGOBIT" != "n" ]' block (and keep the dependencies
> the way they are, since they seem to be correct).
> 
The stuff I did was due to linking errors associated with the SCx200
drivers when compiling everything in statically and also header file
dependency problems. I am happy with your suggestions as long as
testing is done with both statically linking and as modules. I do
not have any SCx200 devices, so I just guessed at the dependencies.

-Steve

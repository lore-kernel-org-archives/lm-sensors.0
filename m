From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: New patches of 2.8.0 against 2.4.22...
Message-Id: <20030907170612.7a97c8f9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F526E97.7010906@realitydiluted.com>
In-Reply-To: <3F526E97.7010906@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Please take a look at the SCx200 patch as it fixes some
> compile dependencies. Thanks.

Hi Steve,

There are a few differences between your patch and mine WRT the SCx200
driver(s).

The first one is that your patch doesn't add the operations on the new
owner field of the i2c_adapter structure. That's something you'd have to
fix since that's how module usage count is now achieved.

The second one is in Config.in. For CONFIG_SCx200_I2C, you added a
dependency on CONFIG_SCx200_GPIO, while I *replaced* the dependency on
CONFIG_SCx200 by one on CONFIG_SCx200_GPIO. While both are OK, my
solution is faster since CONFIG_SCx200_GPIO itself depends on
CONFIG_SCx200 (and I'm not even sure CONFIG_SCx200_I2C depends on
CONFIG_SCx200 itself at all). So, unless you there's a policy I'm not
aware of for that kind of cases, I invite you to do as I do.

The third and last one, still in Config.in, is that I replaced the
dependency on CONFIG_I2C by one on CONFIG_I2C_ALGOBIT for
CONFIG_SCx200_ACB. I just checked why I did that, and I believe it is
simply because CONFIG_SCx200_ACB is inside the 'if [
"$CONFIG_I2C_ALGOBIT" != "n" ]' block. After reading the code again, it
looks like it should *not* be (it doesn't use i2c-algo-bit), so my fix
is wrong. The right thing to do is probably to move that line out of the
'if [ "$CONFIG_I2C_ALGOBIT" != "n" ]' block (and keep the dependencies
the way they are, since they seem to be correct).

What do you think ?

Thanks for your help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

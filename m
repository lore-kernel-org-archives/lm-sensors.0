From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: I2C chip driver functionality check -- help?
Message-Id: <20040217211542.78593268.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402171249.i1HCnJQ29795@sfendt.octagonsystems.com>
In-Reply-To: <200402171249.i1HCnJQ29795@sfendt.octagonsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry if this is a repeat, but I have not seen any response, and I'm
> not sure the message got to the list, and this is the last remaining
> issue for my linux package.  So just in case it did not...

In doubt, you can check the mailing-list archive:
http://archives.andrew.net.au/lm-sensors/

(Your previous post is here:
http://archives.andrew.net.au/lm-sensors/msg06465.html)

> A simple (I hope) question:
> Why doesn't bit_func() in i2c-algo-bit.c not return with the
> I2C_FUNC_I2C bit set?
> 
> My chip driver needs to use i2c_master_send() and i2c_master_recv(),
> and I cant' find any other functionality bit that makes sense. ?If I
> skip the functionality check, it seems to work. ?Did I miss something
> in the documentation, that is am I checking for the wrong
> functionality bit(s)?

I don't know (which is why I didn't answer in the first place, mind
you). All I know is that this list of bits returned by
i2c-algo-bit:bit_func has been reduced in Linux 2.6. This means that
someone took a look and corrected the list to make it better, and did
not include I2C_FUNC_I2C. This make me guess that this person knew what
he/she was doing.

Maybe what you need to check is the I2C_FUNC_SMBUS_EMUL bit. But I don't
know much more than you on the subject, so I'm just guessing.

Anyway, if bypassing the test make it work for you, I wouldn't bother
much.

Sorry I cannot help you more.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

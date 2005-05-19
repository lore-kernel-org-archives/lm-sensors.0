From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Possible incorrectness in w83627hf.c
Message-Id: <20040212194619.40fc8495.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MDS,

Here is an excerpt from w83627hf.c:

if (type != w83697hf) {
	/* enable PWM2 control (can't hurt since PWM reg
           should have been reset to 0xff) */
	w83627hf_write_value(client, W83781D_REG_PWMCLK12, 0x19);
}

According to the data sheets, this register (0x5C) does only have a
meaning for the W83627HF. So I'd suggest changing the condition to "type
= w83627hf" so that we don't access that register on the W83627THF (and
possibly others such as the W83637HF, which I plan to add support for).

And, as we come to speak about this, I don't frankly see the point in
writing anything to this register. You seem to try and write the default
value anyway (and possibly change the value of reserved bits BTW, which
is no good). Can't we simply get rid of that write?

BTW, if someone could tell me what these "PWM clock frequencies" are
meant for... The data sheet don't seem to explain it at all.

Thanks.

PS: Looks like this driver would benefit a massive refresh. The
references to w83781d everywhere make things hard to understand
sometimes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

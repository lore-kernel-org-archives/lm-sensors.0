From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-matroxfb
Message-Id: <20030718150958.2c61dd8a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710182523.4ceef8fa.khali@linux-fr.org>
In-Reply-To: <20030710182523.4ceef8fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I will lead the same kind of experiments on the rivatv module, since
> it does the same as i2c-matroxfb. If the conclusions are different, it
> means that there is something to fix in the i2c-matroxfb driver. If
> the conclusions are the same, it means that we could consider doing
> the bit_test=1 for i2c-algo-bit the default. I don't know if it can
> have side effects. Well, I see at least one, which is that the test is
> made at the time the client module is loaded. So if the user loads the
> module at a time he/she has no compliant monitor, and changes that
> afterwards, he/she will still have his/her I2C bus disabled. I doubt
> it is a major issue, this isn't the kind of thing that is likely to
> happen very often.

OK, I did the test and the result is similar. The complete i2cdetect
shows an average 0.8s for each address scanned. And they set their
timeout to 10. So it is 10 times faster than the i2c-matroxfb, with a 10
times lower timeout. Bingo! That's still not what I would have expected.
The time per address is eight times higher than the timeout value. Why
that? Is the unit different from what I think it is? Or does the timeout
occur eight times for each address? *That* would be stupid and probably
worth fixing.

So what now? Maybe we could set a the same timeout value of 10 (or
HZ/10) in the i2c-matroxfb module? It sill will be slow...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

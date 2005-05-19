From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Kill another macro abuse in via686a
Message-Id: <Eo6YyBBE.1116402774.1330280.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050517223857.531710cd.khali@linux-fr.org>
In-Reply-To: <20050517223857.531710cd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Can I go kill some macros too?  Silly conversion macros, make like
> adm9240? Was planning to put SCALING() in with SENSORS_LIMIT() in
> the header somewhere, as those two static functions can be used for
> most of the scaling conversions.

Macros that do not actually improve the code readability are candidates
to removal, as they additionally slow down the preprocessing. Removing
macros is not a goal per se though, most of them are actually helpful.

> As well, do something with the LM75 include, I see now I duplicated
> some of the code there, with exception that I right justify signed
> 9-bit temp on read to local store, rather than on delivery to sysfs.

If you can refactor some code with no side effect, this is welcome.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

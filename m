From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <20040102140226.0750e14d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Don't forget to CC: the mailing-list on replies]

> I think the bt869 for 2.6 should be OK so far, but I don't know how
> I can compile it standalone and so I couldn't test it. Where do I
> have to put it and what are the gcc-paramters I have to use?

I don't know. I'd suggest you copy your source file in
linux/drivers/i2c/chips, and edit linux/drivers/i2c/chips/Makefile (add
a line like "obj-m += bt869.o"). Then configure a fake kernel with as
least options as possible (but don't forget to at least enable
i2c-core). Then compile your kernel and see what happens.

That doesn't look very immediate nor professional, I admit, but that's
how I do and it works ;) If anyone has a better way of testing new
drivers, let us know.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

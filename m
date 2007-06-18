From: linux@horizon.com
Date: Mon, 18 Jun 2007 17:26:04 +0000
Subject: Re: [lm-sensors] Is it possible to raise the abituguru voltage test
Message-Id: <20070618172604.14110.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613121553.17775.qmail@science.horizon.com>
In-Reply-To: <20070613121553.17775.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> That case already gets caught by the first check:
>	if ((val < 10u) || (val > 250u)) {
>
> You remove this check, because with having both voltage checks variants it 
> isn't needed, I kept it because if a reading is THAT close to the absolutely 
> min / max reading possible, something is wrong.

Oh!  Sorry, I missed that.  I allowed any voltage, so I was looking for
the check between the voltage and temperature tests, and it wasn't
there.

> My (tested and working) variant is enclosed.  Note the "temp too low
> to test" condition you don't have.  Another version is coming next e-mail.

> Thanks but no thanks, I'll stick with my minimal changes version. It
> took me many days of debugging and back and forward mails with testers
> to get code that works everywhere (except appearantly your mobo).

Well, the code works, my mobo just uses it close to the limits by
running a 3.3V input into a 3.5V Vref ADC.

> I've also seen your do both tests in one go version, its clever, but it's
> also definitively programming the "chip" outside its specs; the 2 flags
> should normally never be set at the same time. So thanks but no thanks.

Okay.  Is it worth asking about the poll-every-10-ms option?  It's a
fairly minor change, and does speed up initialization.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <Pine.LNX.4.53.0401031322190.27769@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 3 Jan 2004, Jean Delvare wrote:

> > 1503 - i2c_get_client() function in 2.4 kernels - Khali?
>
> #1503 is for Ky?sti. He said that i2c_get_client was broken (locking
> issue IIRC) and would need fixing. BTW, what's that function supposed
> to do and how can we possibly not use it at all while a few external
> drivers do? (just curious)

( Has been too long, don't recall ticket access pw. )

It returns a client structure with a specified driver and/or behind a
specified adapter ID. Yes, missing locks there. More importantly,
i2c_get_client cannot work properly if there are several adapters
of the same type. Seems we have to bring it back in among other planned
compatibility changes.

Just don't expect i2c_get_client to reappear in its current form in 2.6
kernels. The function is not needed if the adapter code implemented
client_register callback.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>

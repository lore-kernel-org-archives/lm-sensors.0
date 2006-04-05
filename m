From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 05 Apr 2006 08:42:32 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new vt1211 driver
Message-Id: <443382F8.3030709@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
In-Reply-To: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Sorry for delay.

> hmm... libsensor currently supports this interface. Is it deprecated?
> Using i2c to change it would be OK I guess, except that the driver
> itself doesn't need i2c anymore (it's platform) and the user would
> have to compile i2c just for this (if required, that is).

I had isaset in mind. Sorry for confusion.

> How about using a module load parameter instead?

Yes that would be cleanest solution.

Regards
Rudolf


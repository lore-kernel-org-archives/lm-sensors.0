From: Sandeep <sandy.8925@gmail.com>
Date: Sun, 23 Feb 2020 16:41:10 +0000
Subject: ignore setting in sensors.conf only works with lowercase arguments
Message-Id: <CAGPDPzCctbDzVm1WsiZeN-ObkMUt76hJSbC3EnQ5nadnZTTjzw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

There are some sensor inputs such as "CPUTIN" for my motherboard's
sensor chip, which have a default bogus value. I attempted to use an
ignore line in sensors.conf to block this entry, but noticed that it
didn't work.

I tried using ignore for a different lowercase label (e.g "fan1" ) and
it was ignored as expected.

It seems that ignore assumes that the argument will be lowercase only,
and refuses to work otherwise. Even if I use "ignore cputin" it
doesn't work.

Can you please fix this?

Yours sincerely,
Sandeep

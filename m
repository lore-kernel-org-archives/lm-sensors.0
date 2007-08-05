From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sun, 05 Aug 2007 19:56:27 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <4dfa50520708051256m6f1b085en13c7379cf2f9adf4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>
In-Reply-To: <46B5B290.4040907@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan, Mark,

Mark M. Hoffman wrote:
> It's more likely the patch before that:
>
>       hwmon/w83627ehf: Preserve speed reading when changing fan min

Without testing, I think Mark is correct here. I am traveling right
now and so I do not have a w83627ehf chip to test with.

The git bisection results should find the bug.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

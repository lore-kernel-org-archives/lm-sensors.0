From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: Ticket 1382 : Update
Message-Id: <1063461911.6452.46.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

On Sun, 2003-09-07 at 17:31, Jean Delvare wrote:
> VIA chipsets have an overall bad reputation (network adapters and
> motherboards alike) for sure.

I noticed that there's a linear fit in the via686a.c, in the temp
conversion section, in the remarks.
The way I understand it, the linear fit is actually valid within a short
range of temperatures, while the 5th degree polynomial is actually more
accurate for the whole range.
The thing is, since I'm clueless at C, I don't know if the readings
output by sensors when questioning the via686a are processed with any of
these fits.
I tried applying the linear fit in the common temp range (temp = val x
0.427 + 32.08) in gkrellm, and behold! the readings *look* better.
Now, I don't know if it's just a coincidence, or if it's actually the
way it should work.
I'd really appreciate your comments on that one.

Thanks,
Romain


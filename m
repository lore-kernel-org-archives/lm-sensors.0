From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <20050417151713.54caf49b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Having to explain this to each other improves my understanding.

That's exactly how things are supposed to work. It improved my
understanding as well. My w83627ehf implementation was broken, now it's
better.

If you browse the mailing-list archive, you'll find that I started
working on automatic clock divider long ago. My first implementation was
bad. It improved over time, thanks to the feedback of various people,
including you, to become what the w83627ehf has.

> Hope you not too annoyed with me :)

To say the truth, well yes, a little bit at times. This happens, no need
to worry. You have the energy of the newcomer. I have the experience of
the user support. No surprise we don't see everything the same way.

> Something has to take a hit, and fan limit resolution is it, I've 
> already dropped the chop point from 192 down to 128, then check 
> if fan > 192 and do one adjustment in the set_fan_min.

What exactly are you trying to achieve? 192 seemed to be a good
equilibrium between range margin and resolution.

> Rest of adjustment in measurement side, not bidirectional until we
> see a need?

Absolutely. Note that this guarantees a "stable" divider, while
bidirectional could result in endless divider change, which I would like
to avoid, because divider change is somewhat expensive.

Thanks,
-- 
Jean Delvare

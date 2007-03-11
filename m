From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 11 Mar 2007 14:54:18 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <45F4181A.8080101@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,

<stuff about me prefering small increments in 2.10 instead of doing 3.0
  snipped>

> I don't really care, libsensors is more or less Mark's realm, I am busy
> enough with the kernel side of things. As long as we do not duplicate
> the effort in two different branches, I'm fine. Also keep in mind that
> the 2.10.x branch _must_ be stable. We must be able to release a new
> version any time if there's a need, as is the case for 2.10.3. Going
> with a 3.0.x branch makes it possible to make things unstable if it's
> easier that way.

The patches I'm talking about where specificly designed to:
1) Keep backwards compatibility
2) Not change any behaviour for chips already supported. Actually for
    chips already supported the whole code path they introduce is never
    entered.

This minimizing the chance of introducing instability. Also keep in mind 
that a 3.0 branch will not be thoroughly tested by a wide audience until 
released , so that won't help much either.

Anyways lets wait and see what Mark has to say, I've made my preferences 
clear and I will follow whatever Mark decides.

Regards,

Hans



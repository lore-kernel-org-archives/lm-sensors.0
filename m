From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <20040518021540.GB11012@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
In-Reply-To: <20040516222809.2c3d1ea2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-05-16 22:28:09 +0200]:

> This is a RFC about fan clock dividers in hardware monitoring chips.

[snip]

> ### CONCLUSION
> 
> I think I'll stick to #2 for now. The extra code is reasonable, and I
> don't really see the low accuracy at high speed as a problem. What
> matters much to me is that the user shouldn't have to worry about
> selecting dividers himself, and #2 does this.
> 
> Part of the extra code may be moved to i2c_sensor if several drivers use
> it. Also, remember that the new policy will remove some code from the
> drivers (reading and setting dividers manually) so this gives us some
> margin anyway.

The keyword in your conclusion is "policy", which reminds me of the phrase
"mechanism, not policy".  The driver should behave exactly as commanded,
nothing more.  The solution to the fan divisor madness can and should be
done in userspace.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

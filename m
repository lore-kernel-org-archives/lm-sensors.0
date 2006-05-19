From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 19 May 2006 07:47:24 +0000
Subject: [lm-sensors] question about your driver
Message-Id: <20060519094724.d387803b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9d6ab59b0605161158l1352e1a1u631f4869fd9f9db5@mail.gmail.com>
In-Reply-To: <9d6ab59b0605161158l1352e1a1u631f4869fd9f9db5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Santiago,

> Thank you very much for your prompt reply.  Your suggestion that the
> hardware monitor may not be enabled was key. In fact, what was not ebabled
> were the *IO permissions* to the LPC IO window that communicates with the
> Winbond chip.  I think this is a very specific quirk for this board, and
> through reading some of the documentation and code examples for the SC2200,
> I think I figured out how to enable it.  If you'd like to document more
> detail about this, I'll be happy to send you more detail.

Yes please, that would be nice to have this documented, so that other
users of the same board know what's going on and how to fix it. Maybe
you can add a paragraph to Documentation/hwmon/w83627hf, or could the
quirk be added to the driver itself? It depends on what the quirk is,
of course.

Thanks,
-- 
Jean Delvare


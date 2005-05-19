From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: ticket 1415
Message-Id: <20031022015113.GA8764@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F95168B.5040305@yahoo.com.au>
In-Reply-To: <3F95168B.5040305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-10-21 12:53:35 -0400]:
> Well, libsensors is indeed missing some code to support it - but that's as
> far as I got.  I'll try to commit something to CVS tonight.

"It" is w83627thf...

OK, I committed a partial fix - go ahead and try it.  I already see that
sensors doesn't report fan3 (which corresponds to "Power Fan" in P4C800
BIOS.)  I will start another thread on the mailing list about that...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

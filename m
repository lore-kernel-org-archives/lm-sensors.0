From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 21 Dec 2006 13:29:26 +0000
Subject: [lm-sensors] sensors.conf syntax: anyone use escape sequences?
Message-Id: <20061221132926.GD12560@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061112140142.GB8009@jupiter.solarsys.private>
In-Reply-To: <20061112140142.GB8009@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Mark M. Hoffman <mhoffman at lightlink.com> [2006-12-21 07:44:18 -0500]:
> The end-result is that the behavior of the scanner depends on the locale
> setting at _compile-time_ instead of at run-time.  (That's when flex checks
> isalnum() to build its static tables.)  That's just nasty.

As Jean points out on IRC... flex doesn't actually work that way.

Nevermind. ;)

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



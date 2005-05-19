From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: LM93 vccp_limit_type "relative" does not work
Message-Id: <20041019032129.GA18098@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <416EDF3D.7090307@earthlink.net>
In-Reply-To: <416EDF3D.7090307@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

Your patch looks good, but won't apply for some reason.  As Khali mentioned
in another message... please try to fix that and resend.  Thanks!

* David Knierim <david_knierim@earthlink.net> [2004-10-15 17:52:57 -0400]:
> alarming didn't work right, but I figured out what was wrong.   The 
> attached patch fixes it and adds messages if the read retry counts are 
> exceeded.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

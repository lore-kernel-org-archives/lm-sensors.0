From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Mon, 03 Oct 2005 04:15:34 +0000
Subject: [lm-sensors] Re: [lm-sensors-commit] lm_sensors2/lib proc.c
Message-Id: <20051003021500.GA6708@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051002174129.32baee4e.khali@linux-fr.org>
In-Reply-To: <20051002174129.32baee4e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2005-10-02 17:41:29 +0200]:
> > Modified Files:
> > 	proc.c 
> > Log Message:
> > (mmh) A trivial cleanup for getsysname() - there's no reason for matches[]
> > to be an automatic, or non-const.
> 
> What do you mean, "automatic"?

A non-static, local variable.  "Automatic" used as a noun is an abbreviation
for "automatic variable".

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


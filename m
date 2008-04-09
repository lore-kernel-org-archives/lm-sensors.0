From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Apr 2008 15:17:50 +0000
Subject: [lm-sensors] Removing the FAQ from the lm-sensors 3.x SVN branch?
Message-Id: <20080409171750.33636788@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I would like to propose that we remove the FAQ from the lm-sensors 3.x
SVN branch. My motivations are as follows:

* The FAQ is outdated. The FAQ is historically for lm-sensors 2.x, not
3.x, and nobody took the time to update it and clean it up as needed.
Many problems described in the FAQ have been long solved. Everything
that might be an issue these days is missing.

* The FAQ was duplicated to the wiki. We definitely don't want to have
to maintain it twice (especially when we don't seem to be able to
maintain it once to start with...) While the restrictions we have on
the wiki at the moment don't let visitors help us maintaining the FAQ,
one can hope that we will find a solution in the long run, so I'd rather
keep the FAQ in the wiki and delete it from SVN than the other way
around.

* The FAQ takes a significant amount disk space. It represents about
20% of the source package, and 18% of the openSuse sensors package. It
would be OK if that was useful information, but now it looks like
wasted disk space to me.

If anyone objects to me deleting the FAQ from the lm-sensors 3.x branch
in SVN, please speak up.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

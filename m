From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Jul 2007 17:02:02 +0000
Subject: Re: [lm-sensors] Getting rid of LM_DATE
Message-Id: <20070719190202.50515c4c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070703140514.1ec402ae@hyperion.delvare>
In-Reply-To: <20070703140514.1ec402ae@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Jul 2007 22:28:47 +0200, Jean Delvare wrote:
> While doing these cleanups, I noticed that we have a "package" target
> in our Makefile, which seems to be outdated (it still assumes CVS
> instead of SVN). It appears to be redundant with the instructions in
> doc/developers/release_checklist, which _are_ up-to-date. So I suppose
> that Phil uses the checklist for releases and not the package target in
> the Makefile, meaning that the latter could be removed. Any objection?

Done.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

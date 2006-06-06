From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Jun 2006 11:59:12 +0000
Subject: [lm-sensors] [PATCH] libsensors error reports
Message-Id: <20060606135912.45d8b62b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060603112659.f707691c.khali@linux-fr.org>
In-Reply-To: <20060603112659.f707691c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> * Jean Delvare <khali at linux-fr.org> [2006-06-03 11:26:59 +0200]:
> > It seems that libsensors is reporting errors in cases where there are no
> > errors, but simply no sensors were found. This was reported by several
> > confused users in the past few months. I think we should fix this.
> > Proposed patch below, comments welcome. Mark, is this OK with you?
> 
> Yes, that solves it nicely.  Thanks.

Thanks for the review, I've committed it.

-- 
Jean Delvare


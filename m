From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 22:05:33 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <20071008000533.4dc3bd0a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 7 Oct 2007 15:33:01 -0400, Mark M. Hoffman wrote:
> Although, I suppose it would be easier for you and maybe Jean if I just publish
> a patch series myself.  It shouldn't be too hard to script that up; I'll look
> into it.

I don't need it too much, as I am tracking the hwmon patches myself so
my stack and yours are very similar; when I'm missing a patch, I
cherry-pick it from git-web.

But I agree that it would be convenient to have the possibility for
others to get all the patches as either a single patch or a patch
series. For now I have been pointing developers to git-hwmon.patch in
Andrew's tree, but it may become quickly out-of-date if Andrew doesn't
release a new kernel in a while.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

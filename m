From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] sensors-detect and udev
Message-Id: <20040812200311.4152cf8c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040810225714.GA2700@pc.aurel32.lan>
In-Reply-To: <20040810225714.GA2700@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I don't get this:
> > 
> > +  if (-d './dev') {
> It's a typo, I made the patch to quickly. Should be
> if (-d './dev') {

Oh, really? I thought it should instead be:
+ if (-d './dev') {

;)

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

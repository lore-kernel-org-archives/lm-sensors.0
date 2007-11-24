From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Nov 2007 09:31:27 +0000
Subject: Re: [lm-sensors] PATCH: fix building of 3.0.0-rc3 on powerpc and
Message-Id: <20071124103127.3d6ea720@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <473ECD90.5090603@hhs.nl>
In-Reply-To: <473ECD90.5090603@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 23 Nov 2007 20:52:20 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > There was an unrelated bug in etc/Module.mk, which your changes
> > uncovered. Sorry about that. It is fixed in SVN now, please give it a
> > try again. Your patch looks OK to me, so if no other problem arises,
> > please commit it to SVN.
> 
> Ah yes, your latest SVN commit makes my patch work and makes things compile 
> fine on i386, x86_64, ppc and pcc64, I've just commited my patch to svn.

Excellent, thank you. I'll release lm-sensors 3.0.0 later today after a
last round of testing on my machines!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

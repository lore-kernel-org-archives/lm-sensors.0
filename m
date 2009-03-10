From: Andre Prendel <andre_prendel@gmx.de>
Date: Tue, 10 Mar 2009 10:45:42 +0000
Subject: Re: [lm-sensors] [PATCH] sensord: Remove leading whitespaces in
Message-Id: <20090310104542.GB5543@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310083014.GA5543@ubuntu>
In-Reply-To: <20090310083014.GA5543@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 10, 2009 at 11:08:17AM +0100, Jean Delvare wrote:
> On Tue, 10 Mar 2009 09:30:14 +0100, Andre Prendel wrote:
> > Hi Jean,
> > 
> > as you noticed about my last patch series, there were some whitespaces
> > in the code. Unfortunately quilt complains only about trailing
> > whitespaces, not leading ones in empty lines. So there are some ones left.
> 
> That's pretty strange, I pretty much thought it did for me at least at
> some point in time...
> 
> > With this patch we get rid of the remaining ones.
> 
> Sure, please apply.

Applied.

Another question for you. How can I get rid of the committed patches
in quilt? Google don't give me much information about that. Once I
have committed the patches, I want to remove them from the series. I want
to remove them completly from quilt without unapplying the
changes. What's the right approach, do you know?

Thanks
Andre

> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

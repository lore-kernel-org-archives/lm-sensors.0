From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Apr 2009 08:45:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/8] sensord: Remove commandline interface.
Message-Id: <20090421104552.228c9602@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075618.GB4734@ubuntu>
In-Reply-To: <20090406075618.GB4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Apr 2009 09:35:33 +0200, Andre Prendel wrote:
> On Sun, Apr 19, 2009 at 09:39:54AM +0200, Jean Delvare wrote:
> > There are many other references to isDaemon left in the code, which
> > suggests that there is room for many additional cleanups. Are you going
> > to do this?
> 
> Will fix this in v2 too. What about the two occurrences at the
> beginning of parseArgs? I would prefer leaving that to inform the user
> about the change of the behaviour.

Yes, this is fine with me. We can remove them later, in a year or two.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

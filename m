From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 08:25:43 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <20071007102543.5591a678@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stian,

On Fri, 05 Oct 2007 21:13:37 +0200, Stian Jordet wrote:
> On fre, 2007-10-05 at 13:11 +0200, Stian Jordet wrote:
> > The voltages looks a little better (Probably still wrong, but I have no 
> > idea), but the temperatures were better earlier ;) But that might be 
> > another bug in lm-sensors with regard to bmc? Or is that an ipmisensors 
> > workaround to get past a lm-sensors bug that is now fixed?
> > 
> > I'll have to wait untill I'm back home to see if each sensor now 
> > corresponds to the right label in lm-sensors.
> 
> Hmm. I have now tested a little. The Voltages seems much better, but the
> fans are off excactly the same as with the old version. Is it possible
> that whatever fix you did only affected voltages? While it should have
> fixed also temperatures and fans? Because the fans were absolutely
> unaffected by the upgrade, and temperatures were excactly the same, but
> divided by 10.
>
> Looking at the source, it seems the only error was with voltages, so
> that doesn't seem to be the problem. Weird.

The fix indeed didn't affect the fans, only the voltages and the
temperatures, because the fan support was already OK in libsensors.
Most voltage channels were shifted by one, and most temperature
channels were not using the standard magnitude.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

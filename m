From: Stian Jordet <liste@jordet.net>
Date: Fri, 05 Oct 2007 19:13:37 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <1191611617.7443.22.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On fre, 2007-10-05 at 13:11 +0200, Stian Jordet wrote:
> The voltages looks a little better (Probably still wrong, but I have no 
> idea), but the temperatures were better earlier ;) But that might be 
> another bug in lm-sensors with regard to bmc? Or is that an ipmisensors 
> workaround to get past a lm-sensors bug that is now fixed?
> 
> I'll have to wait untill I'm back home to see if each sensor now 
> corresponds to the right label in lm-sensors.

Hmm. I have now tested a little. The Voltages seems much better, but the
fans are off excactly the same as with the old version. Is it possible
that whatever fix you did only affected voltages? While it should have
fixed also temperatures and fans? Because the fans were absolutely
unaffected by the upgrade, and temperatures were excactly the same, but
divided by 10. 

Looking at the source, it seems the only error was with voltages, so
that doesn't seem to be the problem. Weird.

I guess I (still) hope that Yani will figure it out.

Thanks for the tip, though :)

Regards,
Stian


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

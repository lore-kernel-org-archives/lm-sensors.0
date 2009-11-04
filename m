From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Nov 2009 09:11:12 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/8] sensord: Cleanup of the sensors
Message-Id: <20091104101112.4547ff8e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091103200144.GB4724@ubuntu>
In-Reply-To: <20091103200144.GB4724@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Tue, 3 Nov 2009 21:01:44 +0100, Andre Prendel wrote:
> Another week another patch series :)
> 
> There are two new patches. To make you happy I split up the change of
> the function pointer signature into a separate patch (5/8). Patch 7/8
> fixes the unhandled return value of idChip (see your comment in Patch
> v2 5/8). I've ignored the strcat() issue for now (also from v2 5/8). I
> hope I don't have missed one of the minor issues. The changes are
> explained in the patches too.
> 
> BTW thanks for your effort to review my patches.

You're welcome. I've made some more minor comments, but in general I
think your patch series is ready to be merged now. Go ahead!

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

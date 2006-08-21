From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Aug 2006 08:15:02 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060821101502.4b8690bc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David,

> > > Updated patch attached.
> >
> > Applied, thanks.
> 
> I guess moving forward, I'll finish the patch for the w83627ehf
> driver, but let's not include it until the i2c patch has had some time
> to be tested.

No need to be that cautious. If the test your added actually triggers,
it means something was broken in the first place so it won't constitute
a regression. And both patches will spend some time in -mm anyway, where
they will get some testing.

-- 
Jean Delvare


From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Mar 2011 07:56:31 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110303085631.53016c75@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302181651.GA24054@pengutronix.de>
	<48D3D52125C49B43AE880038E2E5314BB5BE6B@SRV101.gdsys.de>
In-Reply-To: <48D3D52125C49B43AE880038E2E5314BB5BE6B@SRV101.gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eibach, Dirk" <Eibach@gdsys.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, rdunlap@xenotime.net, linux-doc@vger.kernel.org

On Thu, 3 Mar 2011 08:49:13 +0100, Eibach, Dirk wrote:
>  
> 
> > Still, there is a new property defined which _always_ needs
> > 
> > a) CCing devicetree-discuss (get_maintainer helps here)
> > b) Documentation in Documentation/devicetree/bindings
> > 
> > because it needs to be a lot more stable than platform_data.
> 
> Jean, should I supply a v5 with Documentation or should I supply a
> separate patch?

Separate patch. I'm not even the one who will review and apply it.

> > (I already lost the original mail, so I sadly can't forward it)
> 
> I have forwarded it to devicetree-discuss.

This is where the review will happen, and where hopefully someone will
pick up the patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

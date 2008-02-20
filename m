From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Feb 2008 08:32:28 +0000
Subject: Re: [lm-sensors] adt7475 support status update?
Message-Id: <20080220093228.636f5767@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B32CEF.40405@hhs.nl>
In-Reply-To: <47B32CEF.40405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Feb 2008 09:21:01 +0100, Jean Delvare wrote:
> I fear that this change will affect pretty much all the hardware
> monitoring chips originally designed and sold by Analog Devices. Even
> the old ADM1022, ADM1024, ADM1026, ADM1027 etc. have been removed from
> the Analog Devices website. These 3 pages on the ON Semiconductor
> website seem to cover pretty much all the hardware monitoring chips of
> Analog Devices:
>   http://www.onsemi.com/PowerSolutions/parametrics.do?id!27
>   http://www.onsemi.com/PowerSolutions/parametrics.do?id!26
>   http://www.onsemi.com/PowerSolutions/parametrics.do?id!25

Note: it seems that the AD7xxx series of thermal sensor chips (in
particular the AD7414, AD7416, AD7417 and AD7418 which we support) is
still the property of Analog Devices, and "only" the ADM and ADT series
have been sold to ON Semiconductor.

> We will have to update all the links on the wiki/Devices pages, and
> ideally we would also update the references in the source code of all
> related drivers. This is a non-trivial amount of work, volunteers are
> welcome.

I have created a task in trac to that effect:
http://www.lm-sensors.org/ticket/2303

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

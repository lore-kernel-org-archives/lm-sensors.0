From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Aug 2007 08:02:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070821100254.06835618@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Mon, 20 Aug 2007 14:53:08 -0300, Henrique de Moraes Holschuh wrote:
> Is there a good reason why we couldn't rename the "isa" bus to "platform",
> then?  It is far more correct to call every hwmon ISA device a platform
> device, than to call every platform device an ISA device :p

Historical reasons, maybe. Users may be using the chip name filtering
feature of sensors(1) in scripts for example, renaming "isa" to
"platform" would break these for ISA/LPC chips. So the change would
make the upgrade path slightly more difficult.

I don't know if this reason is good enough to not do it, though. I
wonder what other developers and users think about the idea? Anyone
wants to argue in one direction or the other? This is the right time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

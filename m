From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 13:12:12 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <20081216141212.25494155@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chuan-kai, Hans,

On Mon, 15 Dec 2008 23:16:02 +0100, Hans de Goede wrote:
> Chuan-kai Lin wrote:
> >  3. The full-speed number seems to record the maximum measured fan speed
> >     instead of the maximum possible fan speed.

How would the hardware know what the maximum possible fan speed is? It
depends on the fan model.

> So this gets updated by hardware? This is not mentioned anywhere in the dcos, 
> but if that is the case that would be good!

Actually it is. On (printed) page 70: "The register is auto updated by
hardware when higher speed is detected."

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

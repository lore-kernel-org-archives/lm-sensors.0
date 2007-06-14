From: Max Baker <max@warped.org>
Date: Thu, 14 Jun 2007 15:33:48 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <20070614153348.GA26415@warped.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 13, 2007 at 11:17:34PM +0100, Phil Endecott wrote:
> I agree with your analysis, but note that the control components are 
> all marked "NC", which I imagine means "not connected", while the 0-ohm 
> link is not marked "NC".

You were correct -- all the fan control circuit devices are not on the
board, just the zero-ohm resistor.

Cheers,

-m

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

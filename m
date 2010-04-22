From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Apr 2010 07:27:34 +0000
Subject: Re: [lm-sensors] Driver for SMM665 power controller
Message-Id: <20100422092734.0d570cdd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100422031325.GA18460@ericsson.com>
In-Reply-To: <20100422031325.GA18460@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 Apr 2010 00:08:57 -0700, Guenter Roeck wrote:
> On Thu, Apr 22, 2010 at 02:54:05AM -0400, Jean Delvare wrote:
> > On Wed, 21 Apr 2010 20:13:25 -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > does anyone know if there is a driver for the SMM665/SMM766 power controllers ?
> > 
> > I don't know, but this isn't the right list to discuss this. lm-sensors
> > is about power monitoring (amongst other), not power control. Please
> > contact the power subsystem maintainers and list.
> > 
> Sorry, I should have been more specific. The chip provides "Power control and monitoring".
> 
> On the monitoring side, the chip provides 10 voltage monitor channels plus a temperature sensor. 
> 
> For a Linux driver, monitoring would be of interest, not control.
> It would probably not be a good idea to let SW change the voltage levels on a board.

Oh, OK. Then, yes, a hwmon driver would be welcome, and no, I don't
think anybody is working on it already.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Christopher Head <headch@gmail.com>
Date: Mon, 19 Mar 2012 21:01:39 +0000
Subject: Re: [lm-sensors] Intel DH55HC Sensors
Message-Id: <20120319140139.5d39d3db@ritchie.cs.ubc.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120314143659.0c1cf55d@ritchie.cs.ubc.ca>
In-Reply-To: <20120314143659.0c1cf55d@ritchie.cs.ubc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 14 Mar 2012 20:36:55 -0700
Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> On Wed, Mar 14, 2012 at 05:36:59PM -0400, Christopher Head wrote:
> > Hi,
> > I'm trying to get my DH55HC's sensors working. Detection indicates
> > w83627dhg-isa-0a10 as the device. According to the wiki at
> > <http://lm-sensors.org/wiki/VoltageLabelsAndScaling>, this chip is
> > capable of reading 8 mV/LSb. Here's the problem: the division ratio
> > doesn't make sense! In the BIOS, I observed the following values on
> > the 12 V rail:
> > 
> > 11.828
> > 11.844
> > 11.859
> > 
> > The difference between these values is 15 or 16 mV. But 12 V / 0.016
> > V/LSb = 750 LSb! Since these sensor chips don't read raw values
> > above 255, how in the world am I getting 16 mV resolution on a 12 V
> > input? I'm seeing similar results on my 5 V rail, which returns
> > values just 2 mV apart in the BIOS, and on my so-called "Memory
> > V_SM" rail (2 mV) and "+Vccp" rail (differences as small as 1 mV
> > being displayed).
> > 
> > Any ideas?
> > 
> The BIOS may get its voltages through HECI, which uses a different
> set of ADCs built into the H55 PCH.
> 
> Guenter

It's possible; I did see a mailing list message (on this list, in the
archives) explaining that the PCH is used for fan speed reporting on
this board. Is there any more recent news on PCH support in lm_sensors?
I don't have a lot of time but if it's a programming problem I may be
able to give some assistance.

Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Nov 2008 12:33:37 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118133337.109020ce@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Nov 2008 12:18:45 +0100, Andreas Herrmann wrote:
> On Tue, Nov 18, 2008 at 11:40:52AM +0100, Jean Delvare wrote:
> > The whole point of hardware monitoring is to report accurate values.
> >
> > Additional software can be used to take actions based on temperature
> > values, for example fan speed regulation or CPU frequency changes. If
> > you can't trust the temperature readings then these operations become
> > dangerous.
> 
> Then we need to blacklist it. The suggested workaround for this erratum is
> to use "temperature measurements from an analog thermal diode" for thermal
> control ...
> If the system should be designed not to rely on the thermal sensor
> (due to accuracy issue) the OS shouldn't use it either.

My point exactly.

> > That being said, I guess that the example above is essentially
> > theoretical? Most cases we've seen so far were not off by 5 degrees.
> > They were plain wrong, with reported temperatures being in the -20 to
> > +15 degrees C.
> 
> Was this observed with k8temp or other sensor chips?

k8temp. See my list of obviously incorrect values at:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024584.html

After seeing these values, I admit I had a smile when seeing how AMD
had formulated the errata (sensor doesn't meet a certain accuracy
threshold...)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

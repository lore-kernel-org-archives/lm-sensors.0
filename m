From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 08 Nov 2008 10:17:36 +0000
Subject: Re: [lm-sensors] Dell Optiplex / SMSC SCH5514 - testers wanted
Message-Id: <20081108111736.3e6fba0a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107215854.GK28501@mars.solarsys.private>
In-Reply-To: <20081107215854.GK28501@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Nice to see you back to business :)

On Fri, 7 Nov 2008 16:58:54 -0500, Mark M. Hoffman wrote:
> I have a partial data sheet for the SMSC SCH5514E, which I received with the
> help of Dell and my employer (NDAs all around).  I expect to be posting a basic
> driver for it very soon.
> 
> Looking through the list archives, I see that there was interest in supporting
> the SCH5514D almost a year ago[1].  From those emails I can see that the "D" has
> the identical device ID as the "E" on which I'm working.  I have asked for some
> clarification about the various chip ids and/or compatibility, we'll see how
> that turns out.
> 
> In the mean time, does anyone have access to a Dell Optiplex 745 (or something
> close to that) that would be willing to volunteer for further testing?  Please
> let me know to which model of machine you have access, and if possible, the
> precise part number of the SMSC superio chip.

The last guess we had made for the SCH5504 and SCH5514 was that they
did not include hardware monitoring features. If you have evidences
that this isn't true, please update wiki/Devices and sensors-detect
accordingly.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

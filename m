From: brian@rapsure.net (Brian Beardall)
Date: Sun, 20 Aug 2006 01:27:08 +0000
Subject: [lm-sensors] [PATCH] f75383 /f75384 driver
Message-Id: <1156037228.9993.3.camel@rapsure.rapsure.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1155997256.19938.6.camel@rapsure.rapsure.net>
In-Reply-To: <1155997256.19938.6.camel@rapsure.rapsure.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 2006-08-19 at 14:49 -0600, Jim Cromie wrote:
> Brian Beardall wrote:
> > I've been thinking about folding all of the duplicate functions. There
> > are quite a few because both temperature sensors behave exactly the
> > same, 
> ok - that confims my casual observation.
> 
> > and so they can be handled with one code execution line. Is there
> > a dev in lm_sensors to allow the change in read frequencies?
> >   
> 
> Im not sure what you mean here.
> Do you want some sensor reads to fetch *fresher* data than others ?
> 
> >>> +	struct f75383_data *data = f75383_update_device(dev);
> >>>       
> you could add a 2nd param to your update-device, allowing caller to 
> indicate desired freshness.
> or you could carve update_device for separate sensors, and fetch each
>  
> separately.
The entire device reads the temperature sensors depending on a a
register value. So I can make in read at different Hz, or I can also
make it only update when a call is made to the device. However I have it
setup for 15Hz update right now. 
> 
> 
> >> hth
> >> jimc
> >>     
> >
> >
> >   



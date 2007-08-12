From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 10:01:46 +0000
Subject: Re: [lm-sensors] Fujitsu-Siemens Scylla (fscscy)
Message-Id: <20070812120146.5da50cfd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46933578.3010701@miloi.de>
In-Reply-To: <46933578.3010701@miloi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 24 Jul 2007 16:40:08 +0200, Hans de Goede wrote:
> To me the almost the same and same register contents warrents using a unified 
> driver, especially since for example the voltage registers are on the same 
> place for all. However taking all these smalle register map differences 
> together, the easiest path for a unified driver is to use the lookup tables 
> above, and once the lookup tables are there, its really easy to keep the order 
> of the sensors in the fscscy as with the 2.4 driver. Let me know if you prefer 
> the hussled order, as that does make it clearer that they are one and the same 
> family of chips.

It's up to you, really, I don't care either way.

> > In general, I suggest that you avoid pushing in the kernel support for
> > random chips which are not known to be in use in real-world hardware.
> > Even if you maintain them yourself, you won't do it forever, and having
> > unused drivers only slows things down and lower the average quality. So
> > better pick chips from the Devices page where at least one user
> > requested support already (as the ADM1024, ADT7475/76, F75387SG/RG or
> > MAX6648/92.)
> 
> Good point, I fully agree and thanks for the input. I haven't checked all the 
> links on the device wiki yet, will do, but you don't happen to know motherboard 
> models which come with these chips do you? Or even better have a spare one you 
> can miss (I have a small budget for the labs, so I can pay for shipping + 
> something extra).

No, I don't. But the wiki/Devices page may have pointers to people with
such motherboards.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

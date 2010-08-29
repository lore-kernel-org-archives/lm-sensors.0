From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 Aug 2010 18:57:28 +0000
Subject: Re: [lm-sensors] Config file for Gigabyte MA785GM-US2H
Message-Id: <20100829205728.2876afcd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1281670026.2676.3.camel@honcho>
In-Reply-To: <1281670026.2676.3.camel@honcho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 29 Aug 2010 05:58:19 -0700, Glen wrote:
> Jean,
> 
> Sorry for the late response.  I based this off of a file called
> sensors-Gigabyte-965P-DS3.conf taken from here:
> 
> http://khali.linux-fr.org/devel/lm-sensors/sensors-Gigabyte-965P-DS3.conf
> 
> I found the reference here:
> 
> http://www.lm-sensors.org/ticket/2273
> 
> 
> Sorry about the date, and not correcting the comment about scaling,
> although I have to admit, scaling in0 is dubious.  I did it to make the
> lm-sensor readings match the BIOS readings, but the BIOS reading is
> somewhat high for an Athlon II X2 245 which should be 0.85 to 1.425 V
> from the specs I can find on the web.  Thanks for also pointing out the
> errors in setting the temp limits, I did bang this one out rather
> quickly.  Plus, I'm still not sure exactly sure what components the
> temps are really reading.
> 
> I've attached an updated file.

I updated the wiki, thank you!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

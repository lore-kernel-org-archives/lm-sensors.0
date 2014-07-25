From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 18:08:58 +0000
Subject: Re: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <20140725200858.165e60bb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
In-Reply-To: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Jul 2014 09:58:10 -0700, Guenter Roeck wrote:
> Is it possible that temp3 is the temperature reported by the CPU through
> PECI and the chip reports the raw PECI value for some reason ?

To be honest, I have no idea how good the PECI support if in the
w83627ehf driver. The technology was relatively recent back then.

I don't think it really matters here anyway, as we already have 2
sources for the CPU temperature, we wouldn't do much more with 3. And
it is perfectly plausible that temp3 is simply not used, so personally
I feel no urge to dig further.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

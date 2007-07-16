From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jul 2007 09:15:09 +0000
Subject: Re: [lm-sensors] Call for 2.10.4
Message-Id: <20070716111509.5ac741c3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625101648.511dc9c4@hyperion.delvare>
In-Reply-To: <20070625101648.511dc9c4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Jul 2007 23:07:27 +0200, Jean Delvare wrote:
> On Mon, 25 Jun 2007 10:16:48 +0200, Jean Delvare wrote:
> > We should start planning the release of lm-sensors 2.10.4. The list of
> > changes is getting long. We have Linux 2.4 support for the
> > W83627EHF/EHG, support for extra W83627EHF/EHG/DHG features (VID and
> > thermal sensor types), support for the dme1737 and applesmc chips, an
> > improved fancontrol script (needs testing!) and an updated
> > sensors-detect.
> > 
> > I propose the following schedule:
> > * July 8th: SVN freeze
> > * July 9th-15th: testing
> > * July 16th: release
> 
> We've seen many commits in the last week, in particular thanks to Hans
> de Goede, so there will be a lot of good things in this 2.10.4 release.
> I've just committed the last patches I had pending myself, so I declare
> the lm-sensors trunk frozen in SVN. I'll do as much testing as possible
> next week, and I invite everyone else to do so as well.

I am done with the testing. I've made some fixes to sensors-detect, and
minor documentation updates as well. Things look mostly OK to me now.
Phil, you can proceed with the release as your time permits.

Notes:
* libsensors version needs to be set to 3.1.4.
* No i2c release, only lm-sensors.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

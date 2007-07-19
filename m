From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Jul 2007 21:09:14 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] libsensors4: Optimize
Message-Id: <20070719230914.74946173@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070716152534.1755ba05@hyperion.delvare>
In-Reply-To: <20070716152534.1755ba05@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 16 Jul 2007 15:37:30 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Minor optimizations to sensors_feature_get_type():
> > * We no longer support any single type, so no need to handle this case.
> > * We can start looking for "_" at offset 3 rather than the beginning
> >   of the string (the shortest valid prefix is "in0", 3 characters.)
> 
> Nice cleanup!
> 
> I've checked the whole bunch of patches, and they look okay. Once you've 
> applied them to svn I'll do some testing to see if there are any regressions, 
> but I don't expect any,

Thanks for the review. I've committed the patches now. I hope to have
time for more interface cleanups during the next week-end.

My next victim will probably be sensors_get_ignored(), I see no valid
reason why each application has to care about ignore statements when
libsensors itself could hide the ignored chip features to start with.
I'm just not sure if the features should be skipped when the
application asks for the feature list, or even earlier, not inserted in
the feature list when walking the sysfs device directories.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 29 Jun 2007 18:25:38 +0000
Subject: Re: [lm-sensors] Do we need regex in libsensors?
Message-Id: <46854EA2.2090609@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070629190035.36806ea8@hyperion.delvare>
In-Reply-To: <20070629190035.36806ea8@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all, hi Hans,
> 
> I've made a performance regression test on the new libsensors. It shows
> a significant performance drop. Valgrind showed that almost half of the
> total CPU cycles were spent in sensors_feature_get_type(), and in
> particular in regexec(). Looking at what the code does, I don't think
> that we need the power of the regex engine; sscanf() should be enough.
> I've reimplemented the function using sscanf(), it seems to work just
> fine, and is much faster (although not yet as fast as the original, but
> I guess this is expected due to the dynamic feature gathering.)
> 

<snip>

> Is it OK to apply this, or does anyone have a good reason to believe
> that sscanf() won't be sufficient in some (present or future) case?
> 

The patch looks fine to me. I applied it over here and did some testing, I 
couldn't find any issues. So as far as I'm concerned its ok to apply.


Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Jul 2007 08:22:11 +0000
Subject: Re: [lm-sensors] Do we need regex in libsensors?
Message-Id: <20070703102211.4beb2348@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070629190035.36806ea8@hyperion.delvare>
In-Reply-To: <20070629190035.36806ea8@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 Jun 2007 20:25:38 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I've made a performance regression test on the new libsensors. It shows
> > a significant performance drop. Valgrind showed that almost half of the
> > total CPU cycles were spent in sensors_feature_get_type(), and in
> > particular in regexec(). Looking at what the code does, I don't think
> > that we need the power of the regex engine; sscanf() should be enough.
> > I've reimplemented the function using sscanf(), it seems to work just
> > fine, and is much faster (although not yet as fast as the original, but
> > I guess this is expected due to the dynamic feature gathering.)
> (...)
> 
> The patch looks fine to me. I applied it over here and did some testing, I 
> couldn't find any issues. So as far as I'm concerned its ok to apply.

OK, done. Thanks for testing.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

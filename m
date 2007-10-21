From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Oct 2007 19:08:02 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071021210802.0fa94014@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 21 Oct 2007 00:41:59 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Fri, 19 Oct 2007 22:18:02 +0200, Hans de Goede wrote:
> >> Ideally my first naive code should just work for simple applications which only 
> >> want to read the main / _input feature, I haven't checked yet, but I think 
> >> making my initial code work, doesn't match well with the current libsensors 
> >> structure, 
> > 
> > Indeed. Features and subfeatures are now separate entities. When I
> > proposed to do that change a few months ago, nobody objected.
> 
> I didn't understand back then that foo#_input would become a subfeature too, I 
> thought that would be part of the main feature.

That would have been a mess, I'm glad I didn't do that ;)

> (...)
> > First of all, please note that the main value in question may not
> > exist. Your code should be ready for it to happen.
> > 
> 
> Do features that do have tresholds / other settings but no reading of the 
> actual input exist?

As crazy as it sounds, yes, it exists. The early revisions of the
GL518SM report no voltage measurements, but have min and max voltage
settings and report alarms when those are crossed. Currently the
gl518sm driver reports 0 for the measurements in this case, but that's
not correct, it should not report them at all. I'll fix it.

> > My guess was that applications would need to switch on the feature type
> > anyway, as different types are usually displayed differently, so I
> > never considered this to be a problem. All of sensors, sensord and
> > xsensors do, I'm surprised that gkrellm doesn't. How does it display
> > the proper unit? How does it adjust the number of decimal places?
> 
> This is correct, there indeed is such a switch present, the code I postred was 
> simplified for the discussion. Still needing to make an additional function 
> call to get to the _input subfeature feels like a detour.
> 
> > I am also surprised that you call sensors_get_value() directly in the
> > loop that discovers the features. Applications which display values
> > continuously (as opposed to sensors' one-shot) tend to store the
> > feature numbers at initialization time, and then call
> > sensors_get_value() on them directly without looping over
> > sensors_get_features() again.
> 
> Actually you are right, the feature number gets remembered. (again I simplified 
> the code).
> 
> > Adding input_subfeature to struct sensors_subfeature is possible if it
> > helps you. It should be fairly easy. I'd just like to understand why
> > gkrellm's needs differ from the 3 applications I've ported myself.
> 
> Well it doesn't need it, but having it would make the code cleaner.

Well, if you already have a switch/case and store the subfeature
numbers, then a shortcut to get the input subfeature number doesn't save
that much, neither in terms of code nor in terms of speed. I don't
think it's worth adding.

> >> Besides that adding a define to sensors.h which can be tested to find out 
> >> against which libsensors version code is compiling would be a good idea too.
> > 
> > As the underlying build system needs to know what library will be used
> > (for proper linkage),
> 
> No it doesn't -lsensors will work for both linsensors3 and libsensors4 actually 
> the ./configure check for libsensors in gkrellm works with both without 
> modification (it checks for sensors/sensors.h && sensors_init()).

How do you deal with the case where both libsensors.so.3 and
libsensors.so.4 are available at link time?

> > I expected applications to deal with the
> > different versions on their own. But if you think that a #define in
> > sensors.h would help, just go ahead, that's fine with me.
> 
> Well as explained above ./configure and the Makefiles don't need to know about 
> the different versions, So only some code changes are needed, for which it 
> would be nice if a #define is present to test for.

As I said, just go ahead and add the #define you want. Feel free to add
the "same" #define to trunk if it helps.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

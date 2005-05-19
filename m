From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: tellerstats shell scripts from lm_sensors
Message-Id: <4140888C.4060806@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Thanks! I'll share this with the group.


Phil

Floyd L. Davidson wrote:
> Hello Phil,
> 
> I've been playing with the scripts from tellerstats (version
> 1.9.2, according to the README me file) distributed with
> lm_sensors.  In particular, I have a Linux based system running
> on a Tyan S2462 motherboard with dual AMD Athlon CPUs.
> 
> This Tyan motherboard has both a Winbond W83627HF Super IO chip
> with hardware sensors and a Winbond W83782D sensor chip, hence
> there is a great deal of useful information, and the graphs
> provided by the tellerstats scripts are just the ticket!  I'm
> running gather.sh every 2 minutes, and generating 21 plots with
> tellerstats every 10 minutes.
> 
> The plots are generated in three sizes.  One is a "thumbnail"
> similar to the distribution, but two larger images are created:
> one suitable for viewing at 800x600 resolution and one suitable
> for 1024x768 resolution (I mostly use Opera, at 120%
> magnification, on a 1289x1024 screen, so the images intended for
> a 1024x768 screen are just right.)
> 
> Of course it required significant modifications to the scripts
> to do what I wanted.  You may be interested in some of the
> differences.  An example of the graphs generated can be seen
> at
> 
>     <http://web.newsguy.com/floyd_davidson/stats/index.html
> 
> the modified scripts are at
> 
>     <http://web.newsguy.com/floyd_davidson/code/stats/index.html
> 
> A brief list of changes (both useful and not):
> 
>     gnuplotscript.tmpl
> 
>          This is where most of the significant hacking is.  I
>          spent a lot of time on small details...  how many tic
>          marks are display in each graph, the precise labels,
>          which colors and the size of lines used for each plot,
>          which line is "on top", location of the plot and the
>          range.  There are also lines plotted for maximum,
>          minimum, and normal values.
> 
>          The unfortunate side effect of carefully choosing
>          various colors and line widths is that the script
>          becomes significantly more complex.  However... as
>          an example for others to use it might be fairly
>          good just because it provides more examples of ways
>          to manipulate gnuplot.
> 
>          I *really* like the results!
>          
>     tellerstats.sh
> 
>          Changed the routines using convert and the way an
>          index.html file is generated.  convert is used to
>          generate a thumbnail and two (rather than one) larger
>          images.  A file "index.tmpl" is used to generate
>          "index.html" and "index1.html".  (I used sed rather
>          than perl which you would probably prefer.)  The
>          "thumbnail" images are kept as small as possible
>          to load quickly, but are large enough that when
>          displayed 2 across the graph is useful (the text
>          it pretty blurred).  The index.html file displays
>          well on Netscape running full screen on a 1024x768
>          window.  There is a clickable button to switch to
>          smaller images, displayed by index1.html, which
>          is suitable for Netscape on a 800x600 window.
> 
>     gather.sh
> 
>          Fetches data from multiple locations. I.e., it deals
>          with a motherboard that has two sensor chips.  This
>          may be useful as an example simply because it is
>          easier to delete what is unnecessary than it is to
>          add in what isn't there.
> 
>          I've used the "scale" option to bc to set the
>          precision of the calculated data points.
> 
>          Other modifications are probably *not* useful:
> 
>          I used awk rather than perl in most places... ;-)
> 
>          I used very different calculations to massage the data
>          for graphing.  The significance is that I want
>          indicative graphs...  and *none* of this data can be
>          considered either precision or accurate.  The
>          adjustments provided by Tyan in their example
>          sensors.conf file are probably closer to "accurate",
>          but for my purposes that isn't of much value (since I'm
>          not willing to make the effort to calibrate the
>          results).
> 
> 
> If any of this is useful...  it's all GPL'd and you are welcome
> to it!  And I thank you greatly (along with others who've added
> to it along the way) too.
> 
>      Have a good day,
>      Floyd
> 

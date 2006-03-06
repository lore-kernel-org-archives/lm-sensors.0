From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Mon, 06 Mar 2006 07:08:16 +0000
Subject: [lm-sensors] Proposal to individual alarm/beep sysfs files
Message-Id: <440BDFE0.8010806@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305231105.97f9085a.khali@linux-fr.org>
In-Reply-To: <20060305231105.97f9085a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>The original discussion was between per-type files versus per-channel
>files. I think we agreed that individual files were better, allowing a
>much cleaner implementation. Per-type files would require us to reorder
>all bits when the chip has them in a random order (which is most often
>the case, unfortunately). With per-channel files, we just have to
>extract the correct bit, which is easy. We can even use the same
>callback for all alarms, as demonstrated at the end of this post.
>
>Now, some chips offer more than one alarm for a given channel. For
>example the LM90/ADM1032 has a separate alarm for low limit crossed,
>high limit crossed and critical limit crossed. It was suggested that we
>could have non-boolean alarm files, and it makes some sense. However,
>on second though, it means that we would have to define a standard bit
>order inside such alarm files, and we'll have to build the contents
>from the registers. This won't be easier than having per-type files,
>which we said we did not want to do.
>
>So my new suggestion is to have per-limit alarm files for chips which
>implement things that way. This makes every alarm file a boolean. The
>only drawback I can think of is that we'll end up with many more sysfs
>files defined in each driver. However, the size increase seems to be
>acceptable, thanks to the dynamic sysfs callbacks and the array of
>attributes which we can use now.
>
>Fault conditions and beep masks can be handled exactly the same way.
>  
>

What about using strings in the alarm files instead of booleans?  Then 
you could report the *name* of the limit or condition causing the alarm 
(or alarms) or an empty string if there is no alarm?

When you look at the code in libsensors, it seems that alarms are almost 
always converted into text strings.  Why not move that code into the 
driver itself and then user-space tools would just print the contents of 
the ALARM file rather than having to parse the alarm file name to 
determine what limit or condition is causing the alarm or fault.

:v)




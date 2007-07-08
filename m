From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 21:11:27 +0000
Subject: Re: [lm-sensors] Call for 2.10.4
Message-Id: <469152FF.5020300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625101648.511dc9c4@hyperion.delvare>
In-Reply-To: <20070625101648.511dc9c4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Mon, 25 Jun 2007 10:16:48 +0200, Jean Delvare wrote:
>> We should start planning the release of lm-sensors 2.10.4. The list of
>> changes is getting long. We have Linux 2.4 support for the
>> W83627EHF/EHG, support for extra W83627EHF/EHG/DHG features (VID and
>> thermal sensor types), support for the dme1737 and applesmc chips, an
>> improved fancontrol script (needs testing!) and an updated
>> sensors-detect.
>>
>> I propose the following schedule:
>> * July 8th: SVN freeze
>> * July 9th-15th: testing
>> * July 16th: release
> 
> We've seen many commits in the last week, in particular thanks to Hans
> de Goede, so there will be a lot of good things in this 2.10.4 release.
> I've just committed the last patches I had pending myself, so I declare
> the lm-sensors trunk frozen in SVN. I'll do as much testing as possible
> next week, and I invite everyone else to do so as well.
> 
> Commits are of course still allowed to the lm-sensors-3.0.0 branch.
> 
> Phil, will you have the possibility to release lm-sensors 2.10.4 on
> July 16th?
> 

I would like to request an exception to the freeze to fix / improve the example 
configuration in sensors.conf.eg for the f71882fg, to be more precise I would 
like to replace the 2 ignore lines for fan2 and fan3 with 2 label lines, as you 
requested. If allowed I will do this first thing tomorrow morning.

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

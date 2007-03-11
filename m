From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 11 Mar 2007 14:17:18 +0000
Subject: [lm-sensors] libsensors patch to gkrellm - a report
Message-Id: <45F40F6E.3030500@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F1B914.6050706@hhs.nl>
In-Reply-To: <45F1B914.6050706@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 09 Mar 2007 20:44:20 +0100, Hans de Goede wrote:
>> Rudolf + Jean, would it be a good idea to write a patch for libsensors 
>> to make it automaticly set features not found in sysfs to ignore?
> 
> This should no longer be needed once we implement dynamic feature
> discovery in libsensors. If I had some time to work on libsensors, I'd
> rather spend it on reviewing these patches we already have than on
> additional workarounds to make the current design look less broken.
> 

True, I've already poked one of the students who has written the dynamic 
features support patches to get moving with regards to merging them. However 
this was a semester project and the semester is over. So I don't know how this 
will fare. If he doesn't get moving soon I'll jump in and start posting them 
for review and make the necessary fixes myself.

That still leaves the question where to put these patches. I myself don't 
really like the whole grand 3.0 scheme, because we are all really busy with 
other stuff and IMHO don't seem to have the manpower todo a whole new release, 
and also I don't see any improvements planned to warrant this version jump and 
more important to break ABI compatibility. libsensors API is not ideal, if we 
are going to break the API + ABI, then I would like to first see a redesign of 
said API. So I would rather see small incremental steps. For example putting 
dyn features detect in 2.10.x (or 2.12.0), but at first only for new chips, 
then check with 2.6 only chips, and remove those one at a time from the static 
list. An other small increment could be adding include directive support to 
sensors.conf. An other incremenuld be to put in #ifdef's around 2.4 compat / 
only code so that people who want to can build a version without 2.4 support.

Anyways I think I've made my preference clear. If you and Mark prefer doing a 
3.0 and putting new features there, then my student or I will start looking at 
the 3.0 svn branch and adjusting the patches as needed. So let me know what it 
will be.

Regards,

Hans



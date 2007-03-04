From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 04 Mar 2007 11:15:51 +0000
Subject: [lm-sensors] Call for 2.10.3
Message-Id: <45EAAA67.4050907@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070303171327.186cd0f4.khali@linux-fr.org>
In-Reply-To: <20070303171327.186cd0f4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> Please keep the list in copy...
> 

sorry, I'm still not used to the lm-sensors list default reply settings.

>> What about the:
>> -dynamic sysfs chip support
>> -get_sensor_type addition
>> -generic print suppoty in sensors the program
>>
>> A previous group of my students has been worming on, any chance some of 
>> those could make it, or maybe that we can start looking at them after 
>> the 19th?
> 
> I discussed this with Mark M. Hoffman and we agreed that this was
> lm-sensors 3.0 material. Mark is more or less in charge of the
> lm-sensors 3.0 tree, while I'm taking care of the current "stable"
> branch (2.10.x)
> 

Hmm, that doesn't make me happy, I told my students to not do any API 
changes, as the idea was to get this into 2.x somewhere, as I don't see 
3.0 happening anytime soon. Note that the all the patches only come into 
play when libsensors / sensors doesn't know howto handle a chip, so for 
existing cases nothing changes. (although I plan to remove abituguru 
support from 2.10 when my students code has proven to handle that well, 
and the same could be done for other 2.6 only chips).

Any chance you and Mark could reconcider, and this time do the 
discussion on the list so I get a chance to influence it?

Regards,

Hans


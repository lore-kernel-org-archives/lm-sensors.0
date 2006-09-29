From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 29 Sep 2006 07:45:07 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <451CCF03.3060002@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>> Is it still necessary to unlock the superio and if so could to explain why?
>> It looks like its not nescesarry as it works without it.
> 
> Well, if we write a driver for this chip, it's always better to get the
> address from the Super-I/O configuration address space, rather than
> hardcoding an arbitrary address. This lets us detect much more reliably
> whether the device is there or not, and also lets us deal with
> different addresses without user intervention.
> 

Ok,

I'm kinda new to this superio stuff, so I'm glad you and Rudolf are 
helping out.

Maybe I should make my relation to Hans Edgington clear. As you may know 
I'm a university Computer Science teacher and Hans E. is a student of 
mine. As part of his / her last year every student must work on a 
project for 1 day / week during 5 months. Normally the project 
assignments come from real companies, but when we don't have enough 
assignments the teacher(s) create assignments for these projects. After 
seeing the mail from Age Huisman on this I thought it would be a fun 
project for a student to write a driver for this sensors chip.

At first I thought this driver would be much like the uguru driver, but 
I see now with the superio stuff that it will be somewhat different, 
what would be a good driver to start with as a skeleton to base this 
driver on?

Also are there datasheets of similar (fintek) superio chips available 
somewhere, those could be of great help.

Regards,

Hans



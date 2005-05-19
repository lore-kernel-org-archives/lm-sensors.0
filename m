From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: CVS patch for lm85 fixes and EMC6D100 support
Message-Id: <3ED8C91D.1000408@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED78579.9030203@penguincomputing.com>
In-Reply-To: <3ED78579.9030203@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'd like to solicit volunteers to create a 2.6-compatible libsensors
right away. I don't think we can wait until 2.6.0 comes out to get started.
Anybody up for it? Can we put a request on our web page?
What do you guys think?


Greg KH wrote:
> On Fri, May 30, 2003 at 10:12:08AM -0700, Philip Pokorny wrote:
> 
>>I'm worried about the libsensors implementation for 2.5/2.6.  The switch to 
>>sysfs will mean a radical change to the libsensors implementation.  This 
>>may be a good time to address a number of issues (duplicated code in 
>>libsensors and prog/sensors, inflexible formating, integration of 
>>sensord/rrdb, etc) if we have to do a major re-write of the libsensors and 
>>sensors code.  Has anyone given any thought to this?
> 
> 
> I've looked at this, and agree, a radical change to the libsensors
> implementation seems to be in order.  I haven't spent any serious time
> yet on this, but will have the time after 2.6.0 comes out.
> 

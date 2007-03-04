From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Mar 2007 10:41:36 +0000
Subject: [lm-sensors] Call for 2.10.3
Message-Id: <20070304114136.27150bee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070303171327.186cd0f4.khali@linux-fr.org>
In-Reply-To: <20070303171327.186cd0f4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Please keep the list in copy...

On Sun, 04 Mar 2007 01:24:25 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > I fear we'll have to release 2.10.3 earlier than originally planed. The
> > sooner would be the better, in fact. Due to new i2c-core cleanups,
> > libsensors needs again to be updated to anticipate the kernel changes
> > and give our users (and distributions) a chance to upgrade user-space
> > before upgrading their kernel, so they won't break "sensors" and other
> > tools.
> > 
> > There is no bugfix pending as far as I know. If anyone thinks something
> > in particular needs to be committed before we release 2.10.3, please
> > speak up.
> > 
> > Release schedule could look like:
> > * March 11th: SVN freeze
> > * March 12th-18th: testing
> > * March 19th: release
> > 
> > As there was no changes made to the i2c repository since 2.10.2, this
> > will be a lm_sensors-release only (not that it makes much difference
> > anyway).
> 
> What about the:
> -dynamic sysfs chip support
> -get_sensor_type addition
> -generic print suppoty in sensors the program
> 
> A previous group of my students has been worming on, any chance some of 
> those could make it, or maybe that we can start looking at them after 
> the 19th?

I discussed this with Mark M. Hoffman and we agreed that this was
lm-sensors 3.0 material. Mark is more or less in charge of the
lm-sensors 3.0 tree, while I'm taking care of the current "stable"
branch (2.10.x)

> Either way I'll give those students a kick telling them to get moving on 
> getting their work presented here and integrated.

I agree that we are not very fair with your students which apprently
made a good job which we fail unfortunately failed to integrate
quickly. But well I can't work on everything at once, sorry. If you
want write access to the SVN repository to do it yourself, fine with
me, just ask.

-- 
Jean Delvare


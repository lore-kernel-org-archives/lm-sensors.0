From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 05 Oct 2006 13:00:04 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <20061005130004.GC28714@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C78622.8060808@hhs.nl>
In-Reply-To: <44C78622.8060808@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bob:

I apologize for the very late reply.

* Bob Schl?rmann <bob2 at dsv.nl> [2006-09-09 17:13:36 +0200]:
> Hans de Goede recently mentioned that he would put up a student project
> to let them work on some of the steps needed for generic chip support.
> I'm a student of Hans and together with 2 others we have taken on this
> project. All of us have experience in programming with Linux and
> we think we understand the problems libsensors is currently facing with
> adding support for new chipsets. We also realise that any code we
> release will be subject to the gpl.
> 
> We would first like to focus on steps 1 (use sysfs to discover a chip's
> features) and 3 (generic print routines in 'sensors'). The following are
> summaries of the objectives as we formulated them:
> 
> for step 1: modify the library so that it wil not be necessery anymore
> to add seperate support code into the library for newly supported chips.
> 
> step 3: modify the sensors tool print routines to add support for types
> of sensors instead of the current support for types of chips.
> 
> Our plan was to first begin with step 1 and release code for it as soon
> as possible, as to get an idea of how the cycle of releasing and
> testing goes. Later on we will begin with step 3.

Sounds good to me.  If you want, we can grant you SVN access provided that you
keep your work on a separate branch.

> One question we have is whether it is a good idea to work on step 3
> without dealing with step 2 (add sensor type info to structure) first.
> Because once step 2 is implemented, step 3 seems easier to accomplish.

I spoke to Jean Delvare about this on IRC[1].  We agreed that completing step 3
before step 2 has in fact some advantages of its own.  In particular, step 2
involves adding some functions to the libsensors API - it may be helpful to see
what the "users" need before finalizing that.  

Anyway, if that's the order you prefer, that's OK.

[1] #linux-sensors on irc.freenode.net

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



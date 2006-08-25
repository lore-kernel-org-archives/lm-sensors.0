From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 25 Aug 2006 08:31:36 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <20060825103136.2b18a7db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C78622.8060808@hhs.nl>
In-Reply-To: <44C78622.8060808@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Long story :)
> 
> I've just started in a new function, where I get to make up projects for
> small student groups todo in their final year of their Computer Science
> bachelor study. I'm going to define step 2 and 3 as a project for this I
> think. I know my Google SOC project hasn't been exactly a success, but
> work is still progressing on that. I'm expecting Ivan to post an update
> to you all soon.

I hope soo, too.

> Let me know if their is anything I should know before I put a bunch of
> students to work on this (3 students 12 hours / week for circa 15 weeks).

First of all, please make sure everything is clear with regards to code
ownership and licensing issues. Any code contributed to our project
must be GPL.

I would suggest that your students familiarize themselves with the
lm_sensors project before coding on it. They better be users of the
project first, find out how to get it to work on their specific
hardware, including the configuration file. Then they should subscribe
to this list and see the kind of issues we have. Only with this
background they will understand why we want to change the libsensors
concept fundamentally. And only if they understand why the change is
needed, they have a chance to get it right.

More manpower is always welcome :) If the students could even join the
project and stay for longer, that would be even better. There are so
many fixes, improvements, reviews etc. in my queue...

-- 
Jean Delvare


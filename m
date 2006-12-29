From: kronos.it@gmail.com (Luca)
Date: Fri, 29 Dec 2006 14:32:05 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <68676e00612290632w6a67db25g1397a114d8e31cf4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/28/06, Andrew Gaydenko <a at gaydenko.com> wrote:
> Hi, David!
>
> ==== On Thursday 28 December 2006 09:59, you wrote: ===> >
> >More information:
> >- thread http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018438.html
> >- message http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018443.html
> >
> ...
>
> OK, as for coretemp - will wait.

Btw, using /dev/cpuX/msr device you can read core temperatures, I just
copied the algorithm used by the kernel driver. Of course it's not
integrated with the rest of the hwmon subsystem...
If you're interested I can send you the source file as soon as I get
back to home.

Luca


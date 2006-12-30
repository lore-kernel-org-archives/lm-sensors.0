From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 30 Dec 2006 02:50:54 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <4dfa50520612291850j76604999hb4c63b431729e7b3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

It looks like there is some code in the kernel that could be extended
to provide MSR data for the coretemp driver--maybe you already know
about this?

> Btw, using /dev/cpuX/msr device you can read core temperatures, I just
> copied the algorithm used by the kernel driver. Of course it's not
> integrated with the rest of the hwmon subsystem...
> If you're interested I can send you the source file as soon as I get
> back to home.
>
> Luca

David


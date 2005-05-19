From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <8hMnOi4N.1112695779.6093240.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
In-Reply-To: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip, Grant,

> But the code that exists in the kernel sensor drivers today, checks the
> CPU, verifies which VRM standard applies to that rev of CPU and then
> produces the correct VID to voltage mapping automatically.

I would like to insist on this. The fact that vrm is writable is a legacy
of the past. There is no more reason to set the vrm value now that
Rudolf Marek added auto-detection stuff (which BTW should be ported back
to lm_sensors CVS).

Even exporting the VRM version to user-space makes little sense now. This
now only serves for debugging, but this would be more efficient to
simply print the VRM value in the logs at the moment we detect it.

--
Jean Delvare

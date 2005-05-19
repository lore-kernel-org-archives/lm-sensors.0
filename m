From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: lmsensors - separating userspace and kernel patch
Message-Id: <20031104201314.2ea6af4b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Do you have any plans for creating a 'sensor-utils' package with just
> the user-space tools for lm-sensors?
> 
> Would be nice and less confusing for 2.6 users....

First, we don't build packages. That task is left to, well... packagers.
And packagers are free to split our lm_sensors2 module in as many
packages as they want.

Second, userspace tools aren't ready for 2.6 yet anyway, although some
work has already been done to achive that.

Third, you can use "make user" and "make user_install" in lm_sensors2 to
build and install only the user-space tools.

That said, I agree that splitting our CVS module as a kernel module and
a user-space module would be great. But it is also a complex operation,
breaking developer's habits, making tracking changes harder, and so on.
For this reason, I doubt it'll be done soon, if ever. Maybe once there
is real user-space support for 2.6 kernels, we'll think of splitting,
who knows.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

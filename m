From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: sensors only as root?
Message-Id: <3ED8C9FA.3020809@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200305301509.00292.dave@nobodynet.net>
In-Reply-To: <200305301509.00292.dave@nobodynet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Very strange.
Haven't heard this one before.
You can check the permissions on /proc/sys/dev/sensors contents.
You can also try 'strace sensors' to try and see what's failing.
Most of the accesses are via sysctl calls.

Dave Smith wrote:
> Hi,
> 
> I've had a look through the docs / FAQ, but can't find the answer to my 
> question.
> 
> I've just set up lmsensors-2.7.0 on my machine, but I can only run sensors as 
> root.  I'm using the it87 module, and have also loaded i2c-proc, -dev and 
> -isa.  I have chmod'ed /dev/i2c0 and /dev/i2c-0 to be read/writable as my 
> non-root users, but I still only get "No sensors found!" when I run sensors 
> as a user other than root.
> 
> Can you tell me what permissions I may have to change in order to run sensors 
> as non-root users.  My other machine can do this with no problems, although 
> that uses different drivers, etc., plus I set it up 2 years ago and can't 
> remember if I needed to change any permissions on it to get it to work 
> properly.
> 
> Cheers,
> --Dave
> 
> 
